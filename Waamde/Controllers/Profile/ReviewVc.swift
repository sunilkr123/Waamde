//
//  ReviewVc.swift
//  Waamde
//
//  Created by Apple on 30/01/21.
//

import UIKit

class ReviewVc: UIViewController {
    var arrayData = ["All Reviews","With Images"]
    var arrData = [catalogData]()
    var selectedData = "All Reviews"
    @IBOutlet weak var tblvData: UITableView!
    @IBOutlet weak var backView: CardView!
    @IBOutlet weak var collectionCategory: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
                           layout.scrollDirection = .horizontal
                           layout.minimumLineSpacing = 5
                           layout.minimumInteritemSpacing = 5
                           collectionCategory.setCollectionViewLayout(layout, animated: true)
        collectionCategory.register(UINib(nibName: "categoryTitleCell", bundle: nil), forCellWithReuseIdentifier: "categoryTitleCell")
        backView.onCardTap = {
            self.dismiss(animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnWrite(_ sender: Any) {
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.profile, name: .writeReviewVC) as! WriteReviewVC
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
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
extension ReviewVc: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
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
       
        return CGSize(width:(collectionView.frame.size.width - 10)/2, height:40);
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}
extension ReviewVc:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ReviewCell", owner: self, options: nil)?[0] as! ReviewCell
        //cell.lblData.text = arrData[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
