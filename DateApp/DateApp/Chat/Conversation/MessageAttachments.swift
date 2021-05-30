import Foundation
import StreamChat

struct EventAttachment: AttachmentEnvelope, Codable {
    var type: AttachmentType = .custom("event")

    let event: Event
}
