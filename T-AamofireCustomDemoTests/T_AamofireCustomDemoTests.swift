//
//  T_AamofireCustomDemoTests.swift
//  T-AamofireCustomDemoTests
//
//  Created by ThienPham on 4/13/17.
//  Copyright © 2017 D.A.C Tech VN. All rights reserved.
//

import XCTest
import TAlamofireCustom

class T_AamofireCustomDemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testConnectInternet() {
        let isConnectAvailable = ServerManager._connectionAvailable()
        XCTAssertTrue(isConnectAvailable,"Is connect Unavailable")
    }
    func testGetApiResponseDict() {
        
        let baseUrl:String = "https://api.chucknorris.io"
        let endPoint:String = "/jokes/random"
        ServerManager._makeGETrequest(baseURL: baseUrl, endpoint: endPoint, params: nil, showError: false, showHud: false) { (success, status, response, dict, array, string, error) in
            if success {
                XCTAssertTrue(dict != nil)
            }
            
        }
    }
    func testGetApiResponseArray() {
        let baseUrl:String = "https://api.chucknorris.io"
        let endPoint:String = "/jokes/categories"
        ServerManager._makeGETrequest(baseURL: baseUrl, endpoint: endPoint, params: nil, showError: false, showHud: false) { (success, status, response, dict, array, string, error) in
            if success {
                
                XCTAssertTrue(array == nil)
            }
            
        }
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
