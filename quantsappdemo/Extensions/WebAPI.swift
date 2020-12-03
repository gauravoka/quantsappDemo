//
//  WebAPI.swift
//  quantsappdemo
//
//  Created by Gaurav Oka on 03/12/20.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class WebAPI: NSObject {
    //post request
    public class func httpJSONRequest(viewController:UIViewController,method: HTTPMethod, url:String,params:[String:AnyObject]?,header:HTTPHeaders, encoding: ParameterEncoding , SuccessHandler:@escaping (_ result: JSON) ->Void,Errorhandler:@escaping (_ error:NSError) -> Void){
         
        
//        let queue = DispatchQueue(label: "com.baswen.www", qos: .default, attributes: .concurrent)

        
        AF.request(url, method: method, parameters: params, encoding: encoding, headers: header ).validate().responseJSON{ (response) in
            switch response.result {
                
            case .success(let val):
                if let value = val as? [String: Any] {
                    let json = JSON(value)
                    SuccessHandler(json)
                }
                break
            case .failure(let error):
                Errorhandler(error as NSError)
                break
                
            }
        }
    }
    
    
//    class func httpRequest(viewController:UIViewController,method: HTTPMethod, url:String,SuccessHandler:@escaping (_ result: JSON) ->Void,Errorhandler:@escaping (_ error:NSError) -> Void){
//        
//        
//        AF.request(API.BASE_URL, method:method).validate().responseJSON { (response) in
//            switch response.result {
//                
//            case .success(let val):
//                if let value = val as? [String: Any] {
//                    let json = JSON(value)
//                    SuccessHandler(json)
//                }
//                break
//            case .failure(let error):
//                Errorhandler(error as NSError)
//                break
//                
//            }
//        }
//}

}

