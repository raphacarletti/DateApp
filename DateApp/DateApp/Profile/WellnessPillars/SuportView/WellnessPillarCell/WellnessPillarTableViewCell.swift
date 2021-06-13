import UIKit

enum WellnessPillars: CaseIterable {
    case physical
    case social

    var image: UIImage? {
        switch self {
        case .physical:
            return .cafeteria
        case .social:
            return .veganCafeteria
        }
    }

    var title: String {
        switch self {
        case .physical:
            return "PHYSICAL"
        case .social:
            return "SOCIAL"
        }
    }
}

class WellnessPillarTableViewCell: UITableViewCell {
    @IBOutlet weak var roundedView: UIView! {
        didSet {
            roundedView.applyDefaultShadow(with: 20)
            roundedView.backgroundColor = .offWhite
        }
    }
    @IBOutlet weak var wellnessPillarImageView: UIImageView! {
        didSet {
            wellnessPillarImageView.contentMode = .scaleAspectFill
            wellnessPillarImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            wellnessPillarImageView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func set(for wellnessPillar: WellnessPillars) {
        wellnessPillarImageView.image = wellnessPillar.image
        let text = NSAttributedString(string: wellnessPillar.title, attributes: [.foregroundColor: UIColor.primaryColor, .kern: 2, .font: UIFont.systemFont(ofSize: 16)])
        nameLabel.attributedText = text
    }
    
}
