import Foundation
import StreamChat

class Chat {
    static let shared = Chat()
    var client: ChatClient?
    private var isConnected = false
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

    func getChannels(completion: @escaping (LazyCachedMapCollection<_ChatChannel<NoExtraData>>) -> Void) {
        if isConnected {
            guard let controller = client?.channelListController(
                query: .init(
                    filter: .and([.equal(.type, to: .messaging), .containMembers(userIds: [client?.currentUserId ?? ""])]),
                    sort: [.init(key: .lastMessageAt, isAscending: false)],
                    messagesLimit: 1
                )
            ) else {
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                controller.synchronize { error in
                    if error == nil {
                        completion(controller.channels)
                    }
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
