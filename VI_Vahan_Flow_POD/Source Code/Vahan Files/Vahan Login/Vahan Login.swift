//
//  Vahan Login.swift
//  VI Vahan Flow Project
//
//  Created by iOS on 28/08/25.
//

import Foundation
import UIKit
import SwiftyJSON

public class VahanLogin{
    
    public static let shared:VahanLogin = VahanLogin()
    
    private let vahanApi_UserLogin =  "https://delhigw.napix.gov.in/nic/parivahan/mparivahan/citizenapi/service/getUserLoginToken"
    
    // Get Vahan Auth Token
    public func login_VahanToken(userDetail:MParivahanTokenDetail,
                          authToken: String,
                          completion : @escaping ((_ resData: JSON?,_ error:NSError?) -> Void)){
        
        let mparCitizenDevice: [String: Any] = [
            "deviceFcmToken": userDetail.fcmToken ?? ""
        ]
        
        // citizenLogin dictionary
        let citizenLogin: [String: Any] = [
            "ctzRecordId": userDetail.record_id, // make sure this is Int or Int64
            "ctzMobile": userDetail.mobile_no,
            "ctzDeviceId": userDetail.device_id,
            "deviceModel": userDetail.deviceModel ?? UIDevice.current.model  // equivalent of Build.MODEL
        ]

        // mparCitizenUser dictionary
        let mparCitizenUser: [String: Any] = [
            "ctzMpin": userDetail.mpin
        ]
        
        let paramers_dic: NSMutableDictionary = NSMutableDictionary()
        paramers_dic.addEntries(from: [
            "mparCitizenDevice": mparCitizenDevice,
            "citizenLogin": citizenLogin,
            "mparCitizenUser": mparCitizenUser
        ])
        
        
        URLSessionTask.getData_CommonVahanAPI(apiURL: vahanApi_UserLogin,
                                              parmeterJSON: paramers_dic,
                                              authToken: authToken) { resData, error in
            completion(resData,error)
        }
    }
}
