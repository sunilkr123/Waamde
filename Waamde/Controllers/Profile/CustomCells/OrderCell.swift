//
//  OrderCell.swift
//  Waamde
//
//  Created by Apple on 30/01/21.
//

import UIKit

class OrderCell: UITableViewCell {
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnStatus: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
