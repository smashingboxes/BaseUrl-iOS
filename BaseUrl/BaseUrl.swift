//
//  BaseUrl.swift
//

import UIKit

/**
 
 Usage:
 
 1. Implement BaseUrlDelegate in your app
 2. `let baseUrl = BaseUrl(delegate: delegate)`
 3. Use `baseUrl.url`
 4. To show the switcher UI, call baseUrl.showDebugSwitcher(on: viewController)
 
 */

let BaseUrlKeys = (
    urlProtocol: "com.BaseUrl.urlProtocol",
    domain: "com.BaseUrl.domain",
    previousUrlProtocol: "com.BaseUrl.previousUrlProtocol",
    previousDomain: "com.BaseUrl.previousDomain"
)

public class BaseUrl
{
    fileprivate weak var delegate: BaseUrlDelegate!
    fileprivate let defaults: UserDefaults
    
    required public init(delegate: BaseUrlDelegate, defaults: UserDefaults = UserDefaults.standard) {
        self.delegate = delegate
        self.defaults = defaults
    }
    
    public var url: String { get { return urlProtocol() + domain() } }
    
    public func urlProtocol() -> String {
        #if DEBUG || STAGING
            if let value = defaults.value(forKey: BaseUrlKeys.urlProtocol) as? String {
                return value
            }
        #endif
        
        return delegate.defaultProtocol()
    }
    
    public func domain() -> String {
        #if DEBUG || STAGING
            if let value = defaults.value(forKey: BaseUrlKeys.domain) as? String {
                return value
            }
        #endif
        
        return delegate.defaultDomain()
    }
    
    public func showDebugSwitcher(on viewController: UIViewController) {
        let switcher = BaseUrlDebugSwitcher(baseUrl: self)
        viewController.present(switcher, animated: true, completion: nil)
    }
    
    #if DEBUG || STAGING
    public func setDebug(domain: String?, urlProtocol: String?) {
        let needsRefresh = domain != self.domain() || urlProtocol != self.urlProtocol()
        storePrevious(domain: self.domain(), urlProtocol: self.urlProtocol())
        set(value: domain, forKey: BaseUrlKeys.domain)
        set(value: urlProtocol, forKey: BaseUrlKeys.urlProtocol)
        if needsRefresh {
            delegate.baseUrlDidChange(newURL: url)
        }
    }
    
    internal func storePrevious(domain: String?, urlProtocol: String?) {
        set(value: domain, forKey: BaseUrlKeys.previousDomain)
        set(value: urlProtocol, forKey: BaseUrlKeys.previousUrlProtocol)
    }
    
    internal func retreivePrevious() -> (domain: String?, urlProtocol: String?) {
        return (
            domain: defaults.string(forKey: BaseUrlKeys.previousDomain),
            urlProtocol: defaults.string(forKey: BaseUrlKeys.previousUrlProtocol)
        )
    }
    
    private func set(value: String?, forKey key: String) {
        if value?.isEmpty ?? true {
            defaults.removeObject(forKey: key)
        } else {
            defaults.setValue(value, forKey: key)
        }
    }
    
    internal func reset() {
        defaults.removeObject(forKey: BaseUrlKeys.domain)
        defaults.removeObject(forKey: BaseUrlKeys.urlProtocol)
        defaults.removeObject(forKey: BaseUrlKeys.previousDomain)
        defaults.removeObject(forKey: BaseUrlKeys.previousUrlProtocol)
    }
    #endif
}
