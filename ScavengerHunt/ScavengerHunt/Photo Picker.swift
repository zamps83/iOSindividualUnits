import SwiftUI
import PhotosUI
import CoreLocation
import MapKit

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var task: Task
    @Binding var region: MKCoordinateRegion
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(task: $task, region: $region)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        @Binding var task: Task
        @Binding var region: MKCoordinateRegion
        
        init(task: Binding<Task>, region: Binding<MKCoordinateRegion>) {
            _task = task
            _region = region
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        if let uiImage = image as? UIImage {
                            self.task.attachedPhoto = uiImage
                            self.task.isCompleted = true
                            
                            // Simulating location metadata
                            let sampleCoordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
                            self.task.photoLocation = sampleCoordinate
                            self.region.center = sampleCoordinate
                        }
                    }
                }
            }
        }
    }
}
