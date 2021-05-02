//
//  AddressTbl.swift
//  Waamde
//
//  Created by Apple on 03/02/21.
//

import UIKit

class AddressTbl: UITableViewController {

    @IBOutlet weak var paymentSegment: UISegmentedControl!
    @IBOutlet weak var txtfPhone: UITextField!
    @IBOutlet weak var txtfState: UITextField!
    @IBOutlet weak var txtfZip: UITextField!
    @IBOutlet weak var txtfCity: UITextField!
    @IBOutlet weak var txtfAddress: UITextField!
    @IBOutlet weak var txtfName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func btnNext(_ sender: Any) {
        var paymentMode = "cod"
        if paymentSegment.selectedSegmentIndex == 0{
            paymentMode = "cod"
        }else{
            paymentMode = "online"
        }
        if  doValidation(){
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.storeDetail, name: .ConfirmShopping) as! ConfirmShopping
        vc.modalPresentationStyle = .fullScreen
            let obj = OrderAddressModel(address: txtfAddress.text!, city: txtfCity.text!, zipCode: txtfZip.text!, state: txtfState.text!,name: txtfName.text!,phone: txtfPhone.text ?? "", paymentType: paymentMode)
        vc.addressObj = obj
        self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnNextClick(_ sender: Any) {
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //TODO:- place it into CheckOutViewModel
    func doValidation() ->Bool {
        guard !txtfName.text!.isEmpty else {
            AlertManager.showAlertControllerWith(message: .custom("Please enter Name"), controller: self, buttons: .ok(nil))
            return false
        }
        guard !txtfAddress.text!.isEmpty else {
            AlertManager.showAlertControllerWith(message: .custom("Please enter address"), controller: self, buttons: .ok(nil))
            return false
        }
        guard !txtfCity.text!.isEmpty else {
            AlertManager.showAlertControllerWith(message: .custom("Please enter city"), controller: self, buttons: .ok(nil))
            return false
        }
        guard !txtfZip.text!.isEmpty else {
            AlertManager.showAlertControllerWith(message: .custom("Please enter zipcode"), controller: self, buttons: .ok(nil))
            return false
        }
        guard !txtfState.text!.isEmpty else {
            AlertManager.showAlertControllerWith(message: .custom("Please enter state"), controller: self, buttons: .ok(nil))
            return false
        }
        guard !txtfPhone.text!.isEmpty else {
            AlertManager.showAlertControllerWith(message: .custom("Please enter mobile number"), controller: self, buttons: .ok(nil))
            return false
        }
        return true//validate successfully
    }
    
}
