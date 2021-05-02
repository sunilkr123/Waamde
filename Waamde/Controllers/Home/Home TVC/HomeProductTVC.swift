//
//  HomeProductTVC.swift
//  Waamde
//
//  Created by Apple on 26/01/21.
//

import UIKit
import SDWebImage

class HomeProductTVC: UITableViewCell {
    var arrData = [ProductModel]()
    var vc:HomeVC?
    var addWishVm = AddWishListViewModel()
    @IBOutlet weak var collectionvw: UICollectionView!
    @IBOutlet weak var btnArrow: UIButton!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var imgCategory: UIImageView!
    var homeData : HomeData?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addWishVm.addWishVMDelegate = self
        collectionvw.register(UINib(nibName: "ProductCVC", bundle: nil), forCellWithReuseIdentifier: "ProductCVC")
        collectionvw.delegate = self
        collectionvw.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setValues(data: HomeData?) {
        homeData = data
        
        lblname.text = data?.categoryName
        
        if let getUrl = data?.categoryImage {
            let imageUrl = kBaseImageUrl + "sliders/\(getUrl)"
            self.imgCategory.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgCategory.sd_setImage(with: URL(string: getUrl), placeholderImage: UIImage(named: "waamde copy"))//ImageConstant.kTempConstant
        } else {
            self.imgCategory.image = UIImage.init(named: "waamde copy")
        }
        collectionvw.reloadData()
    }
    
}
extension HomeProductTVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    //MARK: - Collection view datasource and delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ((homeData?.products?.count ?? 0) > 4) ? 4 : (homeData?.products?.count ?? 0)
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
            let cell:ProductCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCVC", for: indexPath as IndexPath) as! ProductCVC;
            cell.backgroundColor = UIColor.clear
        cell.btnHeart.tag = indexPath.row
        cell.btnHeart.addTarget(self, action: #selector(btnAddWishList(_:)), for: .touchUpInside)
            cell.setValues(data: homeData?.products?[indexPath.row])
            return cell
    }
    @IBAction func btnAddWishList(_ sender: UIButton) {
        let data = homeData?.products?[sender.tag]
        if data?.wish_list == 0 || data?.wish_list == nil{
            sender.setImage(UIImage(named: "heartFill"), for: .normal)
        }else{
            sender.setImage(UIImage(named: "heart (1)"), for: .normal)
        }
        addWishVm.callAddWishListApi(product_id:"\(data?.id ?? 0)", user_id: "\(AppDefaults.loadCurrentUser()?.id ?? 0)")
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = homeData?.products?[indexPath.row]
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.productDetail, name: .productDetail) as! ProductDetail
        vc.product_id = "\(data?.id ?? 0)"
        vc.modalPresentationStyle = .fullScreen
        self.vc?.present(vc, animated: true, completion: nil)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width:(collectionView.frame.size.width - 40)/2, height:215);
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}
extension HomeProductTVC:AddWishListViewModelDelegate{
    func wishSuccess(message: String, products: [WishListProductModel]) {
        
    }
    func wishFaiure(message: String) {
        
    }
}
