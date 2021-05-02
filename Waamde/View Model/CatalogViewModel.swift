

import Foundation
import SVProgressHUD

protocol CatelogViewModelDelegate {
    func catelogSuccess(message:String, categoryModel:[CatalogModel])
    func catelogFaiure(message:String)
}
extension CatelogViewModelDelegate {
    func catelogSuccess(message:String, categoryModel:[CatalogModel]){}
    func catelogFaiure(message:String){}
}

class CatelogViewModel {
    
    var catelogVMDelegate: CatelogViewModelDelegate?
    
    func callGetCatelogAPI() {
        SVProgressHUD.show()
        
        let categoryUrl = BASE_URL.getCategory.urlString()
        WebManager.shared.requestGETURL(categoryUrl, params: nil) { (result, error) in
            SVProgressHUD.dismiss()
            if let _ = result {
                if let getSuccess = result?[kCode] as? Int, getSuccess == 200 {
                   if let getData = result?[kData] as? [[String:Any]] {
                       guard let resultObj = try? JSONSerialization.data(withJSONObject: getData, options: .prettyPrinted) else {
                           return
                       }
                       do {
                           let categoryData = try JSONDecoder().decode(Array<CatalogModel>.self, from: resultObj)
                        self.catelogVMDelegate?.catelogSuccess(message: "", categoryModel: categoryData)
                       } catch {
                        LogManager.printVariable(variable:error )
                       }
                   }
                }
            } else {
                if let getMessage = result?[kMessage] as? String {
                    self.catelogVMDelegate?.catelogFaiure(message:getMessage)
                }
            }
        }
    }
}
