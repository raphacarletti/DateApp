import Foundation

final class NotificationCenterWorker {
    func getNotifications() -> [[AppNotification]] {
        return [
            [AppNotification(title: "You sent Jess an invitation to Yoga on Fri 13 Mar * 6min ago", imgUrl: "https://static1.purepeople.com.br/articles/8/28/20/28/@/3202873-jessica-costa-falou-sobre-a-relacao-com-624x600-1.jpg", action: .chat, date: Date())],
            [AppNotification(title: "You RSVP'd to Pool Party on Sat 14 Mar * 1h ago", imgUrl: "https://www.dicasdemulher.com.br/wp-content/uploads/2020/03/pool-party-0.png", action: .seeMore, date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date())]
        ]
    }
}
