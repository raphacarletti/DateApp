import UIKit

struct Event {
    let image: UIImage?
    let name: String
    let startTime: String
    let url: String
    let venue: String
    let description: String
    let imgUrl: String
    let endTime: String
    let id: Int
    let status: String

    var formattedDate: String {
        let dateFormatterISO = ISO8601DateFormatter()
        guard let date = dateFormatterISO.date(from: startTime) else {
            return ""
        }
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "E MMM d • HH:mm a"
        return dateFomatter.string(from: date)
    }
}
