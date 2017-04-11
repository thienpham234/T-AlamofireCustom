//
//  ServerManager.swift
//  TCustomAlamofire
//
//  Created by ThienPham on 4/10/17.
//  Copyright © 2017 D.A.C Tech VN. All rights reserved.
//

import Foundation
import ReachabilitySwift
import AlamofireNetworkActivityIndicator
import Alamofire



public typealias Parameter = [String: Any]
public func DLog<T>(_ object: @autoclosure () -> T, file: String = #file, line: Int = #line, funcname: String = #function) {
    #if DEBUG
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss:SSS"
        
        let queue = Thread.isMainThread ? "FG" : "BG"
        let filePath = file as NSString
        
        let instance = object()
        let description: String
        
        description = "\(instance)"
        
        //print("\(dateFormatter.string(from:Date())) [\(queue)] [\(filePath.lastPathComponent):\(line)] \(funcname) > \(description)\n")
        
        print("\(dateFormatter.string(from:Date())) [\(queue)] [\(filePath.lastPathComponent):\(line)] > \(description)\n")
    #endif
}

public enum eHTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}
public enum StatusCode:NSInteger{
    case noInternetConnection = -1
}
public enum eContentTypeHTTPHeader: Int {
    case JSON
    case FormURLEncoded
}

public typealias JSONcompletion = (_ success: Bool, _ statusCode: NSInteger, _ responseObject: Any?, _ dict: Dictionary<String, Any>?, _ array: Array<Any>?, _ str: String?, _ error: Error?) -> Void

public typealias ProgressBlock = (_ progress: Progress) -> Void


public class ServerManager {
    
    // MARK: - GET
    
    /// Make GET request 1.
    public class func _makeGETrequest(baseURL: String,
                                      endpoint: String,
                                      params: Parameter?,
                                      showError: Bool = true,
                                      showHud: Bool = true,
                                      completion: JSONcompletion?) {
        
        self._makeGETrequest(baseURL: baseURL,
                             endpoint: endpoint,
                             params: params,
                             username: nil,
                             password: nil,
                             accessToken: nil,
                             showError: showError,
                             showHud: showHud,
                             completion: completion)
    }
    
    /// Make GET request 2.
    public class func _makeGETrequest(baseURL: String,
                                      endpoint: String,
                                      params: Parameter?,
                                      username: String? = nil,
                                      password: String? = nil,
                                      accessToken: String?,
                                      completion: JSONcompletion?) {
        
        self._makeGETrequest(baseURL: baseURL,
                             endpoint: endpoint,
                             params: params,
                             username: username,
                             password: password,
                             accessToken: accessToken,
                             showError: true,
                             showHud: true,
                             completion: completion)
        
    }
    
    /// Make GET request 3.
    public class func _makeGETrequest(baseURL: String,
                                      endpoint: String,
                                      params: Parameter?,
                                      username: String? = nil,
                                      password: String? = nil,
                                      accessToken: String?,
                                      showError: Bool,
                                      showHud: Bool,
                                      completion: JSONcompletion?) {
        
        _ = ServerManager._makeGETrequest(baseURL: baseURL,
                                          endpoint: endpoint,
                                          params: params,
                                          username: username,
                                          password: password,
                                          accessToken: accessToken,
                                          showError: showError,
                                          showHud: showHud,
                                          previousRequest: nil,
                                          completion: completion)
    }
    
    //MARK: -
    
    /// Make GET request 4 (returned DataRequest).
    public class func _makeGETrequest(baseURL: String,
                                      endpoint: String,
                                      params: Parameter?,
                                      username: String? = nil,
                                      password: String? = nil,
                                      accessToken: String?,
                                      showError: Bool,
                                      showHud: Bool,
                                      previousRequest: Any?,
                                      completion: JSONcompletion?) -> Any? {
        
        return ServerManager._makeBaseRequest(httpMethod: .GET,
                                              baseURL: baseURL,
                                              endpoint: endpoint,
                                              params: params,
                                              body: nil,
                                              fileData: nil,
                                              fileName: nil,
                                              fieldName: nil,
                                              username: username,
                                              password: password,
                                              accessToken: accessToken,
                                              contentType: .JSON,
                                              multipart: false,
                                              showError: showError,
                                              showHud: showHud,
                                              previousRequest: previousRequest,
                                              progressBlock: nil,
                                              completion: completion)
    }
    
    
    // MARK: - POST
    
    /// Make POST request 1.
    public class func _makePOSTrequest(baseURL: String,
                                       endpoint: String,
                                       params: Parameter?,
                                       body: Parameter?,
                                       showError: Bool = true,
                                       showHud: Bool = true,
                                       completion: JSONcompletion?) {
        
        self._makePOSTrequest(baseURL: baseURL,
                              endpoint: endpoint,
                              params: params,
                              body: body,
                              username: nil,
                              password: nil,
                              accessToken: nil,
                              showError: showError,
                              showHud: showHud,
                              completion: completion)
        
    }
    
