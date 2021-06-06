import UIKit

final class OptionsMenuViewController: UIViewController {
    @IBOutlet weak var quitButton: UIView! {
        didSet {
            quitButton.layer.shadowColor = UIColor.mediumGray.cgColor
            quitButton.layer.shadowOpacity = 0.5
            quitButton.layer.shadowOffset = CGSize(width: 0, height: 2)
            quitButton.layer.shadowRadius = 2
            quitButton.layer.cornerRadius = 25
            quitButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapQuitButton)))
        }
    }
    @IBOutlet weak var quitIconImageView: UIImageView! {
        didSet {
            quitButton.tintColor = .mediumGray
        }
    }
    @IBOutlet weak var roundedView: UIView! {
        didSet {
            roundedView.layer.shadowColor = UIColor.mediumGray.cgColor
            roundedView.layer.shadowOpacity = 0.5
            roundedView.layer.shadowOffset = CGSize(width: 0, height: 2)
            roundedView.layer.shadowRadius = 2
            roundedView.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var viewProfileButton: UILabel! {
        didSet {
            viewProfileButton.textColor = .mediumGray
            viewProfileButton.isUserInteractionEnabled = true
            viewProfileButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapViewProfileButton)))
        }
    }
    @IBOutlet weak var unmatchButton: UILabel! {
        didSet {
            unmatchButton.textColor = .mediumGray
            unmatchButton.isUserInteractionEnabled = true
            unmatchButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapUnmatchButton)))
        }
    }
    @IBOutlet weak var reportButton: UILabel! {
        didSet {
            reportButton.textColor = .mediumGray
            reportButton.isUserInteractionEnabled = true
            reportButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapReportButton)))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc
    func didTapViewProfileButton() {
        print("ViewProfile")
    }

    @objc
    func didTapUnmatchButton() {
        print("Unmatch")
    }

    @objc
    func didTapReportButton() {
        print("Report")
    }

    @objc
    func didTapQuitButton() {
        dismiss(animated: true, completion: nil)
    }
}
