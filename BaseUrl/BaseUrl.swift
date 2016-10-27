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
    
    required public init(delegate: BaseUrlDelegate) {
        self.delegate = delegate
    }
    
    public var url: String { get { return urlProtocol() + domain() } }
    
    public func urlProtocol() -> String {
        #if DEBUG || STAGING
            if let value = UserDefaults.standard.value(forKey: BaseUrlKeys.urlProtocol) as? String {
                return value
            }
        #endif
        
        return delegate.defaultProtocol()
    }
    
    public func domain() -> String {
        #if DEBUG || STAGING
            if let value = UserDefaults.standard.value(forKey: BaseUrlKeys.domain) as? String {
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
            domain: UserDefaults.standard.string(forKey: BaseUrlKeys.previousDomain),
            urlProtocol: UserDefaults.standard.string(forKey: BaseUrlKeys.previousUrlProtocol)
        )
    }
    
    private func set(value: String?, forKey key: String) {
        if value?.isEmpty ?? true {
            UserDefaults.standard.removeObject(forKey: key)
        } else {
            UserDefaults.standard.setValue(value, forKey: key)
        }
    }
    
    internal func reset() {
        UserDefaults.standard.removeObject(forKey: BaseUrlKeys.domain)
        UserDefaults.standard.removeObject(forKey: BaseUrlKeys.urlProtocol)
        UserDefaults.standard.removeObject(forKey: BaseUrlKeys.previousDomain)
        UserDefaults.standard.removeObject(forKey: BaseUrlKeys.previousUrlProtocol)
    }
    #endif
}