    /// Make POST request 2.
    public class func _makePOSTrequest(baseURL: String,
                                       endpoint: String,
                                       params: Parameter?,
                                       body: Parameter?,
                                       username: String? = nil,
                                       password: String? = nil,
                                       accessToken: String?,
                                       completion: JSONcompletion?) {
        
        self._makePOSTrequest(baseURL: baseURL,
                              endpoint: endpoint,
                              params: params,
                              body: body,
                              username: username,
                              password: password,
                              accessToken: accessToken,
                              contentType: .JSON,
                              showError: true,
                              showHud: true,
                              completion: completion)
        
    }
    
    /// Make POST request 3.
    public class func _makePOSTrequest(baseURL: String,
                                       endpoint: String,
                                       params: Parameter?,
                                       body: Parameter?,
                                       username: String? = nil,
                                       password: String? = nil,
                                       accessToken: String?,
                                       showError: Bool,
                                       showHud: Bool,
                                       completion: JSONcompletion?) {
        
        self._makePOSTrequest(baseURL: baseURL,
                              endpoint: endpoint,
                              params: params,
                              body: body,
                              username: username,
                              password: password,
                              accessToken: accessToken,
                              contentType: .JSON,
                              showError: showError,
                              showHud: showHud,
                              completion: completion)
        
    }
    
    /// Make POST request 4.
    public class func _makePOSTrequest(baseURL: String,
                                       endpoint: String,
                                       params: Parameter?,
                                       body: Parameter?,
                                       username: String? = nil,
                                       password: String? = nil,
                                       accessToken: String?,
                                       contentType: eContentTypeHTTPHeader,
                                       showError: Bool,
                                       showHud: Bool,
                                       completion: JSONcompletion?) {
        
        _ = self._makePOSTrequest(baseURL: baseURL,
                                  endpoint: endpoint,
                                  params: params,
                                  body: body,
                                  username: username,
                                  password: password,
                                  accessToken: accessToken,
                                  contentType: contentType,
                                  showError: showError,
                                  showHud: showHud,
                                  previousRequest: nil,
                                  completion: completion)
    }
    
    //MARK:-
    
    /// Make POST request 5 (returned DataRequest).
    public class func _makePOSTrequest(baseURL: String,
                                       endpoint: String,
                                       params: Parameter?,
                                       body: Parameter?,
                                       username: String? = nil,
                                       password: String? = nil,
                                       accessToken: String?,
                                       contentType: eContentTypeHTTPHeader,
                                       showError: Bool,
                                       showHud: Bool,
                                       previousRequest: Any?,
                                       completion: JSONcompletion?) -> Any? {
        
        return self._makeBaseRequest(httpMethod: .POST,
                                     baseURL: baseURL,
                                     endpoint: endpoint,
                                     params: params,
                                     body: body,
                                     fileData: nil,
                                     fileName: nil,
                                     fieldName: nil,
                                     username: username,
                                     password: password,
                                     accessToken: accessToken,
                                     contentType: contentType,
                                     multipart: false,
                                     showError: showError,
                                     showHud: showHud,
                                     previousRequest: previousRequest,
                                     progressBlock: nil,
                                     completion: completion)
    }
    
    //MARK:-
    
    /// Make POST multipart request 1.
    public class func _makePOSTmultipartRequest(baseURL: String,
                                                endpoint: String,
                                                params: Parameter?,
                                                body: Parameter?,
                                                fileData: Data,
                                                fileName: String?,
                                                fieldName: String,
                                                contentType: eContentTypeHTTPHeader,
                                                showError: Bool = true,
                                                showHud: Bool = true,
                                                progressBlock: ProgressBlock?,
                                                completion: JSONcompletion?) {
        
        self._makePOSTmultipartRequest(baseURL: baseURL,
                                       endpoint: endpoint,
                                       params: params,
                                       body: body,
                                       fileData: fileData,
                                       fileName: fileName,
                                       fieldName: fieldName,
                                       username: nil,
                                       password: nil,
                                       accessToken: nil,
                                       contentType: contentType,
                                       showError: showError,
                                       showHud: showHud,
                                       progressBlock: progressBlock,
                                       completion: completion)
        
    }
    
    /// Make POST multipart request 2.
    public class func _makePOSTmultipartRequest(baseURL: String,
                                                endpoint: String,
                                                params: Parameter?,
                                                body: Parameter?,
                                                fileData: Data,
                                                fileName: String?,
                                                fieldName: String,
                                                username: String? = nil,
                                                password: String? = nil,
                                                accessToken: String?,
                                                contentType: eContentTypeHTTPHeader,
                                                progressBlock: ProgressBlock?,
                                                completion: JSONcompletion?) {
        
        self._makePOSTmultipartRequest(baseURL: baseURL,
                                       endpoint: endpoint,
                                       params: params,
                                       body: body,
                                       fileData: fileData,
                                       fileName: fileName,
                                       fieldName: fieldName,
                                       username: username,
                                       password: password,
                                       accessToken: accessToken,
                                       contentType: contentType,
                                       showError: true,
                                       showHud: true,
                                       progressBlock: progressBlock,
                                       completion: completion)
    }
    
