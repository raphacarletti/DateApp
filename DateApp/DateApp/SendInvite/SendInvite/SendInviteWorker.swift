import Foundation

final class SendInviteWorker {
    func getProfiles() -> [[Profile]] {
        return [
            [Profile(name: "Jess", lastMessage: "lll", image: .cafeteria!, id: 0), Profile(name: "Carol", lastMessage: "lll", image: .veganCafeteria!, id: 1)],
            [Profile(name: "John", lastMessage: "dddd", image: .yogaClass!, id: 2)]
        ]
    }
}
