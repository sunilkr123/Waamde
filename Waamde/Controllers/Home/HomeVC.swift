//
//  HomeVC.swift
//  Waamde
//
//  Created by Apple on 26/01/21.
//

import UIKit

class HomeVC: UIViewController {

    var arrayData = ["All","Men","Women","Kids"]
    var selectedData = "All"
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var collectionVw: UICollectionView!
    var data = HomeModel()

    
    var homeVM = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let layout = UICollectionViewFlowLayout()
                    layout.scrollDirection = .horizontal
                    layout.minimumLineSpacing = 5
                    layout.minimumInteritemSpacing = 5
                    collectionVw.setCollectionViewLayout(layout, animated: true)
        
        homeVM.homeVMDelegate = self
        homeVM.callGetHomeDataAPI()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
//        let vc = DesignManager.loadViewControllerFromStroyBoardWithName("SignUp", name: "LoginVc") as! LoginVc
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
       // homeVM.callGetHomeDataAPI()
    }
    
    func setupView() {
        vwBg.layer.cornerRadius = 10
        collectionVw.register(UINib(nibName: "categoryTitleCell", bundle: nil), forCellWithReuseIdentifier: "categoryTitleCell")
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
extension HomeVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    //MARK: - Collection view datasource and delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayData.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == collectionVw{
            let cell:categoryTitleCell = collectionVw.dequeueReusableCell(withReuseIdentifier: "categoryTitleCell", for: indexPath as IndexPath) as! categoryTitleCell;
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
        if collectionView == collectionVw{
            selectedData = arrayData[indexPath.row]
        }else{
//            let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.productDetail, name: .productDetail) as! ProductDetail
//            
//            vc.modalPresentationStyle = .fullScreen
//              self.present(vc, animated: true, completion: nil)
        }
        self.collectionVw.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == collectionVw{
        return CGSize(width:(collectionView.frame.size.width - 20)/4, height:40);
        }else{
            return CGSize(width:(collectionView.frame.size.width - 20)/2, height:200);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}

extension HomeVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 300 : 500
    }
    
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data.homeData?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
        let cell = Bundle.main.loadNibNamed("ImageTopTVC", owner: self, options: nil)?[0] as! ImageTopTVC
            cell.setValues(data: data.sliders?[0])
            cell.selectionStyle = .none
        return cell
        }
        let cell = Bundle.main.loadNibNamed("HomeProductTVC", owner: self, options: nil)?[0] as! HomeProductTVC
        cell.setValues(data: data.homeData?[indexPath.row - 1])
        cell.vc = self
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if indexPath.row == 0{
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.storeDetail, name: .storeDetailVC) as! StoreDetailVC
      vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        }else{
            let d = data.homeData?[indexPath.row - 1]
            let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.main, name: .ProductLIstVC) as! ProductLIstVC
            vc.categoryId = ""
          vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0.01
    }
    
    
}

extension HomeVC: HomeViewModelDelegate {
    
    func homeSuccess(message:String, homeModel:HomeModel) {
        data = homeModel
        tblVw.reloadData()
    }
    
    func homeFaiure(message:String) {
        AlertManager.showAlertControllerWith(message: .custom(message), controller: self, buttons: .ok(nil))
    }
    
}
