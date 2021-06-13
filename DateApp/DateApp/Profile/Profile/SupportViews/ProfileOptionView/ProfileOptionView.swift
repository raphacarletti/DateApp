import UIKit

class ProfileOptionView: CustomView {
    enum Options {
        case inviteFriends
        case mySaved
        case wellnessPillars
        case guidelines
        case datingMode

        var icon: UIImage? {
            switch self {
            case .inviteFriends:
                return .shareIcon
            case .mySaved:
                return .bookmarkIcon
            default:
                return .editIcon
            }
        }

        var title: String {
            switch self {
            case .inviteFriends:
                return "Invite Friends"
            case .mySaved:
                return "My Saved"
            case .wellnessPillars:
                return "Wellness Pillars"
            case .guidelines:
                return "Community Guidelines"
            case .datingMode:
                return "Dating Mode"
            }
        }

        var shouldShowSwitch: Bool {
            switch self {
            case .datingMode:
                return true
            default:
                return false
            }
        }
    }
    @IBOutlet weak var roundedView: UIView! {
        didSet {
            roundedView.applyDefaultShadow(with: 20)
        }
    }

    @IBOutlet weak var optionIcon: UIImageView! {
        didSet {
            optionIcon.contentMode = .scaleAspectFit
            optionIcon.tintColor = .mediumGray
        }
    }
    @IBOutlet weak var optionName: UILabel! {
        didSet {
            optionName.textColor = .mediumGray
            optionName.font = .systemFont(ofSize: 16)
        }
    }
    @IBOutlet weak var forwardIcon: UIImageView! {
        didSet {
            forwardIcon.tintColor = .mediumGray
            forwardIcon.contentMode = .scaleAspectFit
            forwardIcon.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }
    @IBOutlet weak var optionSwitch: UISwitch! {
        didSet {
            optionSwitch.isOn = true
            optionSwitch.onTintColor = .primaryColor
        }
    }

    func set(for option: Options) {
        optionIcon.image = option.icon
        optionName.text = option.title
        forwardIcon.isHidden = option.shouldShowSwitch
        optionSwitch.isHidden = !option.shouldShowSwitch
    }

}
