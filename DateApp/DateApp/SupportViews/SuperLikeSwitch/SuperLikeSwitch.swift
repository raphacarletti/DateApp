import UIKit

final class SuperLikeSwitch: CustomView {
    @IBOutlet weak var superLikeLabel: UILabel! {
        didSet {
            let text = NSAttributedString(string: "SUPER LIKE", attributes: [.foregroundColor: UIColor.primaryColor, .kern: 5, .font: UIFont.systemFont(ofSize: 10)])
            superLikeLabel.attributedText = text
        }
    }
    @IBOutlet weak var activateImageView: UIImageView!
    @IBOutlet weak var activateButtonToTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var activateButtonToLeadingConstraint: NSLayoutConstraint!

    private(set) var isSwitchEnabled: Bool = true

    override func commonInit() {
        addGesture()
    }

    private func addGesture() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSwitch)))
    }

    private func changeState() {
        isSwitchEnabled.toggle()
        superLikeLabel.isHidden = !isSwitchEnabled
        activateButtonToLeadingConstraint.priority = isSwitchEnabled ? .defaultHigh : .defaultLow
        activateButtonToTrailingConstraint.priority = isSwitchEnabled ? .defaultLow : .defaultHigh
        isSwitchEnabled ? addText() : removeText()
        activateImageView.image = isSwitchEnabled ? .activateSuperLikeSwitch : .deactivateSuperLikeSwitch
    }

    private func removeText() {
        superLikeLabel.attributedText = NSAttributedString(string: "")
    }

    private func addText() {
        let text = NSAttributedString(string: "SUPER LIKE", attributes: [.foregroundColor: UIColor.primaryColor, .kern: 5, .font: UIFont.systemFont(ofSize: 10)])
        superLikeLabel.attributedText = text
    }

    @objc
    private func didTapSwitch() {
        changeState()
        print("CLICK")
    }
}
