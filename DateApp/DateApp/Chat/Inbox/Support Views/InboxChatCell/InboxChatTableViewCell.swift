import UIKit
import StreamChat
import Kingfisher

class InboxChatTableViewCell: UITableViewCell {
    @IBOutlet weak var roundedView: UIView! {
        didSet {
            roundedView.layer.shadowColor = UIColor.mediumGray.cgColor
            roundedView.layer.shadowOpacity = 0.5
            roundedView.layer.shadowOffset = .zero
            roundedView.layer.shadowRadius = 4
            roundedView.layer.cornerRadius = 30
        }
    }
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.layer.cornerRadius = 25
            photoImageView.image = .cafeteria
            photoImageView.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.textColor = .mediumGray
            nameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
            nameLabel.text = "Jess"
        }
    }
    @IBOutlet weak var lastMessageLabel: UILabel! {
        didSet {
            lastMessageLabel.textColor = .mediumGray
            lastMessageLabel.font = .systemFont(ofSize: 16)
            lastMessageLabel.text = "Ok, I will let you know"
        }
    }
    @IBOutlet weak var counterView: UIView! {
        didSet {
            counterView.backgroundColor = .primaryColor
            counterView.layer.cornerRadius = 10
            counterView.clipsToBounds = true
        }
    }
    @IBOutlet weak var counterLabel: UILabel! {
        didSet {
            counterLabel.textColor = .white
            counterLabel.font = .systemFont(ofSize: 12)
            counterLabel.text = "99"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setActions(color: .mediumGray)
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        setActions(color: .mediumGray)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func set(with channel: ChatChannel) {
        let member = channel.cachedMembers.first(where: { member in
            return member.name != Chat.shared.currentUserName
        })
        nameLabel.text = member?.name
        lastMessageLabel.text = channel.latestMessages.first?.text
        if channel.unreadCount.messages > 0 {
            counterView.isHidden = false
            counterLabel.text = "\(channel.unreadCount.messages)"
        } else {
            counterView.isHidden = true
        }
        photoImageView.kf.setImage(with: member?.imageURL)
    }
}
