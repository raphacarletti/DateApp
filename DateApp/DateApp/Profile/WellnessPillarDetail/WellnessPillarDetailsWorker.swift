import Foundation

final class WellnessPillarDetailsWorker {
    func getEvents() -> [Event] {
        let dateFormatter = ISO8601DateFormatter()
        return [
            Event(name: "Yoga Class", startTime: dateFormatter.string(from: Date()), url: "", venue: "Yoga class center", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eu commodo enim, dignissim fringilla lectus. Phasellus condimentum euismod justo, in sodales nulla efficitur quis. In enim metus, euismod tincidunt tortor vel, dignissim tempus odio. Quisque vestibulum lacus nunc, sit amet iaculis nulla placerat vel. Vivamus a egestas dolor. Curabitur vulputate.", imgUrl: "https://colunadogilson.com.br/cac/wp-content/uploads/cafeteria.jpg", endTime: "", id: 1, status: ""),
            Event(name: "Cafeteria", startTime: dateFormatter.string(from: Date()), url: "", venue: "Chelsea", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eu commodo enim, dignissim fringilla lectus. Phasellus condimentum euismod justo, in sodales nulla efficitur quis. In enim metus, euismod tincidunt tortor vel, dignissim tempus odio. Quisque vestibulum lacus nunc, sit amet iaculis nulla placerat vel. Vivamus a egestas dolor. Curabitur vulputate.", imgUrl: "https://colunadogilson.com.br/cac/wp-content/uploads/cafeteria.jpg", endTime: "", id: 2, status: ""),
            Event(name: "Vegan Cafeteira Opening", startTime: dateFormatter.string(from: Date()), url: "", venue: "Shoreditch", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eu commodo enim, dignissim fringilla lectus. Phasellus condimentum euismod justo, in sodales nulla efficitur quis. In enim metus, euismod tincidunt tortor vel, dignissim tempus odio. Quisque vestibulum lacus nunc, sit amet iaculis nulla placerat vel. Vivamus a egestas dolor. Curabitur vulputate.", imgUrl: "https://colunadogilson.com.br/cac/wp-content/uploads/cafeteria.jpg", endTime: "", id: 3, status: "")
        ]
    }

    func getBenefits() -> [Event] {
        let dateFormatter = ISO8601DateFormatter()
        return [
            Event(name: "Yoga Class", startTime: dateFormatter.string(from: Date()), url: "", venue: "Yoga class center", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eu commodo enim, dignissim fringilla lectus. Phasellus condimentum euismod justo, in sodales nulla efficitur quis. In enim metus, euismod tincidunt tortor vel, dignissim tempus odio. Quisque vestibulum lacus nunc, sit amet iaculis nulla placerat vel. Vivamus a egestas dolor. Curabitur vulputate.", imgUrl: "https://i.imgur.com/B3Xh6UR.jpg", endTime: "", id: 1, status: ""),
            Event(name: "Cafeteria", startTime: dateFormatter.string(from: Date()), url: "", venue: "Chelsea", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eu commodo enim, dignissim fringilla lectus. Phasellus condimentum euismod justo, in sodales nulla efficitur quis. In enim metus, euismod tincidunt tortor vel, dignissim tempus odio. Quisque vestibulum lacus nunc, sit amet iaculis nulla placerat vel. Vivamus a egestas dolor. Curabitur vulputate.", imgUrl: "https://i.imgur.com/B3Xh6UR.jpg", endTime: "", id: 2, status: ""),
            Event(name: "Vegan Cafeteira Opening", startTime: dateFormatter.string(from: Date()), url: "", venue: "Shoreditch", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eu commodo enim, dignissim fringilla lectus. Phasellus condimentum euismod justo, in sodales nulla efficitur quis. In enim metus, euismod tincidunt tortor vel, dignissim tempus odio. Quisque vestibulum lacus nunc, sit amet iaculis nulla placerat vel. Vivamus a egestas dolor. Curabitur vulputate.", imgUrl: "https://i.imgur.com/B3Xh6UR.jpg", endTime: "", id: 3, status: "")
        ]
    }

    func getContent() -> [Event] {
        let dateFormatter = ISO8601DateFormatter()
        return [
            Event(name: "Yoga Class", startTime: dateFormatter.string(from: Date()), url: "", venue: "Yoga class center", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eu commodo enim, dignissim fringilla lectus. Phasellus condimentum euismod justo, in sodales nulla efficitur quis. In enim metus, euismod tincidunt tortor vel, dignissim tempus odio. Quisque vestibulum lacus nunc, sit amet iaculis nulla placerat vel. Vivamus a egestas dolor. Curabitur vulputate.", imgUrl: "https://cdn.shopify.com/s/files/1/1728/2157/articles/Me_class_Blog.jpg?v=1552683610", endTime: "", id: 1, status: ""),
            Event(name: "Cafeteria", startTime: dateFormatter.string(from: Date()), url: "", venue: "Chelsea", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eu commodo enim, dignissim fringilla lectus. Phasellus condimentum euismod justo, in sodales nulla efficitur quis. In enim metus, euismod tincidunt tortor vel, dignissim tempus odio. Quisque vestibulum lacus nunc, sit amet iaculis nulla placerat vel. Vivamus a egestas dolor. Curabitur vulputate.", imgUrl: "https://cdn.shopify.com/s/files/1/1728/2157/articles/Me_class_Blog.jpg?v=1552683610", endTime: "", id: 2, status: ""),
            Event(name: "Vegan Cafeteira Opening", startTime: dateFormatter.string(from: Date()), url: "", venue: "Shoreditch", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eu commodo enim, dignissim fringilla lectus. Phasellus condimentum euismod justo, in sodales nulla efficitur quis. In enim metus, euismod tincidunt tortor vel, dignissim tempus odio. Quisque vestibulum lacus nunc, sit amet iaculis nulla placerat vel. Vivamus a egestas dolor. Curabitur vulputate.", imgUrl: "https://cdn.shopify.com/s/files/1/1728/2157/articles/Me_class_Blog.jpg?v=1552683610", endTime: "", id: 3, status: "")
        ]
    }
}
