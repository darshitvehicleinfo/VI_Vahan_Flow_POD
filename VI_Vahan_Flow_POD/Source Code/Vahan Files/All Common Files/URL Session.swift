//
//  URL Session.swift
//  VI Vahan Flow Project
//
//  Created by iOS on 28/08/25.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class URLSessionTask{
    
    class func getData(apiURL:String,
                       HTTPHeaderField:[String:String]? = nil,
                       parameters: [String:Any]? = nil,
                       requestHTTPBody:Data? = nil,
                       completion : @escaping ((_ resData:JSON?,_ error:NSError?) -> Void)){
        
        if !Reachability.isConnectedToNetwork()
        {
            completion(nil,CustomError.networkError())
            return
        }
        
        // Prepare the URL
        guard let url = URL(string: apiURL) else {
            completion(nil,CustomError.inValidURLError(url: apiURL))
            return
        }
        
        
        // Prepare the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let header = HTTPHeaderField{
            for (key,value) in header{
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Create the body data
        if let requestHTTPBody = requestHTTPBody{
            request.httpBody = requestHTTPBody
            
        }else if let parameters = parameters {
            let bodyString = parameters.map { key, value in
                return "\(key)=\(value)"
            }.joined(separator: "&")
            
            request.httpBody = bodyString.data(using: .utf8)
        }
        
        AF.request(request).responseJSON {
            (response) in
            print("----)))) Next Gen Stop ------> \(Date())")
            print("Response ->>>> \(response)")
            switch response.result {
            case .failure(let error):
                completion(nil, error as NSError)
            case .success(let data):
                completion(JSON(data), nil)
            }
        }
        
//        // Perform the network request using URLSession
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                completion(nil, error as NSError)
//                return
//            }
//            
//            guard let data = data else {
//                completion(nil, CustomError.noDataError())
//                return
//            }
//            
//            completion(data, nil)
//        }
//        
//        task.resume()
        
    }
    
    class func getData_CommonVahanAPI(apiURL:String,
                                      parmeterJSON: NSMutableDictionary,
                                      authToken:String,
                                      completion : @escaping ((_ resData:JSON?,_ error:NSError?) -> Void)){
        
        let timeStamp = "\(VahanBasicInfo.currentTimestamp)"
        let AESkey = AES_Enc_Dec.shared.generate_AESKey(timeStamp: timeStamp)
        let encrypted = AES_Enc_Dec.shared.encrypt_Base64(parmeterJSON,AESkey)
        let jsonData = "{\"data\":\"\(encrypted)\"}".data(using: .utf8, allowLossyConversion: false)!
        
        let headers = ["Content-Type": "application/json; charset=UTF-8",
                       "Authorization": authToken,
                       "Accept": "application/json",
                       "timestamp": timeStamp,
                       "Param1":"",
                       "Param2":VahanBasicInfo.ng_version_name]
        
        
        getData(apiURL: apiURL,
                HTTPHeaderField: headers,
                requestHTTPBody: jsonData) { resJson, error in
            
            if let resJson = resJson{
                
                if let dataVal = resJson["data"].string ,!dataVal.isEmpty{
                    
                    let decString = AES_Enc_Dec.shared.decrypt_Base64(dataVal, AESkey)
                    completion((decString ?? "").convert_ToJSON(),nil)
                    
                }else{
                    completion(resJson,nil)
                }
                
            } else {
                completion(nil,CustomError.invalidJSONError())
            }
        }
    }
}
