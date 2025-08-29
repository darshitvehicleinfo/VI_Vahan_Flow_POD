//
//  All Functions.swift
//  VI Vahan Flow Project
//
//  Created by iOS on 28/08/25.
//

import Foundation
import SwiftyJSON

extension NSDictionary{
    func convert_ToString() -> String
    {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self,
                                                      options: JSONSerialization.WritingOptions.prettyPrinted){
            
            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String   
            return jsonString
        }
        
        return ""
    }
}

extension String{
    func convert_ToJSON() -> JSON?
    {
        do  {
            let data = self.data(using: .utf8)
            let json = try JSON(data: data!)
            return json
        }catch {
            return nil
        }
    }
}
