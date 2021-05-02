//
//  WishlistVc.swift
//  Waamde
//
//  Created by Apple on 28/01/21.
//

import UIKit

class WishlistVc: UIViewController {
    @IBOutlet weak var tblvCartData: UITableView!
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var labelRegister: UILabel!
    var wishVM = WishListViewModel()
    var data = [WishListProductModel] ()
    var deleteVm = AddWishListViewModel()
    let text = "You are not logged in please login or register to continue shoping"
    override func viewDidLoad() {
        super.viewDidLoad()
         tblvCartData.tableFooterView = UIView()
        deleteVm.addWishVMDelegate = self
        wishVM.wishVMDelegate = self
        if(AppDefaults.loadCurrentUser() == nil){
            loginView.isHidden = false
        }else{
            loginView.isHidden = true
        }
        self.labelRegisterClickable()
    }
    override func viewWillAppear(_ animated: Bool) {
        if(AppDefaults.loadCurrentUser() != nil){
            wishVM.callGetWishListDataAPI()
        }
    }
    
    func labelRegisterClickable() {
        labelRegister.text = text
        self.labelRegister.textColor =  UIColor.black
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "login or register")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hex: "002061"), range: range1)
        labelRegister.attributedText = underlineAttriString
        labelRegister.isUserInteractionEnabled = true
        labelRegister.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
    }
    
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = (text as NSString).range(of: "login or register")
        if gesture.didTapAttributedTextInLabel(label: self.labelRegister, inRange: termsRange) {
            print("Register Text Clicked")
            btnLogin()
        } else {
            btnLogin()
            print("Tapped none")
        }
    }
    
    func btnLogin() {
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.main, name: .loginVc)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnDelete(_ sender: UIButton) {
        let d = data[sender.tag]
        let alert = UIAlertController(title: "Alert", message: "Do you want to remove this item from wishlist", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            self.deleteVm.RemoveAddWishListApi(product_id: d.product_id ?? "", user_id: "\(AppDefaults.loadCurrentUser()?.id ?? 0)")
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnGotoProductSearch(_ sender: Any) {
        moveToProductList()
    }
}
extension WishlistVc:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CartDataCell", owner: self, options: nil)?[0] as! CartDataCell
        cell.btnDelete.addTarget(self, action: #selector(btnDelete(_:)), for: .touchUpInside)
        cell.setupView(data[indexPath.row])
        cell.btnDetail.tag = indexPath.row
        cell.btnDetail.addTarget(self, action: #selector(btnDetail(_:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    @IBAction func btnDetail(_ sender: UIButton) {
        let d = data[sender.tag]
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.productDetail, name: .productDetail) as! ProductDetail
        //vc.quantity = Int(d.quantity ?? "0")!
        vc.selectedColor = d.color ?? ""
        vc.product_id = "\(d.product_id ?? "0")"
    
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
//        let vc = self.
    }
}

extension WishlistVc: WishViewModelDelegate,AddWishListViewModelDelegate {
    
    func wishSuccess(message:String, products:[WishListProductModel]){
        data = products
        self.lblCount.text = "\(products.count)"
        tblvCartData.reloadData()
    }
    
    func wishFaiure(message:String) {
        AlertManager.showAlertControllerWith(message: .custom(message), controller: self, buttons: .ok(nil))
    }
    func AddWishListSuccess(message: String, userModel: AddWishListModel?) {
        wishVM.callGetWishListDataAPI()
    }
    func AddWishListFaiure(message: String) {
        
    }
}
