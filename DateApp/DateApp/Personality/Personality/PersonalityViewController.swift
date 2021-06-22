import UIKit

final class PersonalityViewController: UIViewController {
    @IBOutlet weak var backButton: UIView! {
        didSet {
            backButton.applyDefaultShadow(with: 25)
        }
    }
    @IBOutlet weak var backIcon: UIImageView! {
        didSet {
            backIcon.tintColor = .mediumGray
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            let text = NSAttributedString(string: "PERSONALITY", attributes: [.foregroundColor: UIColor.primaryColor, .kern: 2, .font: UIFont.systemFont(ofSize: 18)])
            titleLabel.attributedText = text
        }
    }
    @IBOutlet weak var separatorView: UIView! {
        didSet {
            separatorView.backgroundColor = .primaryColor
        }
    }
    @IBOutlet weak var questionsStackView: UIStackView!
    @IBOutlet weak var progressView: UIProgressView! {
        didSet {
            progressView.progress = 0
        }
    }

    private let viewModel = PersonalityViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        viewModel.addQuestion = { [weak self] question, isFirst in
            guard let self = self else { return }
            self.addQuestionView(question: question, isEnabled: isFirst)
        }
        viewModel.activateQuestion = { [weak self] index in
            guard let self = self, let question = self.questionsStackView.arrangedSubviews[index] as? QuestionView else { return }
            question.activate()
        }
        viewModel.updateProgress = { [weak self] progress in
            guard let self = self else { return }
            self.progressView.progress = progress
        }
        viewModel.getQuestions()
    }

    func addQuestionView(question: String, isEnabled: Bool) {
        let view = QuestionView(frame: .zero)
        view.set(question: question, isEnabled: isEnabled)
        view.delegate = viewModel
        questionsStackView.addArrangedSubview(view)
    }
}
