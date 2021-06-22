import Foundation

final class PersonalityViewModel {
    private let worker = PersonalityWorker()
    private var questions: [String] = []
    private var answers: [Int] = []
    var addQuestion: ((String, Bool) -> Void)?
    var activateQuestion: ((Int) -> Void)?
    var updateProgress: ((Float) -> Void)?
    private var progress: Float {
        return Float(answers.count) / Float(questions.count)
    }

    func getQuestions() {
        questions = worker.getQuestions()
        addQuestions()
    }

    private func addQuestions() {
        for i in 0..<questions.count {
            addQuestion?(questions[i], i == 0)
        }
    }
}

extension PersonalityViewModel: QuestionViewDelegate {
    func select(option: Int) {
        answers.append(option)
        if answers.count != questions.count {
            activateQuestion?(answers.count)
        }
        updateProgress?(progress)
    }
}
