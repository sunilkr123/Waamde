//
//  ProductDetailTbl.swift
//  Waamde
//
//  Created by Apple on 31/01/21.
//

import UIKit
import SDWebImage
class ProductDetailTbl: UITableViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var myVc:ProductDetail?
    @IBOutlet weak var lblPaymentMethod: UILabel!
    @IBOutlet weak var lblSupplier: UILabel!
    @IBOutlet weak var lblReturnPolicy: UILabel!
    @IBOutlet weak var lblShipping: UILabel!
    @IBOutlet weak var lblMetaData: UILabel!
    @IBOutlet weak var txtvDesc: UITextView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var viewQuantity: UIView!
    @IBOutlet weak var btnHeart: UIButton!
  
    
    var data:ProductDetailModel?
    var addWishVm = AddWishListViewModel()
    var addcartData = [AddCartModel]()
    var addCartVm = AddCartViewModel()
    @IBOutlet weak var lblQuantity: UILabel!
    var arrDataSource = [String]()
    var productVM = productDetailViewModel()
    var product_id = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        addWishVm.addWishVMDelegate = self
        collectionView.dataSource = self
        productVM.productVMDelegate = self
        let layout = UICollectionViewFlowLayout()
                                  layout.scrollDirection = .horizontal
                                  layout.minimumLineSpacing = 5
                                  layout.minimumInteritemSpacing = 5
                                  collectionView.setCollectionViewLayout(layout, animated: true)
        viewQuantity.layer.borderWidth = 1
        viewQuantity.layer.borderColor = UIColor.lightGray.cgColor
        productVM.productVMDelegate = self
        addCartVm.addCartVMDelegate = self
        lblQuantity.text = "\(self.myVc?.quantity ?? 1)"
        let data = ProductDetailData(product_id: self.myVc?.product_id ?? "")
        productVM.callProductDetailApi(data: data)
      
    }

   
    @IBAction func btnMinus(_ sender: Any) {
        if (self.myVc?.quantity ?? 0) > 1{
        self.myVc?.quantity = (self.myVc?.quantity ?? 1) - 1
        lblQuantity.text = "\(self.myVc?.quantity ?? 1)"
        }
    }
    @IBAction func btnAddWishList(_ sender: UIButton) {
        if data?.wish_list == 0 || data?.wish_list == nil{
            sender.setImage(UIImage(named: "heartFill"), for: .normal)
        }else{
            sender.setImage(UIImage(named: "heart (1)"), for: .normal)
        }
        addWishVm.callAddWishListApi(product_id:"\(data?.id ?? 0)", user_id: "\(AppDefaults.loadCurrentUser()?.id ?? 0)")
    }
    @IBAction func btnPlus(_ sender: Any) {
        self.myVc?.quantity = (self.myVc?.quantity ?? 0) + 1
        lblQuantity.text = "\(self.myVc?.quantity ?? 1)"
    }
    @IBAction func btnAddToCard(_ sender: Any) {
        addCartVm.callAddCartApi(product_id: self.myVc?.product_id ?? "", user_id: "\(AppDefaults.loadCurrentUser()?.id ?? 0)",quantity:self.myVc?.quantity ?? 1,color:self.myVc?.selectedColor ?? "")
    }
    @IBAction func btnDesc(_ sender: Any) {
        
    }
    
    @IBAction func btnReviews(_ sender: Any) {
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.profile, name: .reviewVc) as! ReviewVc
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
extension ProductDetailTbl: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    //MARK: - Collection view datasource and delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrDataSource.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell:colorCell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath as IndexPath) as! colorCell;

        cell.color.backgroundColor = UIColor(hex: arrDataSource[indexPath.row])
                if self.myVc?.selectedColor == arrDataSource[indexPath.row]
                {
                    cell.wholeView.backgroundColor = .lightGray
                }else{
                    cell.wholeView.backgroundColor = .white
                   
                }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.myVc?.selectedColor = arrDataSource[indexPath.row]
        self.collectionView.reloadData()
          
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
       
        return CGSize(width:40, height:40);
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}
class colorCell: UICollectionViewCell {
    @IBOutlet weak var color: UIView!
    @IBOutlet weak var wholeView: UIView!
}
extension ProductDetailTbl: ProductDetailViewModelDelegate{
    
    func productDetailSuccess(message:String, userModel:ProductDetailModel) {
        data = userModel
        if data?.wish_list == 0 || data?.wish_list == nil{
            btnHeart.setImage(UIImage(named: "heart (1)"), for: .normal)
        }else{
            btnHeart.setImage(UIImage(named: "heartFill"), for: .normal)
        }
        self.lblProductName.text = data?.name ?? ""
        self.txtvDesc.text = (data?.details ?? "").htmlToString
        self.lblPrice.text = "$\(data?.price ?? "")"
        if let getUrl = data?.photo {
            let imageUrl = kProductBaseURl + "\(getUrl)"
            self.imgLogo.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgLogo.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "waamde copy"))//ImageConstant.kTempConstant
        } else {
            self.imgLogo.image = UIImage.init(named: "waamde copy")
        }
        
        self.arrDataSource = userModel.color ?? []
        self.myVc?.selectedColor = self.arrDataSource.first ?? ""
        collectionView.reloadData()
    }
    
    func productDetailFaiure(message:String) {
        AlertManager.showAlertControllerWith(message: .custom(message), controller: self, buttons: .ok(nil))
    }
    
}
extension ProductDetailTbl:AddCartViewModelDelegate{
    func AddCartSuccess(message: String, userModel: AddCartModel?) {
       // let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.main, name: .roottab) as! UITabBarController
       // vc.modalPresentationStyle = .fullScreen
       // vc.selectedIndex = 1
        //self.present(vc, animated: true, completion: nil)
           // let vc = DesignManager.loadViewControllerFromStroyBoardWithName("Main", name: <#T##ViewControllerName#>)
          AlertManager.showAlertControllerWith(message: .custom(message), controller: self, buttons: .ok(nil))
    }
    func AddCartFaiure(message: String) {
        
    }

}
extension ProductDetailTbl:AddWishListViewModelDelegate{
    func AddWishListSuccess(message: String, userModel: AddWishListModel?) {
        
    }
    func AddWishListFaiure(message: String) {
        
    }
}
