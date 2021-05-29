import UIKit

class ChatSectionHeaderView: CustomView {
    @IBOutlet weak var dateTitleLabel: UILabel! {
        didSet {
            dateTitleLabel.textColor = .mediumGray
            dateTitleLabel.backgroundColor = .clear
        }
    }

    func set(text: String) {
        dateTitleLabel.text = text
    }
}
