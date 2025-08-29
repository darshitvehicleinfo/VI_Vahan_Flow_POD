//
//  Vahan Basic Info.swift
//  VI Vahan Flow Project
//
//  Created by iOS on 28/08/25.
//

import Foundation


struct VahanBasicInfo{
    static var client_id = "b91c303443f61b37106750823881cd2f"
    static var client_secret = "de83eeeb148878ae375f28756492e8a0"
    static var ng_version_name = "2.0.134"
    
    static var currentTimestamp:Int64{
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
}

class VahanBasicInformation{
    static let shared:VahanBasicInformation = VahanBasicInformation()
    
    func init_VahanBasicInfo(clientId:String,
                             clientSecret:String,
                             ngVersionName:String){
        
        VahanBasicInfo.client_id = clientId
        VahanBasicInfo.client_id = clientSecret
        VahanBasicInfo.ng_version_name = ngVersionName
    }
}
