//
//  Custom Error.swift
//  VI Vahan Flow Project
//
//  Created by iOS on 28/08/25.
//

import Foundation

class CustomError{
    
    // Convenience initializer for networkError
    class func networkError() -> NSError {
        let error = NSError(domain: "Vahan_Custom_Error",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey: "No internet connection was found. Check your connection or try again"])
        return error
    }
    
    class func inValidURLError(url:String) -> NSError {
        let error = NSError(domain: "Vahan_Custom_Error",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey: "Invalid URL :- \(url)"])
        return error
    }
    
    class func noDataError() -> NSError {
        let error = NSError(domain: "Vahan_Custom_Error",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey: "No data received"])
        return error
    }
    
    class func invalidJSONError() -> NSError {
        let error = NSError(domain: "Vahan_Custom_Error",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey: "Invalid JSON Formate or JSON is Not Valid"])
        return error
    }
}
