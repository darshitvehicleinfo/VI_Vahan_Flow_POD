//
//  AES Enc:Dec.swift
//  VI Vahan Flow Project
//
//  Created by iOS on 28/08/25.
//

import Foundation
import CryptoSwift

class AES_Enc_Dec {
    
    static let shared:AES_Enc_Dec = AES_Enc_Dec()
    
    func generate_AESKey(timeStamp:String? = nil) -> String
    {
        let timestamp = timeStamp ?? "\(VahanBasicInfo.currentTimestamp)"
        
        let firstHalf = String(String(timestamp.prefix(4)).reversed())
        let secondHalf = String(String(timestamp.suffix(4)).reversed())
        
        return "\(secondHalf)\(firstHalf)!~)#@*&^"
    }
}

// encrypt
extension AES_Enc_Dec{
    
    func encrypt_Base64(_ paramers_dic: NSMutableDictionary,
                        _ AESKey:String? = nil) -> String{
        
        do  {
            let encrypted = try encrypt_AES(dataString: paramers_dic.convert_ToString(),
                                            key: AESKey ?? generate_AESKey())
            
            let base64Convert = encrypted.toBase64()
            return base64Convert ?? ""
        }catch {
            return ""
        }
        
    }
    
    func encrypt_AES(dataString:String,
                     key: String) throws -> String {
        if !key.isEmpty{
            var result = ""
            
            //        do {
            
            let key: [UInt8] = Array(key.utf8) as [UInt8]
            
            let aes = try! AES(key: key, blockMode: ECB() , padding:.pkcs5) // AES128 .ECB pkcs7
            
            let encrypted = try aes.encrypt(Array(dataString.utf8))
            
            result = encrypted.toBase64()
            //        } catch {
            
            //            debugLogError("Log :- ERROR aesEncrypt:- \(error.localizedDescription)")
            //        }
            
            return result
        }
        
        return key
    }
}

// decrypt
extension AES_Enc_Dec{
    
    func decrypt_Base64(_ dataString: String,
                        _ AESKey:String? = nil) -> String?{
        
        do  {
            let decodedData = Data(base64Encoded: dataString)
            if let decodedString = String(data: decodedData!, encoding: .utf8){//base 64 encoded to  string
                
                let decryptString = try decrypt_AES(dataString: decodedString,
                                                    key: AESKey ?? generate_AESKey())//string decrypt by key
                return decryptString
            }else{
                return nil
            }
        }catch {
            return nil
        }
    }
    
    func decrypt_AES(dataString:String,
                     key: String) throws -> String {
        
        var result = ""
        
        do {
            
            let key: [UInt8] = Array(key.utf8) as [UInt8]
            let aes = try! AES(key: key, blockMode: ECB(), padding: .pkcs5) // AES128 .ECB pkcs7
            let decrypted = try aes.decrypt(Array(base64: dataString))
            
            result = String(data: Data(decrypted), encoding: .utf8) ?? ""
        
        } catch {
            
//            debugLogError("Log :- ERROR aesDecrypt:- \(error.localizedDescription)")
        }
        
        return result
    }
}









extension String {
    
    fileprivate func fromBase64() -> String?
    {
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }
        
        return String(data: data as Data, encoding: String.Encoding.utf8)
    }
    
    fileprivate func toBase64() -> String?
    {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
}
