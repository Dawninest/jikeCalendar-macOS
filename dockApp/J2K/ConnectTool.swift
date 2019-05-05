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
    let dailyDataUrl = "https://app.jike.ruguoapp.com/1.0/dailyCards/list" // GET
    
    func getDataJWT (_ refreshToken: String, success: @escaping (String) -> Void, fail: @escaping () -> Void) {
        let session = URLSession(configuration: .default)
        let url = NSURL(string: refreshUrl)
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.addValue(refreshToken, forHTTPHeaderField: "x-jike-refresh-token")
        let task = session.dataTask(with: request) {(data, response, error) in
            do {
                let JWTData = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                let jwt = JWTData["x-jike-access-token"] as! String
                success(jwt)
            } catch {
                print("无法连接到服务器")
                fail()
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
    
    func getQRUUID (success: @escaping (String) -> Void) {
        let urlStr = "https://app.jike.ruguoapp.com/sessions.create"
        let session = URLSession(configuration: .default)
        let url = NSURL(string: urlStr)
        let request = URLRequest(url: url! as URL)
        let task = session.dataTask(with: request) {(data, response, error) in
            do {
                let uuidData = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary as! Dictionary<String, Any>
                let uuid: String = uuidData["uuid"] as! String
                success(uuid)
            } catch {
                print("无法连接到服务器")
                return
            }
        }
        task.resume()
    }
    
    func waitingforLogin (uuid: String, success: @escaping () -> Void, fail: @escaping () -> Void) {
        // 未登录204, 登录200, 超时xx
        let urlStr = "https://app.jike.ruguoapp.com/sessions.wait_for_login?uuid=\(uuid)"
        let session = URLSession(configuration: .default)
        let url = NSURL(string: urlStr)
        let request = URLRequest(url: url! as URL)
        let task = session.dataTask(with: request) {(data, response, error) in
            do {
                let res = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary as! Dictionary<String, Any>
                let logged_in: Int = res["logged_in"] as! Int
                // logged_in == 1
                if (logged_in == 1) {
                    success()
                }
            } catch {
                let res: HTTPURLResponse = response as! HTTPURLResponse
                let code = res.statusCode
                if (code == 204) {
                    // 未登录,再次请求 waitingforLogin
                    self.waitingforLogin(uuid: uuid,success: success, fail: fail);
                } else {
                    fail()
                }
                return
            }
           
        }
        task.resume()
    }
    
    func waitingforConfirm (uuid: String, success: @escaping (String) -> Void, fail: @escaping () -> Void) {
        let urlStr = "https://app.jike.ruguoapp.com/sessions.wait_for_confirmation?uuid=\(uuid)"
        let session = URLSession(configuration: .default)
        let url = NSURL(string: urlStr)
        let request = URLRequest(url: url! as URL)
        let task = session.dataTask(with: request) {(data, response, error) in
            do {
                let userdata = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary as! Dictionary<String, Any>
                let refreshToken: String = userdata["x-jike-refresh-token"] as! String
                success(refreshToken)
            } catch {
                print("无法连接到服务器")
                let res: HTTPURLResponse = response as! HTTPURLResponse
                let code = res.statusCode
                if (code == 204) {
                    // 未登录,再次请求 waitingforLogin
                    self.waitingforConfirm(uuid: uuid,success: success, fail: fail);
                } else {
                    fail()
                }
                return
            }
        }
        task.resume()
    }
    
    
    
}
