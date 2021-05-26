import UIKit

class InboxSectionView: CustomView {
    @IBOutlet weak var sectionTitleLabel: UILabel! {
        didSet {
            sectionTitleLabel.textColor = .mediumGray
            sectionTitleLabel.font = .systemFont(ofSize: 18, weight: .light)
        }
    }

    func setText(for section: Int) {
        var text: String = ""
        switch section {
        case 0:
            text = "Pinned"
        case 1:
            text = "Other"
        default:
            break
        }
        sectionTitleLabel.text = text
    }

}
