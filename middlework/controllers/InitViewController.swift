//
//  InitViewController.swift
//  Spatial_touch_demo2_for_ios
//
//  Created by Jaehwang on 7/23/24.
//

import Foundation
import UIKit

class InitViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        title = "InitViewController"
        print("init view controller is install")
        
        let appInfo = AppInfo.shared
        print("appInfo.url: \(appInfo.url)")
        
        appInfo.url = "http://localhost"
        print("appInfo.url: \(appInfo.url)")
        
        if let appName = appInfo.name, let appScheme = appInfo.scheme, let appVersion = appInfo.version {
            print("appName: \(appName)")
            print("appScheme: \(appScheme)")
            print("appVersion: \(appVersion)")
        }
        // Do any additional setup after loading the view.
        
        Utils.Log("Utils.isDebug : \(Utils.isDebug())")
        Utils.Log("Server : \(Constants.SERVER_Youtube)")
        Utils.Log("URL : \(Constants.SERVERS[Constants.SERVER_Youtube]!["URL"]!)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         
         // 메인 컨트롤러로 이동
         let callback = { self.gotoMain() }
         
         if (Utils.isDebug() == true) {
             self.openServerSelectAlert(callback: callback)
         } else {
             DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                 // 딜레이 1초 이후 콜백 함수 호출
                 callback()
             }
         }
     }
     
     private func openServerSelectAlert(callback: @escaping() -> Void) {
         let alerts = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
         
         alerts.addAction(getAlertAction(serverMode: Constants.SERVER_Youtube, callback: { callback() }))
         alerts.addAction(getAlertAction(serverMode: Constants.SERVER_Shorts, callback: { callback() }))
         alerts.addAction(getAlertAction(serverMode: Constants.SERVER_Instagram, callback: { callback() }))
         alerts.addAction(getAlertAction(serverMode: Constants.SERVER_Reels, callback: { callback() }))
         alerts.addAction(getAlertAction(serverMode: Constants.SERVER_Tiktok, callback: { callback() }))
         alerts.addAction(getAlertAction(serverMode: Constants.SERVER_Tiktok_Lite, callback: { callback() }))
         alerts.addAction(getAlertAction(serverMode: Constants.SERVER_Netflix, callback: { callback() }))
         alerts.addAction(getAlertAction(serverMode: Constants.SERVER_Disney_Plus, callback: { callback() }))
         alerts.addAction(getAlertAction(serverMode: Constants.SERVER_Prime_Video, callback: { callback() }))
         alerts.addAction(getAlertAction(serverMode: Constants.SERVER_Tidal, callback: { callback() }))
         alerts.addAction(getAlertAction(serverMode: Constants.SERVER_Spotify, callback: { callback() }))
         alerts.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: { _ in callback() }))
         self.present(alerts, animated: true)
     }
     
     private func getAlertAction(serverMode: String, callback: (() -> Void)? = nil) -> UIAlertAction {
         let title = Constants.SERVERS[serverMode]!["NAME"]!
         
         return UIAlertAction(title: title, style: .default, handler: { _ in
             // 서버 정보 설정
             self.setAppInfo(serverMode: serverMode)
             
             // 콜백
             callback?()
         })
     }
     
     private func setAppInfo(serverMode: String) -> Void {
         let appInfo = AppInfo.shared
         
         appInfo.serverMode = serverMode
         appInfo.serverName = Constants.SERVERS[serverMode]!["NAME"]!
         appInfo.serverURL = Constants.SERVERS[serverMode]!["URL"]!
     }
     
     private func gotoMain() {
         let appInfo = AppInfo.shared
         Utils.Log("appInfo.serverURL : \(appInfo.serverURL)")
         
         let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "mainVC")
         mainVC?.modalPresentationStyle = .fullScreen // 전체화면으로 보이게 설정
         mainVC?.modalTransitionStyle = .crossDissolve // 전환 애니메이션 설정

         self.present(mainVC!, animated: true, completion: nil)
         
     }
 }

