import SwiftUI

@MainActor
class TaskViewModel: ObservableObject {
  @Published var tasks: [TaskManager.TaskItem] = []
  private let taskManager = TaskManager()

  func fetchTasks() async {
    tasks = await taskManager.getTasks()
  }

  func addTask(title: String) async {
    await taskManager.addTask(title: title)
    await fetchTasks()
  }

  func toggleTaskCompletion(id: UUID) async {
    await taskManager.toggleTaskCompletion(id: id)
    await fetchTasks()
  }

  func deleteTask(id: UUID) async {
    await taskManager.deleteTask(id: id)
    await fetchTasks()
  }
}
