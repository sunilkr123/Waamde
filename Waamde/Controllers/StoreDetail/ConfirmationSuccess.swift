//
//  ConfirmationSuccess.swift
//  Waamde
//
//  Created by Apple on 03/02/21.
//

import UIKit

class ConfirmationSuccess: UIViewController {

    var transactionId = ""
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var btnTrack: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnTrack.layer.borderWidth = 1
        btnTrack.layer.borderColor = UIColor(named: "AppColor")?.cgColor
        // Do any additional setup after loading the view.
        lblDetail.text = "Your order code : \(transactionId) Thank you for choosing our product"
    }
    
    @IBAction func btnNext(_ sender: Any) {
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.main, name: .roottab)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnTrack(_ sender: Any) {
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
