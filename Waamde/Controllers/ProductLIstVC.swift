//
//  ProductLIstVC.swift
//  Waamde
//
//  Created by Apple on 15/03/21.
//

import UIKit

class ProductLIstVC: UIViewController,UISearchBarDelegate {
    var categoryId:String = ""
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionVw: UICollectionView!
    var dataSource = [ProductlistModel]()
    var addWishVm = AddWishListViewModel()
    var productvm = ProductListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionVw.delegate = self
        collectionVw.dataSource = self
        productvm.ptoductListVMDelegate = self
        addWishVm.addWishVMDelegate = self
        productvm.callProductListApi(category_id: categoryId, user_id: "")
        let layout = UICollectionViewFlowLayout()
                    layout.scrollDirection = .vertical
                    layout.minimumLineSpacing = 5
                    layout.minimumInteritemSpacing = 5
                    collectionVw.setCollectionViewLayout(layout, animated: true)
        collectionVw.register(UINib(nibName: "ProductCVC", bundle: nil), forCellWithReuseIdentifier: "ProductCVC")
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        productvm.SearchProductListApi(category_id: categoryId, user_id: "", product_name:searchBar.text ?? "", min_price: "", maxPrice: "")
    }
    @IBAction func btnAddWishList(_ sender: UIButton) {
        let data = dataSource[sender.tag]
        if data.wish_list == 0 || data.wish_list == nil{
            sender.setImage(UIImage(named: "heartFill"), for: .normal)
        }else{
            sender.setImage(UIImage(named: "heart (1)"), for: .normal)
        }
        addWishVm.callAddWishListApi(product_id:"\(data.id ?? 0)", user_id: "\(AppDefaults.loadCurrentUser()?.id ?? 0)")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
extension ProductLIstVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    //MARK: - Collection view datasource and delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
            let cell:ProductCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCVC", for: indexPath as IndexPath) as! ProductCVC;
            cell.backgroundColor = UIColor.clear
        cell.btnHeart.tag = indexPath.row
        cell.btnHeart.addTarget(self, action: #selector(btnAddWishList(_:)), for: .touchUpInside)
            cell.setValues(productListModel: dataSource[indexPath.row])
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = dataSource[indexPath.row]
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.productDetail, name: .productDetail) as! ProductDetail
        vc.product_id = "\(data.id ?? 0)"
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width:(collectionView.frame.size.width - 40)/2, height:215);
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}
extension ProductLIstVC: ProductListViewModelDelegate {
    
    func ProdctListSuccess(message:String, userModel:[ProductlistModel]) {
        dataSource = userModel
        collectionVw.reloadData()
    }
    
    func ProdctListFaiure(message:String) {
        AlertManager.showAlertControllerWith(message: .custom(message), controller: self, buttons: .ok(nil))
    }
    
}
