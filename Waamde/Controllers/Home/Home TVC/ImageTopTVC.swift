//
//  ImageTopTVC.swift
//  Waamde
//
//  Created by Apple on 26/01/21.
//

import UIKit
import SDWebImage

class ImageTopTVC: UITableViewCell {

    @IBOutlet weak var imgBanner: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setValues(data: SliderModel?) {
        if let getUrl = data?.photo {
            let imageUrl = kBaseImageUrl + "sliders/\(getUrl)"
            self.imgBanner.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgBanner.sd_setImage(with: URL(string: getUrl), placeholderImage: UIImage(named: "waamde copy"))//ImageConstant.kTempConstant
        } else {
            self.imgBanner.image = UIImage.init(named: "waamde copy")
        }
    }
    
}
