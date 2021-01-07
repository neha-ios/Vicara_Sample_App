//
//  ServiceApi.swift
//  KioskApp
//
//  Created by Neha Chaudhary on 09/10/20.
//  Copyright © 2020 Pankaj. All rights reserved.
//

import Foundation
import Alamofire


let apiUrl = ""

enum ApiCall {
    
    case sendLocation

}


class ServiceApi {
    
    static func getApi(api : ApiCall) -> String {
        
        switch api {
        default:
            return "sendLocation"
        }
    }
    
  //  completition:@escaping () -> Void
    
    static func fetchGetRequest(call : String , prams : [String : Any], method : HTTPMethod ,   completion: @escaping (String?, Bool?, [String : Any]) -> Void) {
    
    
      let url = apiUrl + call
    
        // "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
        let headers : HTTPHeaders = [
            "api-version" : "1.0.0",
            "accept-lang" : "en"
        ]
        
        print(url)
        
        AF.request(url, method: method, parameters: prams, headers: headers).responseString  { response in
            
            switch response.result {
            case .success(let value):
                print(value)
            
                let data = Data(value.utf8)
                do {
                     if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                           // try to read out a string array
                        completion(json["message"] as! String, json["status"] as! Bool, json)
                       }
                } catch let error as NSError {
                    print(error)
                }
                
            case .failure(let error):
                //SVProgressHUD.dismiss()
                print(error)
            }
        }

    }
}



