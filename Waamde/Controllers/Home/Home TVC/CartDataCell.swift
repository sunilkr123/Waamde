//
//  CartDataCell.swift
//  Waamde
//
//  Created by Apple on 28/01/21.
//

import UIKit
import SDWebImage

class CartDataCell: UITableViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnDetail: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteAction(_ sender: Any) {
    }
    
    func setupView(_ data:WishListProductModel) {
        lblTitle.text = data.name
        lblDesc.text = data.features
        lblPrice.text = "$\(data.price ?? "0.0")"
        if let getUrl = data.photo {
            let imageUrl = kProductBaseURl + "\(getUrl)"
            self.imgProduct.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgProduct.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "waamde copy"))//ImageConstant.kTempConstant
        } else {
            self.imgProduct.image = UIImage.init(named: "waamde copy")
        }
    }
    
}
