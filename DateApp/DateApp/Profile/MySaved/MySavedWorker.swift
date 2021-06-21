import Foundation

final class MySavedWorker {
    func getEvents() -> [Event] {
        return UserDefaultUtils().getSavedEvents()
    }
}
