//
//  Vahan Auth Token.swift
//  VI Vahan Flow Project
//
//  Created by iOS on 28/08/25.
//

import Foundation 
import SwiftyJSON

public class VahanAuthToken{
    
    public static let shared:VahanAuthToken = VahanAuthToken()
    
    private let vahanApi_GetAuthToken =  "https://delhigw.napix.gov.in/nic/parivahan/oauth2/token"
    
    // Get Vahan Auth Token
    public func fetch_VahanAuthToken(completion : @escaping ((_ resData:JSON?,_ error:NSError?) -> Void)){
        
        URLSessionTask.getData(apiURL: vahanApi_GetAuthToken,
                               parameters: [
                                "grant_type": "client_credentials",
                                "scope": "napix",
                                "client_id": VahanBasicInfo.client_id,
                                "client_secret": VahanBasicInfo.client_secret
                               ]) { resData, error in
                                   completion(resData,error)
                               }
    }
}
