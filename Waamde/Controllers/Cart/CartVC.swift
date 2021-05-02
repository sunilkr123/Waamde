//
//  CartVC.swift
//  Waamde
//
//  Created by Apple on 27/01/21.
//

import UIKit
import SDWebImage

class CartVC: UIViewController {
    //MARK:- IBOutlet's of the Controller-
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var btnEmptyView: UIView!
    @IBOutlet weak var tblvCartData: UITableView!
    @IBOutlet weak var collection1: UICollectionView!
    @IBOutlet weak var btnShoping: UIButton!
    @IBOutlet weak var collectionData: UICollectionView!
    @IBOutlet weak var labelRegister: UILabel!
    //MARK:- Class Variables of the Controller-
    var cartList = [CartListModel]()
    var cartlistVm = CartListViewModel()
    var deletVm = AddCartViewModel()
    var arrayData = ["Men","Women","Kids"]
    var selectedData = "Men"
    let text = "You are not logged in please login or register to continue shoping"
    //MARK:-  Views Life Cycle's of the Controller-
    override func viewDidLoad() {
        super.viewDidLoad()
        tblvCartData.tableFooterView = UIView()
        lblCartCount.text = ""
        if(AppDefaults.loadCurrentUser() == nil){
            loginView.isHidden = false
        }else{
            loginView.isHidden = true
        }
        btnShoping.layer.cornerRadius = 10
        deletVm.addCartVMDelegate = self
        cartlistVm.cartListVMDelegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        collection1.setCollectionViewLayout(layout, animated: true)
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .horizontal
        layout1.minimumLineSpacing = 5
        layout1.minimumInteritemSpacing = 5
        collectionData.setCollectionViewLayout(layout1, animated: true)
        setupView()
        self.labelRegisterClickable()
    }
    override func viewWillAppear(_ animated: Bool) {
        if(AppDefaults.loadCurrentUser() != nil){
            cartlistVm.callCartListApi(category_id: "", user_id: "\(AppDefaults.loadCurrentUser()?.id ?? 0)")
        }
    }
    func setupView() {
        collection1.register(UINib(nibName: "categoryTitleCell", bundle: nil), forCellWithReuseIdentifier: "categoryTitleCell")
        collectionData.register(UINib(nibName: "ProductCVC", bundle: nil), forCellWithReuseIdentifier: "ProductCVC")
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
    
    //MARK:- IBAction's of the Controller-
    @IBAction func btnCheckOut(_ sender: Any) {
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.storeDetail, name: .addressVc)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func btnLogin() {
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.main, name: .loginVc)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
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
    @IBAction func btnGotoProductSearch(_ sender: Any) {
           moveToProductList()
       }
}
//MARK: - Collection view datasource and delegate
extension CartVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collection1{
            let cell:categoryTitleCell = collection1.dequeueReusableCell(withReuseIdentifier: "categoryTitleCell", for: indexPath as IndexPath) as! categoryTitleCell;
            if selectedData == arrayData[indexPath.row]{
                cell.wholeView.backgroundColor = .white
                cell.wholeView.layer.cornerRadius = 4
                cell.wholeView.addshadow()
            }else{
                cell.wholeView.backgroundColor = .clear
                cell.wholeView.removeshadow()
            }
            cell.lblTitle.text = arrayData[indexPath.row]
            cell.backgroundColor = UIColor.clear
            return cell
        }else{
            let cell:ProductCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCVC", for: indexPath as IndexPath) as! ProductCVC;
            
            cell.backgroundColor = UIColor.clear
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collection1{
            selectedData = arrayData[indexPath.row]
        }
        self.collection1.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collection1{
            return CGSize(width:(collectionView.frame.size.width - 40)/3, height:40);
        }else{
            return CGSize(width:(collectionView.frame.size.width - 20)/2, height:215);
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}
//MARK:- UITableViewDelegate , UITableViewDataSource -
extension CartVC:UITableViewDelegate,UITableViewDataSource {
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
        cell.btnDelete.tag = indexPath.row
        cell.btnDetail.addTarget(self, action: #selector(btnDetail(_:)), for: .touchUpInside)
        cell.btnDelete.addTarget(self, action: #selector(btnDelete(_:)), for: .touchUpInside)
        cell.lblTitle.text = data.name
        cell.lblDesc.text = "Qty:" + (data.quantity ?? "")
        cell.lblPrice.text = "$\(data.price ?? "")"
        cell.btnDelete.setImage(UIImage(named:"trash"), for: .normal)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension CartVC:CartListViewModelDelegate{
    func CartListSuccess(message: String, userModel: [CartListModel]) {
        self.cartList = userModel
        self.lblCartCount.text = "\(self.cartList.count)"
        self.tblvCartData.reloadData()
    }
    func CartListFaiure(message: String) {
        
    }
}
extension CartVC:AddCartViewModelDelegate{
    func AddCartSuccess(message: String, userModel: AddCartModel?) {
        cartlistVm.callCartListApi(category_id: "", user_id: "\(AppDefaults.loadCurrentUser()?.id ?? 0)")
    }
    func AddCartFaiure(message: String) {
        
    }
}
