//
//  Common.swift
//  TCustomAlamofire
//
//  Created by ThienPham on 4/10/17.
//  Copyright © 2017 D.A.C Tech VN. All rights reserved.
//


import Foundation
import UIKit
import PKHUD
import AVFoundation
import SwiftyJSON
class Common {
    
    
    // MARK: - Network Activity Indicator
    
    class func _setNetworkActivityIndicatorVisible(_ visible: Bool) {
        
        struct NetworkActivityIndicator {
            static var numberOfCallsToSetVisible = 0
        }
        if visible {
            NetworkActivityIndicator.numberOfCallsToSetVisible += 1
        }
        else {
            NetworkActivityIndicator.numberOfCallsToSetVisible -= 1
        }
        // The assertion helps to find programmer errors in activity indicator management.
        // Since a negative NumberOfCallsToSetVisible is not a fatal error,
        // it should probably be removed from production code.
        assert(NetworkActivityIndicator.numberOfCallsToSetVisible >= 0, "Network Activity Indicator was asked to hide more often than shown")
        // Display the indicator as long as our static counter is > 0.
        UIApplication.shared.isNetworkActivityIndicatorVisible = (NetworkActivityIndicator.numberOfCallsToSetVisible > 0)
    }
    
    
    //MARK: - HUD
    public class func _isHUDVisible() -> Bool {
        return HUD.isVisible
    }
    
    public class func _showProgressHUD(dimsBackground: Bool = false) {
        self._showProgressHUD(dimsBackground: dimsBackground, text: "Please wait")
    }
    
    public class func _showProgressHUD(dimsBackground: Bool = false, text: String?) {
        
        DispatchQueue.main.async {
            HUD.dimsBackground = dimsBackground
            HUD.allowsInteraction = false
            
            if text != nil {
                HUD.show(.labeledProgress(title: nil, subtitle: text!))
            }
            else {
                HUD.show(.progress)
            }
        }
    }
    
    public class func _showTextHUD(dimsBackground: Bool = false, text: String) {
        
        DispatchQueue.main.async {
            HUD.dimsBackground = dimsBackground
            HUD.allowsInteraction = false
            
            HUD.show(.label(text))
        }
    }
    
    public class func _hideHUD(showComplete: Bool = false) {
        
        DispatchQueue.main.async {
            if showComplete {
                HUD.flash(.success, delay: 1.0)
            }
            else {
                HUD.hide()
            }
        }
    }
    
    
    //MARK: - URL
    
    /// Returns a percent-escaped string following RFC 3986 for a query string key or value.
    ///
    /// RFC 3986 states that the following characters are "reserved" characters.
    ///
    /// - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
    /// - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
    ///
    /// In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
    /// query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
    /// should be percent-escaped in the query string.
    ///
    /// - parameter string: The string to be percent-escaped.
    ///
    /// - returns: The percent-escaped string.
    public class func _escape(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        
        var escaped = ""
        
        //==========================================================================================================
        //
        //  Batching is required for escaping due to an internal bug in iOS 8.1 and 8.2. Encoding more than a few
        //  hundred Chinese characters causes various malloc error crashes. To avoid this issue until iOS 8 is no
        //  longer supported, batching MUST be used for encoding. This introduces roughly a 20% overhead. For more
        //  info, please refer to:
        //
        //      - https://github.com/Alamofire/Alamofire/issues/206
        //
        //==========================================================================================================
        
        if #available(iOS 8.3, *) {
            escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
        } else {
            let batchSize = 50
            var index = string.startIndex
            
            while index != string.endIndex {
                let startIndex = index
                let endIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) ?? string.endIndex
                let range = startIndex..<endIndex
                
                let substring = string.substring(with: range)
                
                escaped += substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? substring
                
                index = endIndex
            }
        }
        
        return escaped
    }
    
}


