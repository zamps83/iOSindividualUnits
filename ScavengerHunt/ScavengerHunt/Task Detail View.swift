import SwiftUI
import MapKit

struct TaskDetailView: View {
    @Binding var task: Task
    @State private var showingPhotoPicker = false
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default location
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        VStack(spacing: 20) {
            Text(task.description)
                .font(.headline)
                .padding()
            
            if let photo = task.attachedPhoto {
                Image(uiImage: photo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Button("Attach Photo") {
                    showingPhotoPicker = true
                }
                .buttonStyle(.borderedProminent)
            }
            
            if let location = task.photoLocation {
                let identifiableLocation = IdentifiableCoordinate(coordinate: location)
                
                Map(coordinateRegion: $region, annotationItems: [identifiableLocation]) { item in
                    MapPin(coordinate: item.coordinate)
                }
                .frame(height: 200)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(task.title)
        .sheet(isPresented: $showingPhotoPicker) {
            PhotoPicker(task: $task, region: $region)
        }
    }
}
