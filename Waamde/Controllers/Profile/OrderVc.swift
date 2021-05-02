//
//  OrderVc.swift
//  Waamde
//
//  Created by Apple on 30/01/21.
//

import UIKit

class OrderVc: UIViewController {
    @IBOutlet weak var backView: CardView!
    @IBOutlet weak var tblvData: UITableView!
    var data = [OrderModel]()

    
    var orderVM = orderViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        backView.onCardTap = {
            self.dismiss(animated: true, completion: nil)
        }
        orderVM.orderVMDelegate = self
       orderVM.callOrderApi()
        tblvData.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
extension OrderVc:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let d = data[indexPath.row]
        let cell = Bundle.main.loadNibNamed("OrderCell", owner: self, options: nil)?[0] as! OrderCell
        cell.lblOrderId.text = d.order_number
        if let date = Date(detectFromString:d.updated_at!){//dateFormatter.date(from:d.updated_at!){
            cell.lblDate.text = "\(date.toString(format: .custom("dd-MM-yyyy")))"
        }
        cell.btnStatus.setTitle(d.status, for: .normal)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.storeDetail, name: .OrderDetailVc) as! OrderDetailVc
        vc.orderListObj = data[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
extension OrderVc: OrderViewModelDelegate {
    
    func orderSuccess(message: String, userModel: [OrderModel]) {
        data = userModel
        self.tblvData.reloadData()
    }
    func orderFaiure(message: String) {
        
    }
   
    
}
