//
//  OrderVc.swift
//  Waamde
//
//  Created by Apple on 30/01/21.
//

import UIKit

class NotificationVC: UIViewController {
    @IBOutlet weak var backView: CardView!
    @IBOutlet weak var tblvData: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backView.onCardTap = {
            self.dismiss(animated: true, completion: nil)
        }

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
extension NotificationVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("NotificationCell", owner: self, options: nil)?[0] as! NotificationCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
