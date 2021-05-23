//
//  EventCollectionViewCell.swift
//  DateApp
//
//  Created by Raphael Carletti on 21/05/21.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var eventSummaryView: EventSummaryView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }

    func set(event: Event) {
        eventSummaryView.set(event: event)
    }

}
