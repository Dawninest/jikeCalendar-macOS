//
//  SaverView.swift
//  j2k-saver
//
//  Created by Dawninest on 2019/4/8.
//  Copyright © 2019 dawninest. All rights reserved.
//

import Foundation
import ScreenSaver

final class SaverView: ScreenSaverView {
    
    let jikeY = NSColor(red:1, green:0.894, blue:0.066, alpha:1.00) // FFE411
    
    let ratio: CGFloat = 0.618
    
    let canDoText = NSTextField()
    let daliyText = NSTextField()
    let sdfText = NSTextField()
    
    let dateNumText = NSView()
    let dateNum_h = NSTextField()
    let dateNum_m = NSTextField()
    let dateNum_s = NSTextField()
    
    let lineOne = NSView()
    let lineTwo = NSView()
    
    override init!(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        
       
        
    }
    
    func initUI (_ rect: NSRect) {
        
        if (rect.size.width < 300 && rect.size.height < 200) {
            // 此时为在设置中的预览窗口 296 * 184
            let width = rect.size.width
            let height = rect.size.height
            
            let tipTitle = NSTextField()
            tipTitle.frame = NSRect.init(x: width * 0.05, y: height * 0.618 + 10, width: width * 0.9, height: 30)
            tipTitle.isEditable = false
            tipTitle.isBordered = false
            tipTitle.drawsBackground = false
            tipTitle.font = NSFont.systemFont(ofSize: 20)
            tipTitle.textColor = jikeY
            tipTitle.alignment = .center
            tipTitle.stringValue = "即刻黄历saver版"
            self.addSubview(tipTitle)
            
            let tipLine = NSView.init(frame: NSRect.init(x: width * 0.05, y: height * 0.618, width: width * 0.9, height: 1))
            tipLine.wantsLayer = true
            tipLine.layer?.setNeedsDisplay()
            tipLine.layer?.backgroundColor = jikeY.cgColor
            self.addSubview(tipLine)
            
            let tipText = NSTextField()
            tipText.frame = NSRect.init(x: width * 0.05, y: 10, width: width * 0.9, height: height * 0.618 - 20)
            tipText.isEditable = false
            tipText.isBordered = false
            tipText.drawsBackground = false
            tipText.font = NSFont.systemFont(ofSize: 12)
            tipText.textColor = jikeY
            tipText.alignment = .left
            tipText.stringValue = "1.请在一起下载到的 j2k.app(dock工具) 中登录即刻账号以获得每日运势和即友金句\n2.请勿点击下面的 '屏幕保护程序选项...' 按钮"
            self.addSubview(tipText)
            
        } else {
            // 多屏幕下通过制定到当前window去取当前的窗口的尺寸
            let width: CGFloat = (self.window?.screen?.frame.size.width)!
            let height: CGFloat = (self.window?.screen?.frame.size.height)!
            
            let showWith = width * ratio
            let widthPadding = width * (1 - ratio) / 2
            let lineHeight = height * (1 - ratio)
            canDoText.frame = NSRect.init(x: widthPadding, y: lineHeight + 280, width: showWith, height: 80)
            canDoText.isEditable = false
            canDoText.isBordered = false
            canDoText.drawsBackground = false
            canDoText.font = NSFont.systemFont(ofSize: 60)
            canDoText.textColor = jikeY
            canDoText.alignment = .center
            self.addSubview(canDoText)
            
            daliyText.frame = NSRect.init(x: widthPadding, y: lineHeight + 220, width: showWith, height: 50)
            daliyText.isEditable = false
            daliyText.isBordered = false
            daliyText.drawsBackground = false
            daliyText.font = NSFont.systemFont(ofSize: 30)
            daliyText.textColor = jikeY
            daliyText.alignment = .center
            self.addSubview(daliyText)
            
            
            
            dateNumText.frame = NSRect.init(x: widthPadding, y: lineHeight + 30, width: showWith, height: 200)
            
            let leftPadding = ( showWith - 840 ) / 2
            
            dateNum_h.frame = NSRect.init(x: leftPadding, y: 0, width: 240, height: 200)
            dateNum_h.isEditable = false
            dateNum_h.isBordered = false
            dateNum_h.drawsBackground = false
            dateNum_h.font = NSFont.systemFont(ofSize: 180)
            dateNum_h.textColor = jikeY
            dateNum_h.alignment = .center
            dateNumText.addSubview(dateNum_h)
            
            let dateSignOne = NSTextField()
            dateSignOne.frame = NSRect.init(x: leftPadding + 240, y: 0, width: 60, height: 200)
            dateSignOne.isEditable = false
            dateSignOne.isBordered = false
            dateSignOne.drawsBackground = false
            dateSignOne.font = NSFont.systemFont(ofSize: 180)
            dateSignOne.textColor = jikeY
            dateSignOne.alignment = .center
            dateSignOne.stringValue = ":"
            dateNumText.addSubview(dateSignOne)
            
            dateNum_m.frame = NSRect.init(x: leftPadding + 300, y: 0, width: 240, height: 200)
            dateNum_m.isEditable = false
            dateNum_m.isBordered = false
            dateNum_m.drawsBackground = false
            dateNum_m.font = NSFont.systemFont(ofSize: 180)
            dateNum_m.textColor = jikeY
            dateNum_m.alignment = .center
            dateNumText.addSubview(dateNum_m)
            
            let dateSignTwo = NSTextField()
            dateSignTwo.frame = NSRect.init(x: leftPadding + 540, y: 0, width: 60, height: 200)
            dateSignTwo.isEditable = false
            dateSignTwo.isBordered = false
            dateSignTwo.drawsBackground = false
            dateSignTwo.font = NSFont.systemFont(ofSize: 180)
            dateSignTwo.textColor = jikeY
            dateSignTwo.alignment = .center
            dateSignTwo.stringValue = ":"
            dateNumText.addSubview(dateSignTwo)
            
            dateNum_s.frame = NSRect.init(x: leftPadding + 600, y: 0, width: 240, height: 200)
            dateNum_s.isEditable = false
            dateNum_s.isBordered = false
            dateNum_s.drawsBackground = false
            dateNum_s.font = NSFont.systemFont(ofSize: 180)
            dateNum_s.textColor = jikeY
            dateNum_s.alignment = .center
            dateNumText.addSubview(dateNum_s)
            
            self.addSubview(dateNumText)
            
            lineOne.frame = NSRect.init(x: widthPadding, y: lineHeight + 5, width: showWith, height: 4)
            lineOne.wantsLayer = true
            lineOne.layer?.setNeedsDisplay()
            lineOne.layer?.backgroundColor = jikeY.cgColor
            self.addSubview(lineOne)
            
            lineTwo.frame = NSRect.init(x: widthPadding, y: lineHeight, width: showWith, height: 1)
            lineTwo.wantsLayer = true
            lineTwo.layer?.setNeedsDisplay()
            lineTwo.layer?.backgroundColor = jikeY.cgColor
            self.addSubview(lineTwo)
            
            sdfText.frame = NSRect.init(x: widthPadding, y: lineHeight - 250, width: showWith, height: 200)
            sdfText.isEditable = false
            sdfText.isBordered = false
            sdfText.drawsBackground = false
            sdfText.font = NSFont.systemFont(ofSize: 40)
            sdfText.textColor = jikeY
            sdfText.alignment = .center
            self.addSubview(sdfText)
        }
        

        
        
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
        self.initUI(rect)
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
        dateNum_h.stringValue = "\(hour)"
        dateNum_m.stringValue = "\(min)"
        dateNum_s.stringValue = "\(sec)"
        
    }
    
    override var hasConfigureSheet: Bool {
        return true
    }
    
    override var configureSheet: NSWindow? {
        return nil
    }
}
