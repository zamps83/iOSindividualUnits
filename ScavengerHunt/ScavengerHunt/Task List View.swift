import SwiftUI

struct TaskListView: View {
    @State private var tasks = [
        Task(title: "Find a Park", description: "Take a photo in the nearest park."),
        Task(title: "Spot a Dog", description: "Capture a photo of a dog."),
        Task(title: "Selfie with a Friend", description: "Take a selfie with a friend.")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach($tasks) { $task in
                    NavigationLink(destination: TaskDetailView(task: $task)) {
                        HStack {
                            Text(task.title)
                                .font(.headline)
                            Spacer()
                            if task.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Scavenger Hunt")
        }
    }
}
