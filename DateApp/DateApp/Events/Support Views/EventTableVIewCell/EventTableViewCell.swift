//
//  EventTableViewCell.swift
//  DateApp
//
//  Created by Raphael Carletti on 19/05/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var eventSummaryView: EventSummaryView!


    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func set(event: Event) {
        eventSummaryView.set(event: event)
    }
    
}
