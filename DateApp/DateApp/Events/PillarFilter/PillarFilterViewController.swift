import UIKit

final class PillarFilterViewController: UIViewController {
    @IBOutlet weak var roundedView: UIView! {
        didSet {
            roundedView.applyDefaultShadow(with: 12)
        }
    }
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.tintColor = .mediumGray
            closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc
    func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
}
