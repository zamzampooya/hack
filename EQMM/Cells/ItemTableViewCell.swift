//
//  ItemTableViewCell.swift
//  EQMM
//
//  Created by Zamzam Farzamipooya on 07/05/2019.
//  Copyright © 2019 Zamzam Farzamipooya. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setConent(orderLine: OrderLine) {
        self.name.text = orderLine.name
        self.count.text = orderLine.numberOfItems
        let count = Double(orderLine.numberOfItems ?? "0") ?? 0
        self.price.text = "\(orderLine.price! * count)"
    }

}
