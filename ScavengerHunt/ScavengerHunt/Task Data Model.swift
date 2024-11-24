import Foundation
import CoreLocation
import UIKit

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var isCompleted: Bool = false
    var attachedPhoto: UIImage? = nil
    var photoLocation: CLLocationCoordinate2D? = nil
}
