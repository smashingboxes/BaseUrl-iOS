//
//  BaseUrlDelegate.swift
//  grooop
//
//  Created by David Sweetman on 10/27/16.
//  Copyright © 2016 smashing boxes. All rights reserved.
//

import Foundation

public protocol BaseUrlDelegate: class {
    func defaultDomain() -> String
    func defaultProtocol() -> String
    func baseUrlDidChange(newURL: String)
}
