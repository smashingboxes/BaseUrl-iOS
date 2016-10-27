//
//  BaseUrlTests.swift
//  BaseUrlTests
//
//  Created by David Sweetman on 10/27/16.
//  Copyright © 2016 smashing boxes. All rights reserved.
//

import XCTest
@testable import BaseUrl

class BaseUrlTests: XCTestCase {
    
    class TestDelegate: BaseUrlDelegate {
        var latestUrl: String?
        
        func defaultDomain() -> String {
            return "domain.com"
        }
        
        func defaultProtocol() -> String {
            return "test://"
        }
        
        func baseUrlDidChange(newURL: String) {
            latestUrl = newURL
        }
    }
    
    let delegate = TestDelegate()
    lazy var baseUrl: BaseUrl = { BaseUrl(delegate: self.delegate) }()
    
    override func setUp() {
        super.setUp()
        baseUrl.reset()
    }
    
    func testInitialValues() {
        XCTAssertTrue(baseUrl.domain() == "domain.com")
        XCTAssertTrue(baseUrl.urlProtocol() == "test://")
        XCTAssertTrue(baseUrl.url == "test://domain.com")
    }
    
    func testProtocolChange() {
        baseUrl.setDebug(domain: nil, urlProtocol: "new://")
        XCTAssertTrue(baseUrl.urlProtocol() == "new://")
    }
    
    func testDomainChange() {
        baseUrl.setDebug(domain: "new.com", urlProtocol: nil)
        XCTAssertTrue(baseUrl.domain() == "new.com")
    }
    
    func testUrlChange() {
        baseUrl.setDebug(domain: "new.com", urlProtocol: "new://")
        XCTAssertTrue(baseUrl.url == "new://new.com")
    }
    
    func testPrevious() {
        baseUrl.setDebug(domain: "new.com", urlProtocol: "new://")
        let previous = baseUrl.retreivePrevious()
        XCTAssertTrue(previous.urlProtocol == "test://")
        XCTAssertTrue(previous.domain == "domain.com")
    }
}
