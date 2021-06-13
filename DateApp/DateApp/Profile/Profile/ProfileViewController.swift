import UIKit

final class ProfileViewController: UIViewController {
    @IBOutlet weak var settingsButton: UIView! {
        didSet {
            settingsButton.applyDefaultShadow(with: 25)
        }
    }
    @IBOutlet weak var imageBorderView: UIView! {
        didSet {
            imageBorderView.applyDefaultShadow(with: 50)
        }
    }
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.image = .cafeteria
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.layer.cornerRadius = 40
            profileImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var editButton: UIView! {
        didSet {
            editButton.applyDefaultShadow(with: 13)
        }
    }
    @IBOutlet weak var inviteFriendsOption: ProfileOptionView! {
        didSet {
            inviteFriendsOption.set(for: .inviteFriends)
        }
    }
    @IBOutlet weak var mySavedOption: ProfileOptionView! {
        didSet {
            mySavedOption.set(for: .mySaved)
        }
    }
    @IBOutlet weak var wellnessPillarsOption: ProfileOptionView! {
        didSet {
            wellnessPillarsOption.set(for: .wellnessPillars)
            wellnessPillarsOption.isUserInteractionEnabled = true
            wellnessPillarsOption.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapWellnessPillarOption)))
        }
    }
    @IBOutlet weak var communityGuidelinesOption: ProfileOptionView! {
        didSet {
            communityGuidelinesOption.set(for: .guidelines)
        }
    }
    @IBOutlet weak var datingModeOption: ProfileOptionView! {
        didSet {
            datingModeOption.set(for: .datingMode)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @objc
    func didTapWellnessPillarOption() {
        performSegue(withIdentifier: Segue.profileToWellnessPillarsSegue, sender: nil)
    }
}
