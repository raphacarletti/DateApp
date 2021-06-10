import Foundation

struct AppNotification {
    enum ActionType {
        case seeMore
        case chat
    }

    let title: String
    let imgUrl: String
    let action: ActionType
    let date: Date
}
