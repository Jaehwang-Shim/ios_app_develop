//
//  MainViewController.swift
//  Spatial_touch_demo2_for_ios
//
//  Created by Jaehwang on 7/23/24.
//

import Foundation
import UIKit
import WebKit

class MainViewController: BaseViewController {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var selectedWebView: UIView!
    
    var wkWebView: WKWebView?
    var cookiePool: WKProcessPool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "MainViewController"
        
        wkWebView = createWKWebView(selectedWebView!)
        
        let appInfo = AppInfo.shared
        let urlString = "\(appInfo.serverURL)"
        
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            Utils.Log("urlString : \(url)")
            
            wkWebView?.load(urlRequest)
            
        }
        
    }
    
    func createWKWebView(_ view: UIView) -> WKWebView {
            cookiePool = WKProcessPool()
            
            let jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'); document.getElementsByTagName('head')[0].appendChild(meta);"
            let preferences = WKPreferences()
            
            preferences.javaScriptCanOpenWindowsAutomatically = true
            preferences.javaScriptEnabled = true

            let wkUScript = WKUserScript(source: jScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
            let wkUController = WKUserContentController()
            wkUController.addUserScript(wkUScript)
            
            let wkWebConfig = WKWebViewConfiguration()

            wkWebConfig.allowsInlineMediaPlayback = true
            wkWebConfig.mediaTypesRequiringUserActionForPlayback = []
            wkWebConfig.userContentController = wkUController
            wkWebConfig.processPool = cookiePool!
            wkWebConfig.preferences = preferences
            wkWebConfig.ignoresViewportScaleLimits = true

            let webViewWK = WKWebView(frame: .zero, configuration: wkWebConfig)
            view.addSubview(webViewWK)
            webViewWK.translatesAutoresizingMaskIntoConstraints = false
            webViewWK.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            webViewWK.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            webViewWK.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            webViewWK.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
            webViewWK.allowsLinkPreview = true

            return webViewWK;
        }
    
}
