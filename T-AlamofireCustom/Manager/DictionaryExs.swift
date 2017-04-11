//
//  DictionaryExs.swift
//  TCustomAlamofire
//
//  Created by ThienPham on 4/10/17.
//  Copyright © 2017 D.A.C Tech VN. All rights reserved.
//
import Foundation

public extension Dictionary {
    
    /// Unserialize JSON string into Dictionary
    public static func _jsonFrom(jsonString: String) -> Dictionary? {
        
        if let data = (try? JSONSerialization.jsonObject(with: jsonString.data(using: String.Encoding.utf8, allowLossyConversion: true)!, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSDictionary {
            return data as? Dictionary
        } else {
            return nil
        }
    }
    
    /// Unserialize JSON data into Dictionary
    public static func _jsonFrom(jsonData: Data) -> Dictionary? {
        if let data = (try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSDictionary {
            return data as? Dictionary
        } else {
            return nil
        }
    }
    
    /// Serialize NSDictionary into JSON string
    public func _formatJSON(prettyPrinted: Bool = false) -> String? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: prettyPrinted ? .prettyPrinted : JSONSerialization.WritingOptions()) {
            let jsonStr = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
            return String(jsonStr ?? "")
        }
        return nil
    }
    
    public func _jsonData() -> Data? {
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options:JSONSerialization.WritingOptions())
        return jsonData
    }
    
    /// Build string representation of HTTP parameter dictionary of keys and objects
    ///
    /// This percent escapes in compliance with RFC 3986
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
    
    public func _queryStringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String)._addingPercentEncodingForURLQueryValue()!
            let percentEscapedValue: String = "\(value)"._addingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joined(separator: "&")
    }
    
}
