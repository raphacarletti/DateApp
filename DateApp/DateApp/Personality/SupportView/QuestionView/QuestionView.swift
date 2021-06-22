import UIKit

protocol QuestionViewDelegate: AnyObject {
    func select(option: Int)
}

final class QuestionView: CustomView {
    @IBOutlet weak var questionLabel: UILabel! {
        didSet {
            questionLabel.textColor = .mediumGray
            questionLabel.font = .systemFont(ofSize: 14)
        }
    }
    @IBOutlet weak var noLabel: UILabel! {
        didSet {
            noLabel.textColor = .mediumGray
            noLabel.font = .systemFont(ofSize: 12)
        }
    }
    @IBOutlet weak var yesLabel: UILabel! {
        didSet {
            yesLabel.textColor = .primaryColor
            yesLabel.font = .systemFont(ofSize: 12)
        }
    }
    @IBOutlet weak var optionsStackView: UIStackView!
    @IBOutlet weak var noOptionImage: UIImageView! {
        didSet {
            noOptionImage.isUserInteractionEnabled = true
            noOptionImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOption(sender:))))
        }
    }
    @IBOutlet weak var noOption2Image: UIImageView! {
        didSet {
            noOption2Image.isUserInteractionEnabled = true
            noOption2Image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOption(sender:))))
        }
    }
    @IBOutlet weak var noOption3Image: UIImageView! {
        didSet {
            noOption3Image.isUserInteractionEnabled = true
            noOption3Image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOption(sender:))))
        }
    }
    @IBOutlet weak var neutralOption: UIImageView! {
        didSet {
            neutralOption.isUserInteractionEnabled = true
            neutralOption.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOption(sender:))))
        }
    }
    @IBOutlet weak var yesOption3Image: UIImageView! {
        didSet {
            yesOption3Image.isUserInteractionEnabled = true
            yesOption3Image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOption(sender:))))
        }
    }
    @IBOutlet weak var yesOption2Image: UIImageView! {
        didSet {
            yesOption2Image.isUserInteractionEnabled = true
            yesOption2Image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOption(sender:))))
        }
    }
    @IBOutlet weak var yesOptionImage: UIImageView! {
        didSet {
            yesOptionImage.isUserInteractionEnabled = true
            yesOptionImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOption(sender:))))
        }
    }

    weak var delegate: QuestionViewDelegate?

    func set(question: String, isEnabled: Bool) {
        questionLabel.text = question
        set(enabled: isEnabled)
    }

    func activate() {
        set(enabled: true)
    }

    private func set(enabled: Bool) {
        alpha = enabled ? 1 : 0.5
        isUserInteractionEnabled = enabled
    }

    @objc
    func didTapOption(sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else { return }
        if isNoOption(imageView: imageView) {
            imageView.image = .noAnswerFilled
        } else {
            imageView.image = .yesAnswerFilled
        }
        set(enabled: false)
        delegate?.select(option: getOptionNumber(from: imageView))
    }

    private func isNoOption(imageView: UIImageView) -> Bool {
        return imageView == noOptionImage || imageView == noOption2Image || imageView == noOption3Image || imageView == neutralOption
    }

    private func getOptionNumber(from imageView: UIImageView) -> Int {
        return optionsStackView.arrangedSubviews.firstIndex(of: imageView) ?? 0
    }
}
