import UIKit

class NotificationTableViewCell: UITableViewCell {
    @IBOutlet weak var notificationImageView: UIImageView! {
        didSet {
            notificationImageView.contentMode = .scaleAspectFill
            notificationImageView.layer.cornerRadius = 25
            notificationImageView.clipsToBounds = true
            notificationImageView.image = .yogaClass
        }
    }
    @IBOutlet weak var notificationDescriptionLabel: UILabel! {
        didSet {
            notificationDescriptionLabel.font = .systemFont(ofSize: 12, weight: .light)
        }
    }
    @IBOutlet weak var actionButton: UIButton! {
        didSet {
            actionButton.setTitle("See more", for: .normal)
            actionButton.setTitleColor(.darkGray, for: .normal)
            actionButton.backgroundColor = .lighterGray
            actionButton.layer.cornerRadius = 15
            actionButton.clipsToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func customize(with notification: AppNotification) {
        switch notification.action {
        case .seeMore:
            actionButton.setTitle("See more", for: .normal)
        case .chat:
            actionButton.setTitle("Chat", for: .normal)
        }
        notificationDescriptionLabel.text = notification.title
        notificationImageView.kf.setImage(with: URL(string: notification.imgUrl))
    }
}
