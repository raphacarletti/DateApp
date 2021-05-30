import Foundation
import StreamChat

class Chat {
    static let shared = Chat()
    var client: ChatClient?
    private var isConnected = false
    private(set) var channelListController: ChatChannelListController?
    var currentUserId: String {
        return client?.currentUserId ?? ""
    }

    var currentUserName: String {
        return client?.currentUserController().currentUser?.name ?? ""
    }


    private init() {}

    private func loginUser(completion: (() -> ())?) {
        let provider = TokenProvider.closure { chat, completion in
            let token = Token("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiamVzcyJ9.xXdy6-J6N3fHiJr6s9IJj1HyGBTYR483XEFRFbLKXIc")
            completion(.success(token))
        }
        var config = ChatClientConfig(apiKeyString: "py7te5n9463y")
        config.shouldConnectAutomatically = true
        client = ChatClient(config: config, tokenProvider: provider, completion: { [weak self] error in
            guard let self = self else { return }
            if error == nil {
                self.isConnected = true
            }
            completion?()
        })
    }

    func getChannels(completion: @escaping (Error?) -> Void) {
        if isConnected {
            channelListController = client?.channelListController(
                query: .init(
                    filter: .and([.equal(.type, to: .messaging), .containMembers(userIds: [client?.currentUserId ?? ""])]),
                    sort: [.init(key: .lastMessageAt, isAscending: false)],
                    messagesLimit: 1
                ))
            channelListController?.delegate = self
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                guard let self = self else { return }
                self.channelListController?.synchronize { error in
                    completion(error)
                }
            }
        } else {
            loginUser { [weak self] in
                guard let self = self else { return }
                self.getChannels(completion: completion)
            }
        }
    }


}

extension Chat: ChatChannelListControllerDelegate {
    func controller(_ controller: ChatChannelListController, didChangeChannels changes: [ListChange<ChatChannel>]) {
        for change in changes {
            switch change {
            case let .insert(channel, index: _):
                NotificationCenter.default.post(name: .channelUpdated, object: nil, userInfo: ["channel": channel])
            case let .update(channel, index: _):
                NotificationCenter.default.post(name: .channelUpdated, object: nil, userInfo: ["channel": channel])
            default:
                break
            }
        }
    }
}
