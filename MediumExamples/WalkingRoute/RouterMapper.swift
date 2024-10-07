import SwiftUI
import MapKit
import CoreLocation

// MARK: - Enums and Structs

// Enum for Route Distance Type
enum RouteDistanceType: String, CaseIterable, Identifiable {
  case short = "Short"
  case medium = "Medium"
  case long = "Long"

  var id: String { self.rawValue }

  // Desired distance in meters
  var desiredDistance: CLLocationDistance {
    switch self {
    case .short:
      return 1000 // 1 km
    case .medium:
      return 5000 // 5 km
    case .long:
      return 10000 // 10 km
    }
  }
}

// Struct for Route Option
struct RouteOption: Identifiable {
  let id = UUID()
  let distanceType: RouteDistanceType
  let polyline: MKPolyline
  let distance: CLLocationDistance  // Distance in meters

  // Computed property to get stroke color based on distance type
  var strokeColor: UIColor {
    switch distanceType {
    case .short:
      return UIColor.green
    case .medium:
      return UIColor.purple
    case .long:
      return UIColor.red
    }
  }
}

// ErrorMessage Struct
struct ErrorMessage: Identifiable {
  let id = UUID()
  let message: String
}

// MARK: - Location Manager

// Location Manager to Handle Permissions and Location Updates
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  private let locationManager = CLLocationManager()

  @Published var userLocation: CLLocationCoordinate2D?
  private var lastUpdatedLocation: CLLocationCoordinate2D?
  private let updateThreshold: CLLocationDistance = 50 // meters

  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.distanceFilter = 50 // Update every 50 meters
    requestLocationPermission()
  }

  func requestLocationPermission() {
    locationManager.requestWhenInUseAuthorization()
  }

  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      print("Location access granted.")
      locationManager.requestLocation()
    case .denied, .restricted:
      print("Location access denied or restricted.")
    default:
      break
    }
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Failed to get user location: \(error.localizedDescription)")
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      if let lastLocation = lastUpdatedLocation {
        let distance = CLLocation(latitude: lastLocation.latitude, longitude: lastLocation.longitude)
          .distance(from: CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
        if distance < updateThreshold {
          // Ignore insignificant movements
          return
        }
      }
      lastUpdatedLocation = location.coordinate
      DispatchQueue.main.async {
        self.userLocation = location.coordinate
      }
    }
  }
}

// MARK: - SwiftUI Views

// SwiftUI View to Display Routes
struct RoutesMapView: View {
  @StateObject private var locationManager = LocationManager()
  @State private var routes: [RouteOption] = []
  @State private var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
  )
  @State private var isLoading = false
  @State private var errorMessage: ErrorMessage?
  @State private var selectedDistanceType: RouteDistanceType?
  @State private var routeDistanceInMiles: Double?

  var body: some View {
    VStack {
      if let userLocation = locationManager.userLocation {
        VStack {
          Text("Select a route distance:")
            .font(.headline)
            .padding(.top)

          HStack {
            ForEach(RouteDistanceType.allCases) { distanceType in
              Button(action: {
                selectRoute(distanceType: distanceType)
              }) {
                Text(distanceType.rawValue)
                  .padding()
                  .frame(maxWidth: .infinity)
                  .background(selectedDistanceType == distanceType ? Color.gray.opacity(0.3) : Color.clear)
                  .cornerRadius(8)
              }
            }
          }
          .padding([.leading, .trailing])

          if isLoading {
            ProgressView("Generating route...")
              .padding()
          } else if let route = routes.first {
            MapViewWrapper(region: $region, routes: [route])
              .edgesIgnoringSafeArea(.all)

            // Display the route distance in miles
            if let distanceInMiles = routeDistanceInMiles {
              Text(String(format: "Route Distance: %.2f miles", distanceInMiles))
                .font(.headline)
                .padding()
            }
          } else {
            Text("No route selected.")
              .padding()
          }
        }
      } else {
        Text("Waiting for location...")
          .padding()
      }
    }
    .alert(item: $errorMessage) { error in
      Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
    }
    .onAppear {
      // Request location when the view appears
      locationManager.requestLocationPermission()
    }
  }

  // Function to handle route selection
  func selectRoute(distanceType: RouteDistanceType) {
    guard let userLocation = locationManager.userLocation else { return }
    selectedDistanceType = distanceType
    isLoading = true
    DispatchQueue.global(qos: .userInitiated).async {
      generateRouteOption(
        distanceType: distanceType,
        startingLocation: userLocation
      ) { result in
        DispatchQueue.main.async {
          switch result {
          case .success(let routeOption):
            self.routes = [routeOption]
            self.routeDistanceInMiles = routeOption.distance / 1609.34 // Convert meters to miles
            adjustRegion()
          case .failure(let error):
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
          }
          self.isLoading = false
        }
      }
    }
  }

  // Adjust the region to fit the selected route and user location
  private func adjustRegion() {
    guard let route = routes.first else { return }
    var allCoordinates = route.polyline.coordinates
    if let userLocation = locationManager.userLocation {
      allCoordinates.append(userLocation)
    }
    guard !allCoordinates.isEmpty else { return }
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
struct MapViewWrapper: UIViewRepresentable {
  @Binding var region: MKCoordinateRegion
  var routes: [RouteOption]

  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
    mapView.setRegion(region, animated: false)
    return mapView
  }

  func updateUIView(_ mapView: MKMapView, context: Context) {
    mapView.setRegion(region, animated: true)

    // Remove existing overlays
    mapView.removeOverlays(mapView.overlays)

    // Add new overlays
    mapView.addOverlays(routes.map { $0.polyline })
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapViewWrapper

    init(_ parent: MapViewWrapper) {
      self.parent = parent
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      if let polyline = overlay as? MKPolyline {
        let renderer = MKPolylineRenderer(polyline: polyline)

        // Find the corresponding RouteOption
        if let routeOption = parent.routes.first(where: { $0.polyline === polyline }) {
          renderer.strokeColor = routeOption.strokeColor
        } else {
          renderer.strokeColor = UIColor.gray
        }

        renderer.lineWidth = 3
        return renderer
      }
      return MKOverlayRenderer(overlay: overlay)
    }
  }
}

