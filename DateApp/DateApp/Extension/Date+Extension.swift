import Foundation

extension Date {
    var hourAndMinutes: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }

    var notificationHeaderFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E dd MMM"
        return dateFormatter.string(from: self)
    }
}
