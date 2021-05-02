//
//  OrderDetailVc.swift
//  Waamde
//
//  Created by Apple on 07/04/21.
//

import UIKit
import SDWebImage
class OrderDetailVc: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var btnContinue: UIButton!
    var amount = 0.0
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var txtvAddress: UITextView!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var tblvCartData: UITableView!
    var arrayData = ["Men","Women","Kids"]
    var selectedData = "Men"
    @IBOutlet weak var collectionData: UICollectionView!
    var cartList = [CartListModel]()
    var orderVm = orderViewModel()
    var deletVm = AddCartViewModel()
    @IBOutlet weak var collection1: UICollectionView!
    @IBOutlet weak var btnShoping: UIButton!
    var orderObj:OrderDetail?
    var createOrderVm = CreateOrderViewModel()
    var orderListObj:OrderModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        createOrderVm.CreateOrderVMDelegate = self
        orderVm.orderVMDelegate = self
        tblvCartData.tableFooterView = UIView()
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        if(AppDefaults.loadCurrentUser() != nil){
//            orderVm.callOrderDetailApi(order_Id: "\(orderListObj?.id ?? 0)")
            orderVm.callOrderDetailApi(order_Id: "41")
        }
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderObj?.cart?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = orderObj?.cart?[indexPath.row]
        let cell = Bundle.main.loadNibNamed("CartDataCell", owner: self, options: nil)?[0] as! CartDataCell
        if let getUrl = data?.photo {
            let imageUrl = kProductBaseURl + "\(getUrl)"
            cell.imgProduct.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgProduct.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "waamde copy"))//ImageConstant.kTempConstant
        } else {
            cell.imgProduct.image = UIImage.init(named: "waamde copy")
        }
        cell.btnDetail.tag = indexPath.row
      //  cell.btnDelete.tag = indexPath.row
        cell.btnDelete.isHidden = true
        cell.btnDetail.addTarget(self, action: #selector(btnDetail(_:)), for: .touchUpInside)
       // cell.btnDelete.addTarget(self, action: #selector(btnDelete(_:)), for: .touchUpInside)
        cell.lblTitle.text = data?.name
        cell.lblDesc.text = "Qty:" + (data?.quantity ?? "")
        cell.lblPrice.text = "$\(data?.price ?? "")"
        cell.btnDelete.setImage(UIImage(named:"trash"), for: .normal)
        return cell
    }
    @IBAction func btnDelete(_ sender: UIButton) {
        let d = orderObj?.cart?[sender.tag]
        let alert = UIAlertController(title: "Alert", message: "Do you want to delete this item", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            self.deletVm.RemoveAddCartApi(product_id: d?.product_id ?? "", user_id: "\(AppDefaults.loadCurrentUser()?.id ?? 0)")
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func btnDetail(_ sender: UIButton) {
        let d = orderObj?.cart?[sender.tag]
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.productDetail, name: .productDetail) as! ProductDetail
        //vc.quantity = Int(d.quantity ?? "0")!
        vc.selectedColor = d?.color ?? ""
        vc.product_id = "\(d?.product_id ?? "0")"
    
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
//        let vc = self.
    }
    @IBAction func btnCheckOut(_ sender: Any) {
        if(orderObj?.status == "pending"){
            let alert = UIAlertController(title: "", message: "Enter Cancel Reason", preferredStyle: .alert)

            
            alert.addTextField { (textField) in
                textField.text = ""
            }

            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                print("Text field: \(textField?.text)")
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (_) in
              
            }))
           
            self.present(alert, animated: true, completion: nil)
        }else{
            createOrderVm.callCreateOrderApi(cart_id: "\(orderObj?.cart?[0].cart_id ?? "")", user_id: "\(AppDefaults.loadCurrentUser()?.id ?? 0)", total_amount: Int(orderObj?.pay_amount ?? "") ?? 0, trans_id: "123456", order_type: "cod", email: AppDefaults.loadCurrentUser()?.email ?? "", name: orderObj?.shipping_name ?? "", country: "India", phone: orderObj?.shipping_phone ?? "")
        }
        
       
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.main, name: .loginVc)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
 
    
}
extension OrderDetailVc:OrderViewModelDelegate{
    func orderDetailSuccess(message:String, userModel:OrderDetail){
        self.orderObj = userModel
        self.tblvCartData.reloadData()
        if let objAdd = self.orderObj{
        txtvAddress.text = "\(objAdd.shipping_address ?? "") \n \(objAdd.shipping_city ?? ""), \(objAdd.shipping_phone ?? "") \n \(objAdd.shipping_zip ?? "")"
        }
        amount = 0.0
        _ = self.orderObj?.cart?.forEach { (obj) in
           if let amountPrice = Double(obj.price ?? "0"),let quantity = Double(obj.quantity ?? "1"){
               amount = amount+(amountPrice * quantity)
           }
       }
       lblTotalAmount.text = "Total Amount : $ \(amount)"
        if(orderObj?.status == "pending"){
            btnShoping.setTitle("Cancel Order", for: .normal)
        }else{
            btnShoping.setTitle("Re-Order", for: .normal)
        }

    }
    func orderDetailFaiure(message:String){
        
    }
}

extension OrderDetailVc:CreateOrderViewModelDelegate{
    func CreateOrderSuccess(message: String, userModel: CreareOrderData?) {
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.storeDetail, name: .confirmationSuccess) as! ConfirmationSuccess
        vc.modalPresentationStyle = .fullScreen
        vc.transactionId = userModel?.txnid ?? ""
        self.present(vc, animated: true, completion: nil)
    }
    func CreateOrderFaiure(message: String) {
        
    }
}
