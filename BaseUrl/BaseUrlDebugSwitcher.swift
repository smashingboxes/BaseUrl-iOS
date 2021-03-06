//
//  BaseUrlDebugSwitcher.swift
//  grooop
//
//  Created by David Sweetman on 10/27/16.
//  Copyright © 2016 smashing boxes. All rights reserved.
//

import UIKit

class BaseUrlDebugSwitcher: UIViewController
{
    @IBOutlet weak var protocolField: UITextField!
    @IBOutlet weak var domainField: UITextField!
    
    weak var baseUrl: BaseUrl?
    
    init(baseUrl: BaseUrl) {
        self.baseUrl = baseUrl
        let bundle = Bundle(for: BaseUrlDebugSwitcher.self)
        super.init(nibName: "BaseUrlDebugSwitcher", bundle: bundle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        protocolField.text = baseUrl?.urlProtocol()
        domainField.text = baseUrl?.domain()
    }
    
    @IBAction func usePreviousButtonPressed(sender: AnyObject?) {
        #if DEBUG || STAGING
            let previous = baseUrl?.retreivePrevious()
            protocolField.text = previous?.urlProtocol
            domainField.text = previous?.domain
        #endif
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject?) {
        #if DEBUG || STAGING
            dismiss(animated: true, completion: nil)
            baseUrl?.setDebug(domain: domainField.text, urlProtocol: protocolField.text)
        #endif
    }
}
