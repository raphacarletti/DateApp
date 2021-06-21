import Foundation

final class UserDefaultUtils {
    enum Keys: String {
        case pinnedMessages
        case savedEvents
    }

    func get(key: Keys) -> Any {
        return UserDefaults.standard.object(forKey: key.rawValue) ?? ""
    }

    func getPinnedMessages() -> [String] {
        return UserDefaults.standard.object(forKey: Keys.pinnedMessages.rawValue) as? [String] ?? []
    }

    func save(object: Any, for key: Keys) {
        UserDefaults.standard.set(object, forKey: key.rawValue)
    }

    func save(events: [Event]) {
        let eventsJson = try? JSONEncoder().encode(events)
        save(object: eventsJson ?? Data(), for: .savedEvents)
    }

    func getSavedEvents() -> [Event] {
        guard let events = get(key: .savedEvents) as? Data else { return [] }
        return try! JSONDecoder().decode([Event].self, from: events)
    }
}