    /// Make POST multipart request 3.
    public class func _makePOSTmultipartRequest(baseURL: String,
                                                endpoint: String,
                                                params: Parameter?,
                                                body: Parameter?,
                                                fileData: Data,
                                                fileName: String?,
                                                fieldName: String,
                                                username: String? = nil,
                                                password: String? = nil,
                                                accessToken: String?,
                                                contentType: eContentTypeHTTPHeader,
                                                showError: Bool,
                                                showHud: Bool,
                                                progressBlock: ProgressBlock?,
                                                completion: JSONcompletion?) {
        
        _ = self._makePOSTmultipartRequest(baseURL: baseURL,
                                           endpoint: endpoint,
                                           params: params,
                                           body: body,
                                           fileData: fileData,
                                           fileName: fileName,
                                           fieldName: fieldName,
                                           username: username,
                                           password: password,
                                           accessToken: accessToken,
                                           contentType: contentType,
                                           showError: showError,
                                           showHud: showHud,
                                           previousRequest: nil,
                                           progressBlock: progressBlock,
                                           completion: completion)
    }
    
    //MARK:-
    
    /// Make POST multipart request 4 (returned DataRequest).
    public class func _makePOSTmultipartRequest(baseURL: String,
                                                endpoint: String,
                                                params: Parameter?,
                                                body: Parameter?,
                                                fileData: Data,
                                                fileName: String?,
                                                fieldName: String,
                                                username: String? = nil,
                                                password: String? = nil,
                                                accessToken: String?,
                                                contentType: eContentTypeHTTPHeader,
                                                showError: Bool,
                                                showHud: Bool,
                                                previousRequest: Any?,
                                                progressBlock: ProgressBlock?,
                                                completion: JSONcompletion?) -> Any? {
        
        return self._makeBaseRequest(httpMethod: .POST,
                                     baseURL: baseURL,
                                     endpoint: endpoint,
                                     params: params,
                                     body: body,
                                     fileData: fileData,
                                     fileName: fileName,
                                     fieldName: fieldName,
                                     username: username,
                                     password: password,
                                     accessToken: accessToken,
                                     contentType: contentType,
                                     multipart: true,
                                     showError: showError,
                                     showHud: showHud,
                                     previousRequest: previousRequest,
                                     progressBlock: progressBlock,
                                     completion: completion)
    }
    
    
    // MARK: - PUT
    
    /// Make PUT request 1.
    public class func _makePUTrequest(baseURL: String,
                                      endpoint: String,
                                      params: Parameter?,
                                      body: Parameter?,
                                      showError: Bool = true,
                                      showHud: Bool = true,
                                      completion: JSONcompletion?) {
        
        self._makePUTrequest(baseURL: baseURL,
                             endpoint: endpoint,
                             params: params,
                             body: body,
                             username: nil,
                             password: nil,
                             accessToken: nil,
                             showError: showError,
                             showHud: showHud,
                             completion: completion)
        
    }
    
    /// Make PUT request 2.
    public class func _makePUTrequest(baseURL: String,
                                      endpoint: String,
                                      params: Parameter?,
                                      body: Parameter?,
                                      username: String? = nil,
                                      password: String? = nil,
                                      accessToken: String?,
                                      completion: JSONcompletion?) {
        
        self._makePUTrequest(baseURL: baseURL,
                             endpoint: endpoint,
                             params: params,
                             body: body,
                             username: username,
                             password: password,
                             accessToken: accessToken,
                             contentType: .JSON,
                             showError: true,
                             showHud: true,
                             completion: completion)
        
    }
    
    /// Make PUT request 3.
    public class func _makePUTrequest(baseURL: String,
                                      endpoint: String,
                                      params: Parameter?,
                                      body: Parameter?,
                                      username: String? = nil,
                                      password: String? = nil,
                                      accessToken: String?,
                                      showError: Bool,
                                      showHud: Bool,
                                      completion: JSONcompletion?) {
        
        self._makePUTrequest(baseURL: baseURL,
                             endpoint: endpoint,
                             params: params,
                             body: body,
                             username: username,
                             password: password,
                             accessToken: accessToken,
                             contentType: .JSON,
                             showError: showError,
                             showHud: showHud,
                             completion: completion)
        
    }
    
    /// Make PUT request 4.
    public class func _makePUTrequest(baseURL: String,
                                      endpoint: String,
                                      params: Parameter?,
                                      body: Parameter?,
                                      username: String? = nil,
                                      password: String? = nil,
                                      accessToken: String?,
                                      contentType: eContentTypeHTTPHeader,
                                      showError: Bool,
                                      showHud: Bool,
                                      completion: JSONcompletion?) {
        
        _ = self._makePUTrequest(baseURL: baseURL,
                                 endpoint: endpoint,
                                 params: params,
                                 body: body,
                                 username: username,
                                 password: password,
                                 accessToken: accessToken,
                                 contentType: contentType,
                                 showError: showError,
                                 showHud: showHud,
                                 previousRequest: nil,
                                 completion: completion)
    }
    
