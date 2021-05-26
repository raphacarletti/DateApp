import UIKit

class MessageHeaderView: CustomView {
    @IBOutlet weak var messageTitleLabel: UILabel! {
        didSet {
            messageTitleLabel.text = "Messages"
            messageTitleLabel.textColor = .mediumGray
            messageTitleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        }
    }
    @IBOutlet weak var separatorView: UIView! {
        didSet {
            separatorView.backgroundColor = .primaryColor
        }
    }

}
