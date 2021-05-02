//
//  WriteReviewVC.swift
//  Waamde
//
//  Created by Apple on 12/02/21.
//

import UIKit

class WriteReviewVC: UIViewController {

    @IBOutlet weak var imgvLogo: UIImageView!
    @IBOutlet weak var txtvData: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgvLogo.layer.cornerRadius = 50
        txtvData.layer.borderWidth = 1
        txtvData.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnCancel(_ sender: Any) {
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
