//
//  ProductDetail.swift
//  Waamde
//
//  Created by Apple on 31/01/21.
//

import UIKit

class ProductDetail: UIViewController {
    var table:ProductDetailTbl?
    var product_id = ""
    var quantity = 1
    var selectedColor = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductDetailTbl"{
            table = (segue.destination as! ProductDetailTbl)
            table?.myVc = self
            
            
        }
        
    }
    
    @IBAction func btnGotoProductSearch(_ sender: Any) {
        moveToProductList()
    }
    
}



extension UIViewController{
    func moveToProductList()  {
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.main, name: .ProductLIstVC) as! ProductLIstVC
        vc.categoryId = ""
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