// MARK: - Helper Functions and Extensions

// Generate a single circular route by creating waypoints around the starting location
func generateRouteOption(distanceType: RouteDistanceType, startingLocation: CLLocationCoordinate2D, completion: @escaping (Result<RouteOption, Error>) -> Void) {
  let desiredDistance = distanceType.desiredDistance
  let waypointCount = 5 // Number of waypoints to form the circular route
  let radius = desiredDistance / 2 // Radius for generating waypoints around the starting location

  // Generate random waypoints around the starting location
  let waypoints = (0..<waypointCount).map { _ in
    randomCoordinate(around: startingLocation, within: radius)
  }

  // Create circular route by connecting all waypoints and returning to the starting location
  var coordinates: [CLLocationCoordinate2D] = [startingLocation] + waypoints + [startingLocation]

  var allCoordinates: [CLLocationCoordinate2D] = []
  var totalDistance: CLLocationDistance = 0
  let group = DispatchGroup()

  for i in 0..<coordinates.count - 1 {
    let request = MKDirections.Request()
    request.source = MKMapItem(placemark: MKPlacemark(coordinate: coordinates[i]))
    request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinates[i + 1]))
    request.transportType = .walking
    request.requestsAlternateRoutes = false

    let directions = MKDirections(request: request)
    group.enter()
    directions.calculate { response, error in
      if let error = error {
        completion(.failure(error))
        group.leave()
        return
      }

      if let route = response?.routes.first {
        allCoordinates.append(contentsOf: route.polyline.coordinates)
        totalDistance += route.distance
      }
      group.leave()
    }
  }

  group.notify(queue: .main) {
    guard !allCoordinates.isEmpty else {
      completion(.failure(NSError(domain: "RouteGeneration", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to generate route"])))
      return
    }

    // Combine all route polylines to form a circular route
    let polyline = MKPolyline(coordinates: allCoordinates, count: allCoordinates.count)
    let routeOption = RouteOption(distanceType: distanceType, polyline: polyline, distance: totalDistance)
    completion(.success(routeOption))
  }
}

// Generate a random coordinate within a certain radius
func randomCoordinate(around coordinate: CLLocationCoordinate2D, within radius: CLLocationDistance) -> CLLocationCoordinate2D {
  let earthRadius = 6371000.0 // in meters

  // Convert radius from meters to degrees
  let radiusInDegrees = radius / earthRadius * (180 / .pi)

  let u = Double.random(in: 0...1)
  let v = Double.random(in: 0...1)
  let w = radiusInDegrees * sqrt(u)
  let t = 2 * .pi * v
  let x = w * cos(t)
  let y = w * sin(t)

  let newLat = coordinate.latitude + y
  let newLon = coordinate.longitude + x / cos(coordinate.latitude * .pi / 180)

  return CLLocationCoordinate2D(latitude: newLat, longitude: newLon)
}

// MKPolyline Extension
extension MKPolyline {
  var coordinates: [CLLocationCoordinate2D] {
    var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: pointCount)
    getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
    return coords
  }
}

// MARK: - Preview Provider
#Preview {
  RoutesMapView()
}
