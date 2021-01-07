//
//  VCViewModel.swift
//  Vicara_Sample_App
//
//  Created by Neha Chaudhary on 06/01/21.
//  Copyright © 2021 Neha Chaudhary. All rights reserved.
//

import Foundation
import Alamofire

class VCViewModel {
    
    func sendLocationToServer() {
        
        let dict = ["lattitude"  :   currentLocation?.latitude ?? 0,
                    "longtitude" :   currentLocation?.longitude ?? 0]
        
        ServiceApi.fetchGetRequest(call: ServiceApi.getApi(api: .sendLocation), prams: dict, method: .post) { (response, status, json) in
            
            DispatchQueue.main.async {
                // handle response
            }
        }
    }
}



