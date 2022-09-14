//
//  Networking.swift
//  Driving Trainers
//
//  Created by iws on 1/12/18.
//  Copyright © 2018 iWeb. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SystemConfiguration

open class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}

class DataProvider:NSObject {
    
    class var sharedInstance:DataProvider {
        struct Singleton {
            static let instance = DataProvider()
        }
        return Singleton.instance
    }
    
    
//    var parameter1:[String:Any] = ["token":UserDefaults.standard.string(forKey: "token") ?? ""]
    
    func getDataUsingPost(path:String , dataDict:[String:Any], _ successBlock:@escaping ( _ response: JSON )->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
        print(path)
//        parameter1.merge(dataDict) {(current, _) in current}
//        print(parameter1)
        Alamofire.request(path, method: .post, parameters: dataDict, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    successBlock(json)
                }
            case .failure(let error):
                errorBlock(error as NSError)
            }
        }
    }
    
    func getDataUsingPut(path:String , dataDict:[String:Any], _ successBlock:@escaping ( _ response: JSON )->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
        print(path)
        Alamofire.request(path, method: .put, parameters: dataDict, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    successBlock(json)
                }
            case .failure(let error):
                errorBlock(error as NSError)
            }
        }
    }
    
    func getDataUsingGet(path:String , _ successBlock:@escaping ( _ response: JSON )->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
        print(path)
        Alamofire.request(path, method: .get,encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    successBlock(json)
                }
            case .failure(let error):
                errorBlock(error as NSError)
            }
        }
    }
    
    
//    func getDataUsingGetNew(path:String , dataDict:[String:Any], _ successBlock:@escaping ( _ response: JSON )->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
//        print(path)
//        Alamofire.request(path, method: .get, parameters: dataDict, encoding: JSONEncoding.default).responseJSON { response in
//
//            switch response.result {
//            case .success:
//                if let value = response.result.value {
//                    let json = JSON(value)
//                    successBlock(json)
//                }
//            case .failure(let error):
//                errorBlock(error as NSError)
//            }
//        }
//    }
    
    
    
    func getDataFromRegister(path:String , dataDict:[String:Any], _ successBlock:@escaping ( _ response: JSON )->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
        print(path)
        print(dataDict)
        Alamofire.request(path, method: .post, parameters: dataDict, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    successBlock(json)
                }
            case .failure(let error):
                errorBlock(error as NSError)
            }
        }
    }
    
    
    func getDataFromGet(path:String , dataDict:[String:Any], _ successBlock:@escaping ( _ response: JSON )->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
        print(path)
        print(dataDict)
        Alamofire.request(path, method: .get, parameters: dataDict, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    successBlock(json)
                }
            case .failure(let error):
                errorBlock(error as NSError)
            }
        }
    }
    
    func getDataFromGetApi(path:String , dataDict:[String:Any], _ successBlock:@escaping ( _ response: JSON )->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
        print(path)
        print(dataDict)
        Alamofire.request(path, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    successBlock(json)
                }
            case .failure(let error):
                errorBlock(error as NSError)
            }
        }
    }

    
    
    func getDataUsingPostNew(path:String , _ successBlock:@escaping ( _ response: JSON )->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
        
        let parameter:[String:Any] = ["token":UserDefaults.standard.string(forKey: "token") ?? ""]
        print(path,parameter)
        Alamofire.request(path, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    successBlock(json)
                }
            case .failure(let error):
                errorBlock(error as NSError)
            }
        }
    }
    
    func getDataUsingPostForCreatingGroup(path:String , dataDict:[String:Any], _ successBlock:@escaping ( _ response: JSON )->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
        print(path)
        var parameter:[String:Any] = ["token":UserDefaults.standard.string(forKey: "token") ?? ""]
        parameter.merge(dataDict) {(current, _) in current}
        print(parameter)
        Alamofire.request(path, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    successBlock(json)
                }
            case .failure(let error):
                errorBlock(error as NSError)
            }
        }
    }
    
    
    typealias CompletionUploadBlock = (Data?) -> Void
    func callAPIForUpload(_ parameters:[String:Any], sUrl:String, imgData:Data, imageKey:String, completion:@escaping CompletionUploadBlock) -> Void {
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        
        print(headers,sUrl)
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: imageKey,fileName: "PostImage.png", mimeType: "image/png")
            for (key, value) in parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        },usingThreshold: UInt64.init(), to: sUrl, method: .post, headers: headers) { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                    
                })
                
                upload.responseJSON { response in
                    completion(response.data!)
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
}
