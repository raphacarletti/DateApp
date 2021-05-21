import UIKit

class ExternalLinksUtils {
    static func openGoogleMaps(with venue: String) {
        let venueWithPlus = venue.split(separator: " ").joined(separator: "+")
        if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
            UIApplication.shared.open(URL(string:"comgooglemaps://?q=\(venueWithPlus)")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=\(venueWithPlus)")!, options: [:], completionHandler: nil)
        }
    }
}
