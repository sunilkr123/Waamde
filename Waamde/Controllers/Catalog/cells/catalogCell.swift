//
//  catalogCell.swift
//  Waamde
//
//  Created by Apple on 28/01/21.
//

import UIKit
import SDWebImage

class catalogCell: UITableViewCell {

    @IBOutlet weak var imgvIcon: UIImageView!
    @IBOutlet weak var lblData: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: custom methods
    
    func setValues(data: CatalogModel) {
        self.lblData.text = data.name
        if let getUrl = data.image {
            let imageUrl = kBaseImageUrl + "categories/\(getUrl)"
            self.imgvIcon.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgvIcon.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "waamde copy"))//ImageConstant.kTempConstant
        } else {
            self.imgvIcon.image = UIImage.init(named: "waamde copy")
        }
    }
}