    //MARK:-
    
    /// Make PUT request 5 (returned DataRequest).
    public class func _makePUTrequest(baseURL: String,
                                      endpoint: String,
                                      params: Parameter?,
                                      body: Parameter?,
                                      username: String? = nil,
                                      password: String? = nil,
                                      accessToken: String?,
                                      contentType: eContentTypeHTTPHeader,
                                      showError: Bool,
                                      showHud: Bool,
                                      previousRequest: Any?,
                                      completion: JSONcompletion?) -> Any? {
        
        return self._makeBaseRequest(httpMethod: .PUT,
                                     baseURL: baseURL,
                                     endpoint: endpoint,
                                     params: params,
                                     body: body,
                                     fileData: nil,
                                     fileName: nil,
                                     fieldName: nil,
                                     username: username,
                                     password: password,
                                     accessToken: accessToken,
                                     contentType: contentType,
                                     multipart: false,
                                     showError: showError,
                                     showHud: showHud,
                                     previousRequest: previousRequest,
                                     progressBlock: nil,
                                     completion: completion)
    }
    
    //MARK:-
    
    /// Make PUT multipart request 1.
    public class func _makePUTmultipartRequest(baseURL: String,
                                               endpoint: String,
                                               params: Parameter?,
                                               body: Parameter?,
                                               fileData: Data,
                                               fileName: String?,
                                               fieldName: String,
                                               contentType: eContentTypeHTTPHeader,
                                               showError: Bool = true,
                                               showHud: Bool = true,
                                               progressBlock: ProgressBlock?,
                                               completion: JSONcompletion?) {
        
        self._makePUTmultipartRequest(baseURL: baseURL,
                                      endpoint: endpoint,
                                      params: params,
                                      body: body,
                                      fileData: fileData,
                                      fileName: fileName,
                                      fieldName: fieldName,
                                      username: nil,
                                      password: nil,
                                      accessToken: nil,
                                      contentType: contentType,
                                      showError: showError,
                                      showHud: showHud,
                                      progressBlock: progressBlock,
                                      completion: completion)
        
    }
    
    /// Make PUT multipart request 2.
    public class func _makePUTmultipartRequest(baseURL: String,
                                               endpoint: String,
                                               params: Parameter?,
                                               body: Parameter?,
                                               fileData: Data,
                                               fileName: String?,
                                               fieldName: String,
                                               username: String? = nil,
                                               password: String? = nil,
                                               accessToken: String?,
                                               contentType: eContentTypeHTTPHeader,
                                               progressBlock: ProgressBlock?,
                                               completion: JSONcompletion?) {
        
        self._makePUTmultipartRequest(baseURL: baseURL,
                                      endpoint: endpoint,
                                      params: params,
                                      body: body,
                                      fileData: fileData,
                                      fileName: fileName,
                                      fieldName: fieldName,
                                      username: username,
                                      password: password,
                                      accessToken: accessToken,
                                      contentType: contentType,
                                      showError: true,
                                      showHud: true,
                                      progressBlock: progressBlock,
                                      completion: completion)
    }
    
    /// Make PUT multipart request 4.
    public class func _makePUTmultipartRequest(baseURL: String,
                                               endpoint: String,
                                               params: Parameter?,
                                               body: Parameter?,
                                               fileData: Data,
                                               fileName: String?,
                                               fieldName: String,
                                               username: String? = nil,
                                               password: String? = nil,
                                               accessToken: String?,
                                               contentType: eContentTypeHTTPHeader,
                                               showError: Bool,
                                               showHud: Bool,
                                               progressBlock: ProgressBlock?,
                                               completion: JSONcompletion?) {
        
        _ = self._makePUTmultipartRequest(baseURL: baseURL,
                                          endpoint: endpoint,
                                          params: params,
                                          body: body,
                                          fileData: fileData,
                                          fileName: fileName,
                                          fieldName: fieldName,
                                          username: username,
                                          password: password,
                                          accessToken: accessToken,
                                          contentType: contentType,
                                          showError: showError,
                                          showHud: showHud,
                                          previousRequest: nil,
                                          progressBlock: progressBlock,
                                          completion: completion)
    }
    
    //MARK:-
    
