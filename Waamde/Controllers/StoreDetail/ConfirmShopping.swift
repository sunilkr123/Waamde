//
//  ConfirmShopping.swift
//  Waamde
//
//  Created by Apple on 21/03/21.
//

import UIKit
import SDWebImage
import Stripe
class ConfirmShopping: UIViewController, STPPaymentContextDelegate {
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        
    }
    
    var amount = 0.0
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var txtvAddress: UITextView!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var tblvCartData: UITableView!
    var arrayData = ["Men","Women","Kids"]
    var selectedData = "Men"
    @IBOutlet weak var collectionData: UICollectionView!
    var cartList = [CartListModel]()
    var cartlistVm = CartListViewModel()
    var deletVm = AddCartViewModel()
    @IBOutlet weak var collection1: UICollectionView!
    @IBOutlet weak var btnShoping: UIButton!
    var addressObj:OrderAddressModel?
    var createOrderVm = CreateOrderViewModel()
    var paymentContext:STPPaymentContext?
    override func viewDidLoad() {
        super.viewDidLoad()
        createOrderVm.CreateOrderVMDelegate = self
        deletVm.addCartVMDelegate = self
        cartlistVm.cartListVMDelegate = self
        tblvCartData.tableFooterView = UIView()
        if let objAdd = self.addressObj{
        txtvAddress.text = "\(objAdd.address ?? "") \n \(objAdd.city ?? ""), \(objAdd.state ?? "") \n \(objAdd.zipCode ?? "")"
        }
       
    }
    override func viewWillAppear(_ animated: Bool) {
        if(AppDefaults.loadCurrentUser() != nil){
            cartlistVm.callCartListApi(category_id: "", user_id: "\(AppDefaults.loadCurrentUser()?.id ?? 0)")
        }
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnCheckOut(_ sender: Any) {
        if addressObj?.paymentType == "online"{
            let customerContext = STPCustomerContext(keyProvider: MyAPIClient())
            self.paymentContext = STPPaymentContext(customerContext: customerContext)
                
            self.paymentContext?.delegate = self
            self.paymentContext?.hostViewController = self
            self.paymentContext?.paymentAmount = 5000 // This is in cents, i.e. $50 USD
            self.paymentContext?.presentPaymentOptionsViewController()
        }else{
            createOrderVm.callCreateOrderApi(cart_id: "\(cartList[0].id ?? 0)", user_id: "\(AppDefaults.loadCurrentUser()?.id ?? 0)", total_amount: Int(amount), trans_id: "123456", order_type: addressObj?.paymentType ?? "", email: AppDefaults.loadCurrentUser()?.email ?? "", name: addressObj?.name ?? "", country: "India", phone: addressObj?.phone ?? "")
        }
        
       
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.main, name: .loginVc)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
 
    
}
extension ConfirmShopping:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = cartList[indexPath.row]
        let cell = Bundle.main.loadNibNamed("CartDataCell", owner: self, options: nil)?[0] as! CartDataCell
        if let getUrl = data.photo {
            let imageUrl = kProductBaseURl + "\(getUrl)"
            cell.imgProduct.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgProduct.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "waamde copy"))//ImageConstant.kTempConstant
        } else {
            cell.imgProduct.image = UIImage.init(named: "waamde copy")
        }
        cell.btnDetail.tag = indexPath.row
        cell.btnDetail.addTarget(self, action: #selector(btnDetail(_:)), for: .touchUpInside)
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(btnDelete(_:)), for: .touchUpInside)
        cell.lblTitle.text = data.name
        cell.lblDesc.text = "Qty:" + (data.quantity ?? "")
        cell.lblPrice.text = "$" + (data.price ?? "")
        cell.btnDelete.setImage(UIImage(named:"trash"), for: .normal)
        print("price is $\(data.price)")
        return cell
    }
    @IBAction func btnDetail(_ sender: UIButton) {
        let d = cartList[sender.tag]
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.productDetail, name: .productDetail) as! ProductDetail
        //vc.quantity = Int(d.quantity ?? "0")!
        vc.selectedColor = d.color ?? ""
        vc.product_id = "\(d.product_id ?? "0")"
    
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
//        let vc = self.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    @IBAction func btnDelete(_ sender: UIButton) {
        let d = cartList[sender.tag]
        let alert = UIAlertController(title: "Alert", message: "Do you want to delete this item", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            self.deletVm.RemoveAddCartApi(product_id: d.product_id ?? "", user_id: "\(AppDefaults.loadCurrentUser()?.id ?? 0)")
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
extension ConfirmShopping:CartListViewModelDelegate{
    func CartListSuccess(message: String, userModel: [CartListModel]) {
        self.cartList = userModel
         amount = 0.0
        _ = self.cartList.forEach { (obj) in
            if let amountPrice = Double(obj.price ?? "0"),let quantity = Double(obj.quantity ?? "1"){
                amount = amount+(amountPrice * quantity)
            }
        }
        lblTotalAmount.text = "Total Amount : $ \(amount)"
        self.tblvCartData.reloadData()
    }
    func CartListFaiure(message: String) {
        
    }
}
extension ConfirmShopping:AddCartViewModelDelegate{
    func AddCartSuccess(message: String, userModel: AddCartModel?) {
        cartlistVm.callCartListApi(category_id: "", user_id: "\(AppDefaults.loadCurrentUser()?.id ?? 0)")
    }
    func AddCartFaiure(message: String) {
        
    }
}
extension ConfirmShopping:CreateOrderViewModelDelegate{
    func CreateOrderSuccess(message: String, userModel: CreareOrderData?) {
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.storeDetail, name: .confirmationSuccess) as! ConfirmationSuccess
        vc.modalPresentationStyle = .fullScreen
        vc.transactionId = userModel?.txnid ?? ""
        self.present(vc, animated: true, completion: nil)
    }
    func CreateOrderFaiure(message: String) {
        
    }
}
