
# T-AlamofireCustom is Network Manager
[![Build Status](https://img.shields.io/travis/thienpham234/T-AlamofireCustom.svg)](https://travis-ci.org/thienpham234/T-AlamofireCustom)

T-AlamofireCustom is networking library written in Swift and Is inherited from lib Alamofire , and some lib.

## Requirements

- iOS 8.0+ / macOS 10.10+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 8.1+
- Swift 3.0+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build T-AlamofireCustom 0.3.0

To integrate T-AlamofireCustom into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/thienpham234/T-AlamofireCustomPodSpecs'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
   pod ’T-AlamofireCustom', '~> 0.3.0’
end
```

Then, run the following command:

```bash
$ pod install
```

## Usage

### Making a Request

Using simple

```swift
import T_AlamofireCustom  

ServerManager._makeGETrequest(baseURL: "https://example.com", 
                             endpoint: "/get/lits",
                               params: nil) { (success, status,response, dict, array, string, error) in
            // Handle API
 }
        
```
### Response Handling

Handling the `Response` of a `Request` made in Alamofire involves chaining a response handler onto the `Request`.

```swift
ServerManager._makeGETrequest(baseURL: "https://example.com", 
                             endpoint: "/get/lits",
                               params: nil) { (success, status,response, dict, array, string, error) in
            // Handle API
             print(success)  // success == true => Response Success
             print(status)   // Reponse status code of a request. (Notice: status == -1 ==> No Connect Internet)
             print(response) // Response Data JSON 
             print(dict)     // Parsed json to (Dictionary) (If response json is Dictionary)
             print(array)    // Parsed json to (Array) (If response json is Array)
             print(string)   // Parsed json to (String) (If response json is String)
             print(error)    // error: NSError 
 }

```
### HTTP Methods

```swift
public enum eHTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}
```

#### JSON Encoding
```swift
public enum eContentTypeHTTPHeader: Int {
    case JSON
    case FormURLEncoded
}
```
##### GET Request With URL-Encoded Parameters

```swift
let parameters: Parameter = ["foo": "bar"]

// All three of these calls are equivalent
ServerManager._makeGETrequest(baseURL: "https://httpbin.org", 
                             endpoint: "/get",
                               params: parameters) { (success, status,response, dict, array, string, error) in
            // Handle API
 }
OR  
  // showHub: default is True
  // showError: default is True
  ServerManager._makeGETrequest(baseURL:"https://httpbin.org" ,
                               endpoint: "/get", 
                                 params: "paramters", 
                              showError: false,
                                 showHud: true) { (success, status,response, dict, array, string, error) in
        //
        }


// https://httpbin.org/get?foo=bar
```
### GET Request with AccessToken or Username vs Password
```swift
// 
 ServerManager._makeGETrequest(baseURL: "",
                              endpoint: "",
                                params: nil,
                              username:"",
                              password: "",
                           accessToken: "",
                             showError: false,
                               showHud: false) { (success, status,response, dict, array, string, error) in
                                        //
        }
```
##### POST Request Simple with Body

```swift
let body: Parameter = [
    "foo": [1,2,3],
    "bar": [
        "baz": "qux"
    ]
]
ServerManager._makePOSTrequest(baseURL: "https://httpbin.org",
                              endpoint: "/post", 
                                params: nil, 
                                  body: body) { (success, status,response, dict, array, string, error) in
            //Handel response
 })
  
```

// HTTP body: {"foo": [1, 2, 3], "bar": {"baz": "qux"}}
##### POST Request With eContentTypeHTTPHeader ==  .FormURLEncoded  Parameters

```swift
let body: Parameter = [
    "foo": "bar",
    "baz": ["a", 1],
    "qux": [
        "x": 1,
        "y": 2,
        "z": 3
    ]
]
ServerManager._makePOSTrequest(baseURL: "https://httpbin.org",
                                       endpoint: "/post",
                                       params: nil,
                                       body: body,
                                       username:nil,
                                       password: nil,
                                       accessToken: nil,
                                       contentType: .FormURLEncoded,
                                       showError: false,
                                       showHud: false) { (success, status,response, dict, array, string, error) in
            //Handel response
 })



// HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
```
 
##### POST Request with eContentTypeHTTPHeader == .JSON Parameters

```swift
let parameters: Parameter = [
    "foo": [1,2,3],
    "bar": [
        "baz": "qux"
    ]
]
ServerManager._makePOSTrequest(baseURL: "https://httpbin.org",
                                       endpoint: "/post",
                                       params: nil,
                                       body: body,
                                       username:nil,
                                       password: nil,
                                       accessToken: nil,
                                       contentType: .JSON,
                                       showError: false,
                                       showHud: false) { (success, status,response, dict, array, string, error) in
            //Handel response
 })


// HTTP body: {"foo": [1, 2, 3], "bar": {"baz": "qux"}}
```
### Network Reachability
```swift
   if (ServerManager._noConnection() == true){
      // connection to internet is unavailable
   }else{
      //connection to internet is available
   }
```
#### App Transport Security

With the addition of App Transport Security (ATS) in iOS 9, it is possible that using a custom `ServerTrustPolicyManager` with several `ServerTrustPolicy` objects will have no effect. If you continuously see `CFNetwork SSLHandshake failed (-9806)` errors, you have probably run into this problem. Apple's ATS system overrides the entire challenge system unless you configure the ATS settings in your app's plist to disable enough of it to allow your app to evaluate the server trust.

If you run into this problem (high probability with self-signed certificates), you can work around this issue by adding the following to your `Info.plist`.

```xml
<dict>
	<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSExceptionDomains</key>
		<dict>
			<key>example.com</key>
			<dict>
				<key>NSExceptionAllowsInsecureHTTPLoads</key>
				<true/>
				<key>NSExceptionRequiresForwardSecrecy</key>
				<false/>
				<key>NSIncludesSubdomains</key>
				<true/>
				<!-- Optional: Specify minimum TLS version -->
				<key>NSTemporaryExceptionMinimumTLSVersion</key>
				<string>TLSv1.2</string>
			</dict>
		</dict>
	</dict>
</dict>
```

Whether you need to set the `NSExceptionRequiresForwardSecrecy` to `NO` depends on whether your TLS connection is using an allowed cipher suite. In certain cases, it will need to be set to `NO`. The `NSExceptionAllowsInsecureHTTPLoads` MUST be set to `YES` in order to allow the `SessionDelegate` to receive challenge callbacks. Once the challenge callbacks are being called, the `ServerTrustPolicyManager` will take over the server trust evaluation. You may also need to specify the `NSTemporaryExceptionMinimumTLSVersion` if you're trying to connect to a host that only supports TLS versions less than `1.2`.

> It is recommended to always use valid certificates in production environments.

## License

T-AlamofireCustom is released under the MIT license. [See LICENSE](https://github.com/thienpham234/T-AlamofireCustom/blob/master/LICENSE) for details.
 
