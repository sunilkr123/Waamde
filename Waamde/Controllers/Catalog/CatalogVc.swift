//
//  CatalogVc.swift
//  Waamde
//
//  Created by Apple on 28/01/21.
//

import UIKit
class CatalogVc: UIViewController {
var arrayData = ["All","Men","Women","Kids"]
    var arrData = [CatalogModel]()
    var selectedData = "All"
    @IBOutlet weak var tblvData: UITableView!
    @IBOutlet weak var collectionCategory: UICollectionView!
    var categoryVM = CatelogViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
                           layout.scrollDirection = .horizontal
                           layout.minimumLineSpacing = 5
                           layout.minimumInteritemSpacing = 5
                           collectionCategory.setCollectionViewLayout(layout, animated: true)
        collectionCategory.register(UINib(nibName: "categoryTitleCell", bundle: nil), forCellWithReuseIdentifier: "categoryTitleCell")
        self.categoryVM.catelogVMDelegate = self
        categoryVM.callGetCatelogAPI()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CatalogVc: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    //MARK: - Collection view datasource and delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayData.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
       
            let cell:categoryTitleCell = collectionCategory.dequeueReusableCell(withReuseIdentifier: "categoryTitleCell", for: indexPath as IndexPath) as! categoryTitleCell;
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
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            selectedData = arrayData[indexPath.row]
        
        self.collectionCategory.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
       
        return CGSize(width:(collectionView.frame.size.width - 20)/4, height:40);
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}

extension CatalogVc:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("catalogCell", owner: self, options: nil)?[0] as! catalogCell
        cell.setValues(data: arrData[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let d = arrData[indexPath.row]
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.main, name: .ProductLIstVC) as! ProductLIstVC
        vc.categoryId = "\(d.id ?? 0)"
      vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

extension CatalogVc: CatelogViewModelDelegate {
    
    func catelogSuccess(message:String, categoryModel:[CatalogModel]) {
        arrData = categoryModel
        tblvData.reloadData()
    }
    
    func catelogFaiure(message: String) {
        AlertManager.showAlertControllerWith(message: .custom(message), controller: self, buttons: .ok(nil))
    }
    
}
