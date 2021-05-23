import Foundation

final class EventDetailWorker {
    func getRelatedEvents() -> [Event] {
        let dateFormatter = ISO8601DateFormatter()
        return [
            Event(image: .yogaClass, name: "Yoga Class", startTime: dateFormatter.string(from: Date()), url: "", venue: "Yoga class center", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eu commodo enim, dignissim fringilla lectus. Phasellus condimentum euismod justo, in sodales nulla efficitur quis. In enim metus, euismod tincidunt tortor vel, dignissim tempus odio. Quisque vestibulum lacus nunc, sit amet iaculis nulla placerat vel. Vivamus a egestas dolor. Curabitur vulputate.", imgUrl: "", endTime: "", id: 1, status: ""),
            Event(image: .cafeteria, name: "Cafeteria", startTime: dateFormatter.string(from: Date()), url: "", venue: "Chelsea", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eu commodo enim, dignissim fringilla lectus. Phasellus condimentum euismod justo, in sodales nulla efficitur quis. In enim metus, euismod tincidunt tortor vel, dignissim tempus odio. Quisque vestibulum lacus nunc, sit amet iaculis nulla placerat vel. Vivamus a egestas dolor. Curabitur vulputate.", imgUrl: "", endTime: "", id: 1, status: ""),
            Event(image: .veganCafeteria, name: "Vegan Cafeteira Opening", startTime: dateFormatter.string(from: Date()), url: "", venue: "Shoreditch", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eu commodo enim, dignissim fringilla lectus. Phasellus condimentum euismod justo, in sodales nulla efficitur quis. In enim metus, euismod tincidunt tortor vel, dignissim tempus odio. Quisque vestibulum lacus nunc, sit amet iaculis nulla placerat vel. Vivamus a egestas dolor. Curabitur vulputate.", imgUrl: "", endTime: "", id: 1, status: "")
        ]
    }
}
