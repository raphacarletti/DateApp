import UIKit

protocol SendInviteProfileTableViewCellDelegate: AnyObject {
    func didTapSendInviteButton(id: Int)
}

class SendInviteProfileTableViewCell: UITableViewCell {
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
    @IBOutlet weak var sendInviteButton: UIButton! {
        didSet {
            sendInviteButton.addTarget(self, action: #selector(didTapSendInviteButton), for: .touchUpInside)
            sendInviteButton.backgroundColor = .offWhite
            sendInviteButton.layer.shadowColor = UIColor.mediumGray.cgColor
            sendInviteButton.layer.shadowOpacity = 0.5
            sendInviteButton.layer.shadowOffset = CGSize(width: 0, height: 2)
            sendInviteButton.layer.shadowRadius = 2
            sendInviteButton.layer.cornerRadius = 20
            sendInviteButton.tintColor = .primaryColor
        }
    }

    weak var delegate: SendInviteProfileTableViewCellDelegate?
    private var profile: Profile?


    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .offWhite
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func set(profile: Profile, isSendInviteTapped: Bool, delegate: SendInviteProfileTableViewCellDelegate) {
        self.delegate = delegate
        self.profile = profile
        nameLabel.text = profile.name
        lastMessageLabel.text = profile.lastMessage
        photoImageView.image = profile.image
        setSendInviteButtonStyle(for: isSendInviteTapped)

    }

    @objc
    func didTapSendInviteButton() {
        guard let id = profile?.id else { return }
        delegate?.didTapSendInviteButton(id: id)
    }

    func setSendInviteButtonStyle(for isSendInviteTapped: Bool) {
        if isSendInviteTapped {
            sendInviteButton.tintColor = .offWhite
            sendInviteButton.backgroundColor = .primaryColor
        } else {
            sendInviteButton.tintColor = .primaryColor
            sendInviteButton.backgroundColor = .offWhite
        }
    }
}