    /// Make PUT multipart request 4 (returned DataRequest).
    public class func _makePUTmultipartRequest(baseURL: String,
                                               endpoint: String,
                                               params: Parameter?,
                                               body: Parameter?,
                                               fileData: Data,
                                               fileName: String?,
                                               fieldName: String,
                                               username: String? = nil,
                                               password: String? = nil,
                                               accessToken: String?,
                                               contentType: eContentTypeHTTPHeader,
                                               showError: Bool,
                                               showHud: Bool,
                                               previousRequest: Any?,
                                               progressBlock: ProgressBlock?,
                                               completion: JSONcompletion?) -> Any? {
        
        return self._makeBaseRequest(httpMethod: .PUT,
                                     baseURL: baseURL,
                                     endpoint: endpoint,
                                     params: params,
                                     body: body,
                                     fileData: fileData,
                                     fileName: fileName,
                                     fieldName: fieldName,
                                     username: username,
                                     password: password,
                                     accessToken: accessToken,
                                     contentType: contentType,
                                     multipart: true,
                                     showError: showError,
                                     showHud: showHud,
                                     previousRequest: previousRequest,
                                     progressBlock: progressBlock,
                                     completion: completion)
    }
    
    
    // MARK: - DELETE
    
    /// Make DELETE request 1.
    public class func _makeDELETErequest(baseURL: String,
                                         endpoint: String,
                                         params: Parameter?,
                                         body: Parameter?,
                                         showError: Bool = true,
                                         showHud: Bool = true,
                                         completion: JSONcompletion?) {
        
        self._makeDELETErequest(baseURL: baseURL,
                                endpoint: endpoint,
                                params: params,
                                body: body,
                                username: nil,
                                password: nil,
                                accessToken: nil,
                                showError: showError,
                                showHud: showHud,
                                completion: completion)
        
    }
    
    /// Make DELETE request 2.
    public class func _makeDELETErequest(baseURL: String,
                                         endpoint: String,
                                         params: Parameter?,
                                         body: Parameter?,
                                         username: String? = nil,
                                         password: String? = nil,
                                         accessToken: String?,
                                         completion: JSONcompletion?) {
        
        self._makeDELETErequest(baseURL: baseURL,
                                endpoint: endpoint,
                                params: params,
                                body: body,
                                username: username,
                                password: password,
                                accessToken: accessToken,
                                showError: true,
                                showHud: true,
                                completion: completion)
    }
    
    /// Make DELETE request 3.
    public class func _makeDELETErequest(baseURL: String,
                                         endpoint: String,
                                         params: Parameter?,
                                         body: Parameter?,
                                         username: String? = nil,
                                         password: String? = nil,
                                         accessToken: String?,
                                         showError: Bool,
                                         showHud: Bool,
                                         completion: JSONcompletion?) {
        
        _ = self._makeDELETErequest(baseURL: baseURL,
                                    endpoint: endpoint,
                                    params: params,
                                    body: body,
                                    username: username,
                                    password: password,
                                    accessToken: accessToken,
                                    showError: showError,
                                    showHud: showHud,
                                    previousRequest: nil,
                                    completion: completion)
    }
    
    //MARK:-
    
    /// Make DELETE request 4 (returned DataRequest).
    public class func _makeDELETErequest(baseURL: String,
                                         endpoint: String,
                                         params: Parameter?,
                                         body: Parameter?,
                                         username: String? = nil,
                                         password: String? = nil,
                                         accessToken: String?,
                                         showError: Bool,
                                         showHud: Bool,
                                         previousRequest: Any?,
                                         completion: JSONcompletion?) -> Any? {
        
        return self._makeBaseRequest(httpMethod: .DELETE,
                                     baseURL: baseURL,
                                     endpoint: endpoint,
                                     params: params,
                                     body: body,
                                     fileData: nil,
                                     fileName: nil,
                                     fieldName: nil,
                                     username: username,
                                     password: password,
                                     accessToken: accessToken,
                                     contentType: .JSON,
                                     multipart: false,
                                     showError: showError,
                                     showHud: showHud,
                                     previousRequest: previousRequest,
                                     progressBlock: nil,
                                     completion: completion)
    }
    
    
    // MARK: - BASE
    
    /// Make base request 1.
    public class func _makeBaseRequest(httpMethod: eHTTPMethod,
                                       baseURL: String,
                                       endpoint: String,
                                       params: Parameter?,
                                       body: Parameter?,
                                       fileData: Data?,
                                       fileName: String?,
                                       fieldName: String?,
                                       username: String?,
                                       password: String?,
                                       accessToken: String?,
                                       contentType: eContentTypeHTTPHeader,
                                       multipart: Bool,
                                       showError: Bool,
                                       showHud: Bool,
                                       progressBlock: ProgressBlock?,
                                       completion: JSONcompletion?) {
        
        _ = ServerManager._makeBaseRequest(httpMethod: httpMethod,
                                           baseURL: baseURL,
                                           endpoint: endpoint,
                                           params: params,
                                           body: body,
                                           fileData: fileData,
                                           fileName: fileName,
                                           fieldName: fieldName,
                                           username: username,
                                           password: password,
                                           accessToken: accessToken,
                                           contentType: contentType,
                                           multipart: multipart,
                                           showError: showError,
                                           showHud: showHud,
                                           previousRequest: nil,
                                           progressBlock: progressBlock,
                                           completion: completion)
    }
    
