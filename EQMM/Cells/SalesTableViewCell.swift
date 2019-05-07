//
//  SalesTableViewCell.swift
//  EQMM
//
//  Created by Zamzam Farzamipooya on 07/05/2019.
//  Copyright © 2019 Zamzam Farzamipooya. All rights reserved.
//

import UIKit

class SalesTableViewCell: UITableViewCell {

    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var total: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setContent(document: Document) {
        self.customerLabel.text = document.customer
        self.subtitle.text = document.state?.rawValue
        self.dateLabel.text = ""
        self.total.text = String(document.total!) + " DKK"
        
    }
}
