import Foundation

final class UserDefaultUtils {
    func getPinnedMessages() -> [String] {
        return UserDefaults.standard.object(forKey: "pinnedMessages") as? [String] ?? []
    }

    func save(object: Any) {
        UserDefaults.standard.set(object, forKey: "pinnedMessages")
    }
}