    /// Make base request 2.
    public class func _makeBaseRequest(httpMethod: eHTTPMethod,
                                       baseURL: String,
                                       endpoint: String,
                                       params: Parameter?,
                                       body: Parameter?,
                                       fileData: Data?,
                                       fileName: String?,
                                       fieldName: String?,
                                       username: String?,
                                       password: String?,
                                       accessToken: String?,
                                       contentType: eContentTypeHTTPHeader,
                                       multipart: Bool,
                                       showError: Bool,
                                       showHud: Bool,
                                       previousRequest: Any?,
                                       progressBlock: ProgressBlock?,
                                       completion: JSONcompletion?) -> Any? {
        
        if showError {
            if self._noConnection() {
                // statusCode -1: operation failed with no internet connect error
                completion?(false, StatusCode.noInternetConnection.rawValue, nil, nil, nil, nil, nil)
                return nil
            }
        }
        
        // Cancel previous request
        if let previousRequest = previousRequest as? DataRequest
        {
            previousRequest.cancel()
            DLog("Canceled previous request")
        }
        
        let queryParams = self._serializeParams(params)
        let urlString = "\(baseURL)\(endpoint)\(queryParams)"
        let method = httpMethod.rawValue
        
        DLog("\nServer \(method) request made to URL:\n\(urlString) \nBODY:\n\(body?._formatJSON(prettyPrinted: true) ?? "Empty")")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        //
        switch httpMethod {
        case .POST, .PUT:
            if multipart == false {
                if contentType == .JSON {
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    if body != nil {
                        let postData = body!._jsonData()
                        request.httpBody = postData
                    }
                }
                else {
                    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                    if body != nil {
                        let postData = self._encodePostParameters(body!)
                        //let postData = self._formEncode(body!)
                        request.httpBody = postData
                    }
                }
            }
        case .DELETE:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if body != nil {
                let postData = body!._jsonData()
                request.httpBody = postData
            }
        default:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        
        //
        if username != nil && password != nil {
            let authStr = "\(username!):\(password!)"
            let authData = authStr.data(using: String.Encoding.utf8)!
            let authValue = "Basic \(authData.base64EncodedString())"
            request.setValue(authValue, forHTTPHeaderField: "Authorization")
            DLog(authValue)
        }
        else if accessToken != nil {
            let authValue = "Bearer \(accessToken!)"
            request.setValue(authValue, forHTTPHeaderField: "Authorization")
            DLog(authValue)
        }
        
        //ADD GZIP SUPPORT
        request.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
        
        
        // Start ActivityIndicator
        //Common._setNetworkActivityIndicatorVisible(true)
        if showHud {
            Common._showProgressHUD(dimsBackground: true)
        }
        
        if multipart == false {
            //Alamofire.request(request).validate(statusCode: 200..<300)
            return Alamofire.request(request).responseData(completionHandler: { (response) in
                
                //Common._setNetworkActivityIndicatorVisible(false)
                if showHud {
                    Common._hideHUD()
                }
                
                DLog("\n<<==================================================== BEGIN")
                DLog(response.timeline.description)
                DLog("Request URL: \(urlString)")
                
                switch response.result {
                case .success(let data):
                    DLog("API Response - Success: true - StatusCode: \(response.response?.statusCode ?? 0)")
                    DLog("API Success: \(String(describing: String(data: data, encoding: .utf8)))")
                    self._processResponse(success: true, data: data, response: response, error: nil, completion: completion)
                    DLog("\n====================================================>> END")
                case .failure(let error):
                    DLog("API Response - Success: false - StatusCode: \(response.response?.statusCode ?? 0)")
                    DLog("API Failure: " + error.localizedDescription)
                    self._processResponse(success: false, data: nil, response: response, error: error, completion: completion)
                    DLog("\n====================================================>> END")
                }
            })
        }
        else {
            
            assert(fileData != nil, "Multipart require fileData")
            assert(fieldName != nil, "Multipart require fieldName")
            
            let mimeType = self._mimeType(fileData!)
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                if fileName == nil {
                    multipartFormData.append(fileData!, withName: fieldName!, mimeType: mimeType)
                }
                else {
                    multipartFormData.append(fileData!, withName: fieldName!, fileName: fileName!, mimeType: mimeType)
                }
                
                if body != nil {
                    for (key, value) in body! {
                        if value is String || value is Int {
                            multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                        }
                    }
                }
                
            }, with: request,
               encodingCompletion: { (encodingResult) in
                
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    if progressBlock != nil {
                        upload.uploadProgress(closure: { (progress) in
                            progressBlock?(progress)
                            DLog("Upload Progress: \(progress.fractionCompleted)")
                        })
                    }
                    
                    //upload.validate(statusCode: 200..<300)
                    upload.responseData(completionHandler: { (response) in
                        
                        //Common._setNetworkActivityIndicatorVisible(false)
                        if showHud {
                            Common._hideHUD()
                        }
                        
                        DLog("\n<<==================================================== BEGIN")
                        DLog(response.timeline.description)
                        DLog("Request URL: \(urlString)")
                        
                        switch response.result {
                        case .success(let data):
                            DLog("API Response - Success: true - StatusCode: \(response.response?.statusCode ?? 0)")
                            DLog("API Success: \(String(describing: String(data: data, encoding: .utf8)))")
                            self._processResponse(success: true, data: data, response: response, error: nil, completion: completion)
                            DLog("\n====================================================>> END")
                        case .failure(let error):
                            DLog("API Response - Success: false - StatusCode: \(response.response?.statusCode ?? 0)")
                            DLog("API Failure: " + error.localizedDescription)
                            self._processResponse(success: false, data: nil, response: response, error: error, completion: completion)
                            DLog("\n====================================================>> END")
                        }
                    })
                    
                case .failure(let error):
                    //Common._setNetworkActivityIndicatorVisible(false)
                    if showHud {
                        Common._hideHUD()
                    }
                    DLog("Request Failure: " + error.localizedDescription)
                    self._processResponse(success: false, data: nil, response: nil, error: error, completion: completion)
                }
            })
            
