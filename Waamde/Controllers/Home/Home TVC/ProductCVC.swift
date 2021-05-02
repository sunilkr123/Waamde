//
//  ProductCVC.swift
//  Waamde
//
//  Created by Apple on 26/01/21.
//

import UIKit
import SDWebImage

class ProductCVC: UICollectionViewCell {

    @IBOutlet weak var btnHeart: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setValues(data: ProductModel?) {
        lblName.text = data?.name
        lblPrice.text = "\(kCurrency)\(data?.price ?? "")"
        if data?.wish_list == 0 || data?.wish_list == nil{
            btnHeart.setImage(UIImage(named: "heart (1)"), for: .normal)
        }else{
            btnHeart.setImage(UIImage(named: "heartFill"), for: .normal)
        }
        lblDesc.text = data?.details
        if let getUrl = data?.photo {
            let imageUrl = kBaseImageUrl + "thumbnails/\(getUrl)"
            self.imgProduct.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgProduct.sd_setImage(with: URL(string: getUrl), placeholderImage: UIImage(named: "waamde copy"))//ImageConstant.kTempConstant
        } else {
            self.imgProduct.image = UIImage.init(named: "waamde copy")
        }
    }
    func setValues(productListModel: ProductlistModel?) {
        lblName.text = productListModel?.name
        lblPrice.text = "\(kCurrency)\(productListModel?.price ?? "")"
        lblDesc.text = productListModel?.details
        if productListModel?.wish_list == 1{
            btnHeart.setImage(UIImage(named: "heartFill"), for: .normal)
        }else{
            btnHeart.setImage(UIImage(named: "heart (1)"), for: .normal)
        }
        if let getUrl = productListModel?.photo {
            let imageUrl = kProductBaseURl + "\(getUrl)"
            self.imgProduct.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgProduct.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "waamde copy"))//ImageConstant.kTempConstant
        } else {
            self.imgProduct.image = UIImage.init(named: "waamde copy")
        }
    }
}
