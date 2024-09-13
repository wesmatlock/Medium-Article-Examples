import SwiftUI
import MapKit
import CoreLocation

// Enum for Route Distance Type
enum RouteDistanceType {
  case short, medium, long
}

// Struct for Route Option
struct RouteOption: Identifiable {
  let id = UUID()
  let distanceType: RouteDistanceType
  let polyline: MKPolyline
}

// Location Manager to Handle Permissions and Location Updates
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  private let locationManager = CLLocationManager()

  @Published var userLocation: CLLocationCoordinate2D?

  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    requestLocationPermission()
  }

  private func requestLocationPermission() {
    locationManager.requestWhenInUseAuthorization()
  }

  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      print("Location access granted.")
      locationManager.startUpdatingLocation()
    case .denied, .restricted:
      print("Location access denied or restricted.")
    default:
      break
    }
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      DispatchQueue.main.async {
        self.userLocation = location.coordinate
      }
    }
  }
}

// SwiftUI View to Display Routes
struct RoutesMapView: View {
  @StateObject private var locationManager = LocationManager()
  @State private var routes: [RouteOption] = []
  @State private var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
  )
  @State private var userTrackingMode: MapUserTrackingMode = .follow  // User tracking mode state

  var body: some View {
    VStack {
      if let userLocation = locationManager.userLocation {
        // Use MKMapViewWrapper to manage overlays directly
        MKMapViewWrapper(region: $region, routes: routes)
          .onAppear {
            region.center = userLocation
            Task {
              let generatedRoutes = await generateCircularRoutes(from: userLocation)
              DispatchQueue.main.async {
                self.routes = generatedRoutes
                adjustRegion()
              }
            }
          }
      } else {
        Text("Waiting for location...")
          .padding()
      }
    }
  }

  // Adjust the region to fit all routes
  private func adjustRegion() {
    guard !routes.isEmpty else { return }
    let allCoordinates = routes.flatMap { $0.polyline.coordinates }
    let latitudes = allCoordinates.map { $0.latitude }
    let longitudes = allCoordinates.map { $0.longitude }

    let minLat = latitudes.min()!
    let maxLat = latitudes.max()!
    let minLon = longitudes.min()!
    let maxLon = longitudes.max()!

    let centerLat = (minLat + maxLat) / 2
    let centerLon = (minLon + maxLon) / 2
    let span = MKCoordinateSpan(
      latitudeDelta: (maxLat - minLat) * 1.2,
      longitudeDelta: (maxLon - minLon) * 1.2
    )
    region = MKCoordinateRegion(
      center: CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon),
      span: span
    )
  }
}

// MKMapViewWrapper for better control over MKMapView
struct MKMapViewWrapper: UIViewRepresentable {
  @Binding var region: MKCoordinateRegion
  var routes: [RouteOption]

  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator
    mapView.setRegion(region, animated: true)
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
    return mapView
  }

  func updateUIView(_ mapView: MKMapView, context: Context) {
    mapView.setRegion(region, animated: true)
    mapView.removeOverlays(mapView.overlays)  // Clear existing overlays
    let polylines = routes.map { $0.polyline }
    mapView.addOverlays(polylines)
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MKMapViewWrapper

    init(_ parent: MKMapViewWrapper) {
      self.parent = parent
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      if let polyline = overlay as? MKPolyline {
        let renderer = MKPolylineRenderer(polyline: polyline)
        let routeOption = parent.routes.first { $0.polyline == polyline }
        renderer.strokeColor = UIColor(routeOption?.distanceType == .short ? .green : routeOption?.distanceType == .medium ? .orange : .red)
        renderer.lineWidth = 3
        return renderer
      }
      return MKOverlayRenderer(overlay: overlay)
    }
  }
}

// Helper Functions and Extensions
func generateCircularRoutes(from startingLocation: CLLocationCoordinate2D) async -> [RouteOption] {
  let distancesInMiles: [RouteDistanceType: CLLocationDistance] = [
    .short: 0.5,   // Half a mile radius for a short route
    .medium: 2.0,  // 2 miles radius for a medium route
    .long: 4.0     // 4 miles radius for a long route
  ]

  var routeOptions: [RouteOption] = []

  // Loop through each distance type
  for (distanceType, radiusInMiles) in distancesInMiles {
    let waypoints = createWaypointsAround(location: startingLocation, radius: radiusInMiles * 1609.34) // Convert miles to meters
    var routePolylines: [MKPolyline] = []

    // Calculate routes between consecutive waypoints
    for i in 0..<waypoints.count {
      let source = waypoints[i]
      let destination = i == waypoints.count - 1 ? startingLocation : waypoints[i + 1] // Loop back to starting point

      let directionsRequest = MKDirections.Request()
      directionsRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: source))
      directionsRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
      directionsRequest.transportType = .walking
      directionsRequest.requestsAlternateRoutes = false

      let directions = MKDirections(request: directionsRequest)

      do {
        let response = try await directions.calculate()
        if let route = response.routes.first {
          routePolylines.append(route.polyline)
        }
      } catch {
        print("Error calculating route: \(error.localizedDescription)")
      }
    }

    // Combine all polylines into a single polyline to represent the complete route
    if !routePolylines.isEmpty {
      let combinedPolyline = combinePolylines(routePolylines)
      routeOptions.append(RouteOption(distanceType: distanceType, polyline: combinedPolyline))
    }
  }

  return routeOptions
}

func combinePolylines(_ polylines: [MKPolyline]) -> MKPolyline {
  let coordinates = polylines.flatMap { $0.coordinates }
  return MKPolyline(coordinates: coordinates, count: coordinates.count)
}

func createWaypointsAround(location: CLLocationCoordinate2D, radius: CLLocationDistance, numberOfWaypoints: Int = 8) -> [CLLocationCoordinate2D] {
  var waypoints: [CLLocationCoordinate2D] = []
  let earthRadius: CLLocationDistance = 6371000  // Radius of Earth in meters

  // Calculate the angular distance in radians
  let angularDistance = radius / earthRadius

  for i in 0..<numberOfWaypoints {
    // Calculate the angle for each waypoint
    let bearing = Double(i) * (2 * .pi / Double(numberOfWaypoints))

    // Convert latitude and longitude to radians
    let lat1 = location.latitude * .pi / 180
    let lon1 = location.longitude * .pi / 180

    // Calculate new latitude
    let lat2 = asin(sin(lat1) * cos(angularDistance) + cos(lat1) * sin(angularDistance) * cos(bearing))

    // Calculate new longitude
    let lon2 = lon1 + atan2(sin(bearing) * sin(angularDistance) * cos(lat1), cos(angularDistance) - sin(lat1) * sin(lat2))

    // Convert back to degrees
    let waypoint = CLLocationCoordinate2D(latitude: lat2 * 180 / .pi, longitude: lon2 * 180 / .pi)
    waypoints.append(waypoint)
  }

  return waypoints
}

extension MKPolyline {
  var coordinates: [CLLocationCoordinate2D] {
    var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: pointCount)
    getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
    return coords
  }
}