            // In this case, not needed return DataRequest
            return nil
        }
    }
    
    /// Make 3rd party request.
    public class func _make3rdPartyRequest(httpMethod: eHTTPMethod,
                                           urlString: String,
                                           header: Parameter?,
                                           body: Parameter?,
                                           contentType: eContentTypeHTTPHeader,
                                           showError: Bool,
                                           showHud: Bool,
                                           completion: JSONcompletion?)
    {
        if showError
        {
            if self._noConnection()
            {
                // statusCode -1: operation failed with no internet connect error
                completion?(false, StatusCode.noInternetConnection.rawValue, nil, nil, nil, nil, nil)
                return
            }
        }
        
        let method = httpMethod.rawValue
        DLog("\nServer \(method) request made to URL:\n\(urlString) \nBODY:\n\(body?._formatJSON(prettyPrinted: true) ?? "Empty")")
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        switch httpMethod
        {
        case .POST, .PUT:
            if contentType == .JSON
            {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                if body != nil
                {
                    let postData = body!._jsonData()
                    request.httpBody = postData
                }
            }
            else if contentType == .FormURLEncoded
            {
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                if body != nil
                {
                    let postData = self._encodePostParameters(body!)
                    //let postData = self._formEncode(body!)
                    request.httpBody = postData
                }
            }
        case .DELETE:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if body != nil
            {
                let postData = body!._jsonData()
                request.httpBody = postData
            }
        default:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        if let header = header
        {
            for (key, value) in header
            {
                request.setValue(value as? String, forHTTPHeaderField: key)
            }
        }
        
        //ADD GZIP SUPPORT
        request.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
        
        if showHud
        {
            Common._showProgressHUD(dimsBackground: true)
        }
        
        Alamofire.request(request).responseData(completionHandler:
            { (response) in
                
                //Common._setNetworkActivityIndicatorVisible(false)
                if showHud
                {
                    Common._hideHUD()
                }
                
                DLog("\n<<==================================================== BEGIN")
                DLog(response.timeline.description)
                DLog("Request URL: \(urlString)")
                
                switch response.result
                {
                case .success(let data):
                    DLog("API Response - Success: true - StatusCode: \(response.response?.statusCode ?? 0)")
                    DLog("API Success: \(String(describing: String(data: data, encoding: .utf8)))")
                    self._processResponse(success: true, data: data, response: response, error: nil, completion: completion)
                    DLog("\n====================================================>> END")
                    
                case .failure(let error):
                    DLog("API Response - Success: false - StatusCode: \(response.response?.statusCode ?? 0)")
                    DLog("API Failure: " + error.localizedDescription)
                    self._processResponse(success: false, data: nil, response: response, error: error, completion: completion)
                    DLog("\n====================================================>> END")
                }
        })
    }
    
    //MARK:- Cancel Request
    
    public class func cancelRequest(request: Any?) {
        // Cancel request
        if let request = request as? DataRequest
        {
            request.cancel()
            DLog("Canceled request")
        }
    }
    
    /// Process response.
    class func _processResponse(success:Bool, data: Data?, response: (DataResponse<Data>)?, error: Error?, completion: JSONcompletion?) {
        
        var dict: Parameter?
        var array: [Any]?
        var str: String?
        var statusCode = 0
        var json: Any?
        
        if (response != nil) && (response!.response != nil) && (completion != nil) {
            statusCode = response!.response!.statusCode
        }
        
        var apiSuccess = success
        
        // Manual Validation
        if (200..<300).contains(statusCode) == false {
            apiSuccess = false
        }
        DLog("Process Response - Success: \(apiSuccess) - StatusCode: \(statusCode)")
        
        var customError: Error? = error
        if /*apiSuccess &&*/ (completion != nil) {
            if let mData = data, mData.count > 0 {
                json = (try? JSONSerialization.jsonObject(with: mData, options: JSONSerialization.ReadingOptions.mutableContainers))
                
                if json != nil {
                    if (json is Parameter) {
                        dict = (json as? Parameter)
                        if apiSuccess, let isSuccess = dict!["success"] as? Bool {
                            apiSuccess = isSuccess
                        }
                        
                        if error == nil, let errorMessage = dict!["error_message"] as? String {
                            let userInfo: [String : String] = [
                                NSLocalizedDescriptionKey : errorMessage,
                                NSLocalizedFailureReasonErrorKey : errorMessage
                            ]
                            
                            customError = NSError(domain: "Domain has issues", code: statusCode, userInfo: userInfo) as Error
                        }
                    }
                    else if (json is [Any]) {
                        array = (json as? [Any])
                    }
                    else if (json is String) {
                        str = (json as? String)
                    }
                }
            }
        }
        
        completion?(apiSuccess, statusCode, json, dict, array, str, customError)
    }
    
    /// Serialize params.
    class func _serializeParams(_ params: Parameter?) -> String {
        
        var paramsString = ""
        if params != nil {
            paramsString = params!._queryStringFromHttpParameters()
            if !paramsString.isEmpty {
                paramsString = "?\(paramsString)"
            }
        }
        
        return paramsString
    }
    
    /// Encode POST parameters.
    class func _encodePostParameters(_ parameters: Parameter) -> Data {
        
        var results = [Any]()
        for (key, value) in parameters {
            var string: String?
            if (value is Data) {
                string = String(data: value as! Data, encoding: String.Encoding.utf8)
            }
            else if (value is String) {
                string = value as? String
            }
            else {
                // if you want to handle other data types, add that here
                string = (value as AnyObject).description
            }
            
            if string != nil {
                results.append("\(key)=\(Common._escape(string!))")
            }
        }
        
        let postString = (results as NSArray).componentsJoined(by: "&")
        return postString.data(using: String.Encoding.utf8)!
       
    }
    
    /// Form encode.
    class func _formEncode(_ parameters: Parameter) -> Data {
        var result = [String: String]()
        for (key, value) in parameters {
            var string: String?
            if (value is Data) {
                string = String(data: value as! Data, encoding: String.Encoding.utf8)
            }
            else if (value is String) {
                string = value as? String
            }
            else {
                // if you want to handle other data types, add that here
                string = (value as AnyObject).description
            }
            
            if string != nil {
                result[key] = Common._escape(string!)
            }
        }
        
        let postString = "data=\(result._formatJSON()!)"
        return postString.data(using: String.Encoding.utf8)!
    }
    
    /// Mime type.
    class func _mimeType(_ data: Data) -> String {
        
        let mData = NSData(data: data)
        
        var number: UInt8 = 0
        mData.getBytes(&number, length: MemoryLayout<UInt8>.size)
        switch number {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x42:
            return "image/bmp"
        case 0x47:
            return "image/gif"
        case 0x49, 0x4D:
            return "image/tiff"
        case 0x25:
            return "application/pdf"
        case 0xD0:
            return "application/vnd"
        case 0x46:
            return "text/plain"
        default:
            return "application/octet-stream"
        }
    }
    
    /// Mime type.
    class func _imageExtension(_ data: Data) -> String {
        
        let mData = NSData(data: data)
        
        var number: UInt8 = 0
        mData.getBytes(&number, length: MemoryLayout<UInt8>.size)
        switch number {
        case 0xFF:
            return "jpg"
        case 0x89:
            return "png"
        case 0x42:
            return "bmp"
        case 0x47:
            return "gif"
        case 0x49, 0x4D:
            return "tiff"
        default:
            return ""
        }
    }
    
    // MARK: - AlamofireNetworkActivityIndicator
    
    /**
     Controls the visibility of the network activity indicator on iOS using Alamofire.
     
     The NetworkActivityIndicatorManager manages the state of the network activity indicator. To begin using it, all that is required is to enable the shared instance in application:didFinishLaunchingWithOptions: in your AppDelegate.
     */
    public class func setupNetworkActivityIndicator() {
        
        NetworkActivityIndicatorManager.shared.isEnabled = true
        
        //The default value is 1.0 second
        NetworkActivityIndicatorManager.shared.startDelay = 1.0
        
        //The default value is 0.2 seconds
        NetworkActivityIndicatorManager.shared.completionDelay = 0.2
    }
    
    
    
    // MARK: - CONNECTIONS
    
    ///Returns YES if connection to internet is available
    public class func _connectionAvailable() -> Bool {
        
        if let reachability = Reachability() {
            return reachability.isReachable
        }
        
        return false
    }
    
    ///Fires UI alert if no connection internet is available
    public class func _noConnection() -> Bool {
        if self._connectionAvailable() == false {
            
                DLog("No Internet Connection")
            return true
        }
        return false
    }

}


