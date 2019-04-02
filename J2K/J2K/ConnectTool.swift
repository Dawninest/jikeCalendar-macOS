//
//  ConnectTool.swift
//  J2K
//
//  Created by Dawninest on 2019/4/2.
//  Copyright © 2019 dawninest. All rights reserved.
//

import Cocoa

class ConnectTool {
    
    let refreshUrl = "https://app.jike.ruguoapp.com/1.0/app_auth_tokens.refresh" // POST
    let refreshJWT = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjoiQnZZSmFwckg0QlQ1ZEJudWY0NUtWWU50cFB1WkFqKzVSMWtnb3pBNDVTTEhlXC9xdSt2QitvXC83SXh3cWI4STRvYXZqaStkcG5JZXF5WFFPZzdZZ1J3SHhGMDBPVTBPRytDbnRlTHl1OFJabkhLRk5qNG9QY3JXbUExRDlcL3gxa3NhdUVDa3dybjRhUTFQXC9nTmkyVnRZT0FzcEE2TUh3K2NFZHVHczdLYllVVT0iLCJ2IjozLCJpdiI6ImVHcjlBTEFJdTZrak1LK3krUzVMXC9nPT0iLCJpYXQiOjE1NTQxMDA2MTkuMzk2fQ.NedeubfCaKjlA4qPNfEMbY10WrmxUClfvrA10kzBk40"
    let dailyDataUrl = "https://app.jike.ruguoapp.com/1.0/dailyCards/list" // GET
    
    func getDataJWT (success: @escaping (String) -> Void) {
        let session = URLSession(configuration: .default)
        let url = NSURL(string: refreshUrl)
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.addValue(refreshJWT, forHTTPHeaderField: "x-jike-refresh-token")
        let task = session.dataTask(with: request) {(data, response, error) in
            do {
                let JWTData = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                let jwt = JWTData["x-jike-access-token"] as! String
                success(jwt)
            } catch {
                print("无法连接到服务器")
                return
            }
        }
        task.resume()
    }
    
    func getDailyData (jwt: String ,success: @escaping (Dictionary<String, Any>) -> Void) {
        let session = URLSession(configuration: .default)
        let url = NSURL(string: dailyDataUrl)
        var request = URLRequest(url: url! as URL)
        request.addValue(jwt, forHTTPHeaderField: "x-jike-access-token")
        let task = session.dataTask(with: request) {(data, response, error) in
            do {
                let dailyData = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary as! Dictionary<String, Any>
                let data: Dictionary<String, Any> = dailyData["data"] as! Dictionary<String, Any>
                success(data)
            } catch {
                print("无法连接到服务器")
                return
            }
        }
        task.resume()
        
    }
    
}
