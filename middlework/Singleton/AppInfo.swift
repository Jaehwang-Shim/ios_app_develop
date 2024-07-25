//
//  AppInfo.swift
//  Spatial_touch_demo2_for_ios
//
//  Created by Jaehwang on 7/23/24.
//

import Foundation

class AppInfo {
    static let shared = AppInfo()
    private init() {}
 
    var mainInfo: [String : Any]? {
        guard let info = Bundle.main.infoDictionary else {
            return nil
        }
        return info
    }
 
    var name: String? {
        self.mainInfo?["CFBundleName"] as? String
    }
 
    var scheme: String? {
        guard let urlTypes = self.mainInfo?["CFBundleURLTypes"] as? [AnyObject],
            let urlTypeDictionary = urlTypes.first as? [String: AnyObject],
            let urlSchemes = urlTypeDictionary["CFBundleURLSchemes"] as? [AnyObject],
            let scheme = urlSchemes.first as? String else { return nil }
        return scheme
    }
 
    var version: String? {
        self.mainInfo?["CFBundleShortVersionString"] as? String
    }
    
    var url: String = "https://naver.com"
    
    //웹 뷰 서버 정보
    var serverMode = Constants.SERVER_Youtube
    var serverName = Constants.SERVERS[Constants.SERVER_Youtube]!["NAME"]!
    var serverURL: String = "https://youtube.com"
}
