//
//  EventTableViewCell.swift
//  DateApp
//
//  Created by Raphael Carletti on 19/05/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var roundedView: UIView! {
        didSet {
            roundedView.backgroundColor = .offWhite
            roundedView.layer.shadowColor = UIColor.mediumGray.cgColor
            roundedView.layer.shadowOpacity = 1
            roundedView.layer.shadowOffset = .zero
            roundedView.layer.shadowRadius = 5
            roundedView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var eventImage: UIImageView! {
        didSet {
            eventImage.clipsToBounds = true
            eventImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            eventImage.layer.cornerRadius = 20
            eventImage.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var eventTitleLabel: UILabel! {
        didSet {
            eventTitleLabel.font = .systemFont(ofSize: 20)
            eventTitleLabel.textColor = .mediumGray
        }
    }
    @IBOutlet weak var shareButton: UIButton! {
        didSet {
            shareButton.setTitle("", for: .normal)
            shareButton.setImage(.shareIcon, for: .normal)
            shareButton.tintColor = .mediumGray
        }
    }
    @IBOutlet weak var favoriteButton: UIButton! {
        didSet {
            favoriteButton.setTitle("", for: .normal)
            favoriteButton.setImage(.bookmarkIcon, for: .normal)
            favoriteButton.tintColor = .mediumGray
        }
    }
    @IBOutlet weak var locationLabel: UILabel! {
        didSet {
            locationLabel.font = .systemFont(ofSize: 13)
            locationLabel.textColor = .mediumGray
        }
    }
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.font = .systemFont(ofSize: 16)
            dateLabel.textColor = .mediumGray
        }
    }
    @IBOutlet weak var pinIconImageView: UIImageView! {
        didSet {
            pinIconImageView.image = .pinIcon
            pinIconImageView.contentMode = .scaleAspectFit
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func set(event: Event) {
        eventImage.image = event.image
        eventTitleLabel.text = event.name
        locationLabel.text = event.venue
        dateLabel.text = event.formattedDate
    }
    
}
