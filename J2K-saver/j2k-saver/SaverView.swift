//
//  SaverView.swift
//  j2k-saver
//
//  Created by Dawninest on 2019/4/8.
//  Copyright © 2019 dawninest. All rights reserved.
//

import Foundation
import ScreenSaver

let SCREEN_W = NSScreen.main?.frame.size.width
let SCREEN_H = NSScreen.main?.frame.size.height

final class SaverView: ScreenSaverView {
    
    let jikeY = NSColor(red:1, green:0.894, blue:0.066, alpha:1.00) // FFE411
    
    let canDoText = NSTextField()
    let daliyText = NSTextField()
    let dateNumText = NSTextField()
    let sdfText = NSTextField()
    
    override init!(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        
       
        
    }
    
    func initUI () {
        
        canDoText.frame = NSRect.init(x: 0, y: SCREEN_H! - 280, width: SCREEN_W!, height: 80)
        canDoText.isEditable = false
        canDoText.isBordered = false
        canDoText.drawsBackground = false
        canDoText.font = NSFont.systemFont(ofSize: 60)
        canDoText.textColor = jikeY
        canDoText.alignment = .center
        self.addSubview(canDoText)
        
        daliyText.frame = NSRect.init(x: 0, y: SCREEN_H! - 340, width: SCREEN_W!, height: 50)
        daliyText.isEditable = false
        daliyText.isBordered = false
        daliyText.drawsBackground = false
        daliyText.font = NSFont.systemFont(ofSize: 30)
        daliyText.textColor = jikeY
        daliyText.alignment = .center
        self.addSubview(daliyText)
        
        dateNumText.frame = NSRect.init(x: (SCREEN_W! - 770) / 2 + 10, y: SCREEN_H! - 520, width: 770, height: 200)
        dateNumText.isEditable = false
        dateNumText.isBordered = false
        dateNumText.drawsBackground = false
        dateNumText.font = NSFont.systemFont(ofSize: 180)
        dateNumText.textColor = jikeY
        dateNumText.alignment = .left
        self.addSubview(dateNumText)
        
        let lineOne = NSView.init(frame: NSRect.init(x: 300, y: SCREEN_H! - 550, width: SCREEN_W! - 600, height: 4))
        lineOne.wantsLayer = true
        lineOne.layer?.setNeedsDisplay()
        lineOne.layer?.backgroundColor = jikeY.cgColor
        self.addSubview(lineOne)
        
        let lineTwo = NSView.init(frame: NSRect.init(x: 300, y: SCREEN_H! - 555, width: SCREEN_W! - 600, height: 1))
        lineTwo.wantsLayer = true
        lineTwo.layer?.setNeedsDisplay()
        lineTwo.layer?.backgroundColor = jikeY.cgColor
        self.addSubview(lineTwo)
        
        sdfText.frame = NSRect.init(x: 300, y: SCREEN_H! - 800, width: SCREEN_W! - 600, height: 200)
        sdfText.isEditable = false
        sdfText.isBordered = false
        sdfText.drawsBackground = false
        sdfText.font = NSFont.systemFont(ofSize: 40)
        sdfText.textColor = jikeY
        sdfText.alignment = .center
        self.addSubview(sdfText)
        
        
    }
    
    
    func initData () {
        let refreshToken = self.readRefreshToken()
        self.sdfText.stringValue = "..."
        self.getDataJWT(refreshToken, success: {(jwt) in
            self.sdfText.stringValue = jwt
            self.getDailyData(jwt, success: {(data) in
                self.updateData(data)
            })
        })
    }
    
    func getDataJWT (_ refreshToken: String, success: @escaping (String) -> Void) {
        let refreshUrl = "https://app.jike.ruguoapp.com/1.0/app_auth_tokens.refresh" // POST
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
                return
            }
        }
        task.resume()
    }
    
    func getDailyData (_ jwt: String ,success: @escaping (Dictionary<String, Any>) -> Void) {
        let dailyDataUrl = "https://app.jike.ruguoapp.com/1.0/dailyCards/list"
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
                return
            }
        }
        task.resume()
    }
    
    func readRefreshToken () -> String {
        let file = "j2k.txt"
        var refreshToken = ""
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            
            //reading
            do {
                refreshToken = try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch {
                /* error handling here */
            }
        }
        return refreshToken
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func startAnimation() {
        super.startAnimation()
        
    }
    
    override func stopAnimation() {
        super.stopAnimation()
    }
    
    override func draw(_ rect: NSRect) {
        super.draw(rect)
        self.initUI()
        self.initData()
    }
    
    func updateData (_ data: Dictionary<String, Any>) {
        let cardData: Array<Any> = data["cards"] as! Array<Any>
        if cardData.count > 0 {
            let daily: Dictionary<String, Any> = cardData[0] as! Dictionary<String, Any>
            let fortune: String = daily["fortune"] as! String
            let featuredContent: Dictionary<String,Any> = daily["featuredContent"] as! Dictionary<String,Any>
            let recommedDes: String = featuredContent["text"] as! String
            DispatchQueue.main.sync {
                self.canDoText.stringValue = fortune
                self.sdfText.stringValue = recommedDes
            }
        }
    }
    
    override func animateOneFrame() {
        updateDate()
        return
    }
    
    func updateDate () {
        let weekArr = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"]
        
        let date = Date.init()
        let chinese = Calendar.init(identifier: .gregorian)
        let components = Set<Calendar.Component>([.year, .month,.weekday,.day, .hour, .minute, .second])
        let theComponents = chinese.dateComponents(components, from: date)
        
        let year = theComponents.year!.description
        let mouth = theComponents.month!.description
        let dayStr = theComponents.day!.description
        let day = theComponents.day! < 10 ? "0\(dayStr)" : dayStr
        let week = weekArr[theComponents.weekday! - 1]
        
        
       
        let hourStr = theComponents.hour!.description
        let hour = theComponents.hour! < 10 ? "0\(hourStr)" : hourStr
        
        let minStr = theComponents.minute!.description
        let min = theComponents.minute! < 10 ? "0\(minStr)" : minStr
        
        let secStr = theComponents.second!.description
        let sec = theComponents.second! < 10 ? "0\(secStr)" : secStr
        
        daliyText.stringValue = "\(year) 年 \(mouth) 月 \(day) 日  \(week)"
        dateNumText.stringValue = "\(hour):\(min):\(sec)"
    }
    
    override var hasConfigureSheet: Bool {
        return true
    }
    
    override var configureSheet: NSWindow? {
        return nil
    }
}
