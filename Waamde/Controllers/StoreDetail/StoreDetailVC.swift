//
//  StoreDetailVC.swift
//  Waamde
//
//  Created by Apple on 02/02/21.
//

import UIKit

struct catalogData {
    var image = ""
    var name = ""
}

class StoreDetailVC: UIViewController {
    var arrData = [catalogData]()
    @IBOutlet weak var tblvData: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblvData.delegate = self
        tblvData.dataSource = self
               arrData.append(catalogData(image: "casual-t-shirt-", name: "Clothing"))
               arrData.append(catalogData(image: "casual-t-shirt-", name: "Shoes"))
               arrData.append(catalogData(image: "casual-t-shirt-", name: "Accessories"))
               arrData.append(catalogData(image: "casual-t-shirt-", name: "Clothing"))
               arrData.append(catalogData(image: "casual-t-shirt-", name: "Shoes"))
               arrData.append(catalogData(image: "casual-t-shirt-", name: "Accessories"))
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
extension StoreDetailVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("catalogCell", owner: self, options: nil)?[0] as! catalogCell
        cell.lblData.text = arrData[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
