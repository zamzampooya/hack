//
//  HistoryTableViewCell.swift
//  EQMM
//
//  Created by Zamzam Farzamipooya on 07/05/2019.
//  Copyright © 2019 Zamzam Farzamipooya. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var centerView: UIView! {
        didSet {
            self.centerView.clipsToBounds = true
            self.centerView.layer.cornerRadius = self.centerView.frame.width / 2
        }
    }
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setContent(history: History) {
        self.title.text = history.state!.rawValue
        self.date.text = history.date
        switch history.state! {
        case .quoteSent:
            self.statusImage.image = #imageLiteral(resourceName: "Group 719")
        case .quoteSeen:
            self.statusImage.image = #imageLiteral(resourceName: "Group 719")
        case .approved:
            self.statusImage.image = #imageLiteral(resourceName: "Group 719")
        case .orderSent:
            self.imageView?.image = #imageLiteral(resourceName: "Group 728")
        default:
            self.statusImage.image = #imageLiteral(resourceName: "Group 719")
        }
    }

}
