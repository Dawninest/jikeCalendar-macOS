//
//  MainBackView.swift
//  J2K
//
//  Created by Dawninest on 2019/4/2.
//  Copyright © 2019 dawninest. All rights reserved.
//

import Cocoa

class MainBackView: NSView {
    
    let width: CGFloat = 375 * 0.75
    let height: CGFloat = 620 * 0.75
    let calenderHeight: CGFloat = 620 * 0.75 * 0.9
    let topStart: CGFloat = 620 * 0.75 * 0.1
    let jike_Y = NSColor(red:0.98, green:0.89, blue:0.31, alpha:1.00) // FFE411
    let font_color = NSColor(red:0.25, green:0.25, blue:0.25, alpha:1.00)
    
    var friTip = NSTextField() // 显示今天是否是周五
    var dateLineOne = NSTextField() // 显示 2019 四月 星期X
    var dateLineTwo = NSTextField() // 显示 号数 的大字
    var fortuneLine = NSTextField() // 显示 宜xx 的大字
    var QRImageView = NSImageView() // 显示扫码登录二维码的图片
    
    var recommedView = RecommedCell() // 沙雕网友的日常推荐
    
    var userName = NSTextField()
    var userLv = NSTextField()
    
    var titleLabel = NSTextField()
    
    let connect = ConnectTool()
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        self.initListUI()
        self.initDate()
        
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // 发现在主屏上每次都会打印 draw,然而在外接屏上不会每次打印
        // 每次点击dock图标会调用此方法,但是如果每次都去请求数据,可以有,但是没必要
        self.initDate()
    }
    
    func initDate(){
        let mouthArr = ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]
        let weekArr = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"]
        let friStr = ["今天不是周五","今天是周五"]
        let date = Date.init()
        let chinese = Calendar.init(identifier: .gregorian)
        let components = Set<Calendar.Component>([.year, .month, .day, .weekday])
        let theComponents = chinese.dateComponents(components, from: date)
        let year = theComponents.year!.description
        let mouth = mouthArr[theComponents.month! - 1]
        let dayStr = theComponents.day!.description
        let day = theComponents.day! < 10 ? "0\(dayStr)" : dayStr
        let week = weekArr[theComponents.weekday! - 1]
        let lineOneStr = "\(year) \(mouth) \(week)"
        let lineTwoStr = day
        var needUpdate = true
        let isFriday: Int = theComponents.weekday == 6 ? 1 : 0
         // 每次在此检查,是否是其他日期了,如果日期变了(数据变了),才去更新
        if (lineOneStr == self.dateLineOne.stringValue && lineTwoStr == self.dateLineTwo.stringValue) {
            needUpdate = false
        }
        if (needUpdate) {
            self.dateLineOne.stringValue = "\(year) \(mouth) \(week)"
            self.dateLineTwo.stringValue = day
            self.friTip.stringValue = friStr[isFriday]
            let refreshToken = self.readRefreshToken()
            if (refreshToken == "") {
                self.startLogin()
            } else {
                self.getCalendarData(refreshToken)
            }
        }
    }
    
    func saveRefreshToken (_ refreshToken: String) {
        let file = "j2k.txt"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            //writing
            do {
                try refreshToken.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {
                /* error handling here */
            }
        
        }
        
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
        print(refreshToken)
        return refreshToken
    }
    
    func getCalendarData(_ refreshToken: String) {
        // 从本地存储中拿到wjt
        // 如果本地存储能拿到,则去拿数据
        // 如果本地存储中拿不到,或者取数据报错,则显示扫码
        self.connect.getDataJWT(refreshToken, success: { (jwt) in
            self.connect.getDailyData(jwt: jwt, success: { (data) in
                self.updateData(data)
            })
        }) {
            self.startLogin()
        }
        
    }
    
    func startLogin() {
        self.connect.getQRUUID { (uuid) in
            let QRUrl = "https://ruguoapp.com/account/scan?uuid=\(uuid)&displayHeader=false&displayFooter=false"
            self.generateOriginQRImage(QRUrl)
            self.connect.waitingforLogin(uuid: uuid, success: { () in
                self.connect.waitingforConfirm(uuid: uuid, success: { (refreshToken) in
                    self.saveRefreshToken(refreshToken)
                    self.getCalendarData(refreshToken)
                    DispatchQueue.main.sync {
                        self.QRImageView.removeFromSuperview();
                    }
                }, fail: {
                    self.startLogin()
                })
            }, fail: {
                self.startLogin()
            })
        }
    }
    
    //创建二维码图片
    private func generateOriginQRImage(_ message: String) {
        let messageData = message.data(using: .utf8)
        // 创建二维码滤镜
        let qrCIFilter = CIFilter(name: "CIQRCodeGenerator")
        guard qrCIFilter != nil else {
            fatalError("QRCIFilter is nil")
        }
        qrCIFilter!.setValue(messageData, forKey: "inputMessage")
        //L7% M15% Q25% H%30% 纠错级别. 默认值是M
        qrCIFilter!.setValue("H", forKey: "inputCorrectionLevel")
        let returnImage = qrCIFilter!.outputImage
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(returnImage!, from: returnImage!.extent) {
            DispatchQueue.main.sync {
                self.QRImageView.image = NSImage.init(cgImage: cgImage, size: NSSize(width: 110, height: 110))
                self.recommedView.recommedDes.stringValue = "打开即刻App扫描二维码登录以获得日历全部数据"
            }
        }
    }

    
    func updateData(_ data: Dictionary<String, Any>) {
        let cardData: Array<Any> = data["cards"] as! Array<Any>
        let daily: Dictionary<String, Any> = cardData[0] as! Dictionary<String, Any>
        let fortune: String = daily["fortune"] as! String
        let featuredContent: Dictionary<String,Any> = daily["featuredContent"] as! Dictionary<String,Any>
        let recommedDes: String = featuredContent["text"] as! String
        let recommedName: String = featuredContent["author"] as! String
        let url: String = featuredContent["url"] as! String
        let greetings: Dictionary<String,Any> = daily["greetings"] as! Dictionary<String,Any>
        let userName: String = self.getUserName(greetings["firstLine"] as! String)
        let userLv: String = greetings["secondLine"] as! String
        DispatchQueue.main.sync {
            self.fortuneLine.stringValue = fortune
            self.recommedView.recommedDes.stringValue = recommedDes
            self.recommedView.recommedName.stringValue = "via \(recommedName)"
            self.recommedView.url = url
            self.userName.stringValue = userName
            self.userLv.stringValue = userLv
        }
        
    }
    
    func getUserName(_ str: String) -> String {
        let userName = str.components(separatedBy: "，")[0]
        return "您好，\(userName)"
    }
    
    func initListUI() {
        self.frame = NSRect.init(x: 0, y: 0, width: width, height: height)
        self.initCalendarUI()
        self.initBottomTool()
    }
    
    func initCalendarUI() {
        let calendarView = NSView.init(frame: NSRect.init(x: 0, y: topStart, width: width, height: calenderHeight))
        calendarView.wantsLayer = true
        calendarView.layer?.setNeedsDisplay()
        calendarView.layer?.backgroundColor = jike_Y.cgColor
        
        friTip.frame = NSRect.init(x: 0, y: (calenderHeight - topStart - 15), width: width, height: 40)
        friTip.isEditable = false
        friTip.isBordered = false
        friTip.backgroundColor = jike_Y
        friTip.maximumNumberOfLines = 1
        friTip.alignment = .center
        friTip.font = NSFont.boldSystemFont(ofSize: 30)
        friTip.textColor = font_color
        
        dateLineOne.frame = NSRect.init(x: 0, y: (calenderHeight - topStart - 40), width: width, height: 20)
        dateLineOne.isEditable = false
        dateLineOne.isBordered = false
        dateLineOne.backgroundColor = jike_Y
        dateLineOne.maximumNumberOfLines = 1
        dateLineOne.alignment = .center
        dateLineOne.font = NSFont.boldSystemFont(ofSize: 14)
        dateLineOne.textColor = font_color
        
        dateLineTwo.frame = NSRect.init(x: 0, y: (calenderHeight - topStart - 130), width: width, height: 100)
        dateLineTwo.isEditable = false
        dateLineTwo.isBordered = false
        dateLineTwo.backgroundColor = jike_Y
        dateLineTwo.maximumNumberOfLines = 1
        dateLineTwo.alignment = .center
        dateLineTwo.font = NSFont.boldSystemFont(ofSize: 85)
        dateLineTwo.textColor = font_color
        
        fortuneLine.frame = NSRect.init(x: 30, y: (calenderHeight - topStart - 250), width: width - 60, height: 115)
        fortuneLine.isEditable = false
        fortuneLine.isBordered = false
        fortuneLine.backgroundColor = jike_Y
        fortuneLine.alignment = .center
        fortuneLine.font = NSFont.systemFont(ofSize: 25)
        fortuneLine.textColor = font_color
        
        // QR
        QRImageView.frame = NSRect.init(x: (width - 110)/2, y: (calenderHeight - topStart - 240), width: 110, height: 110)
//        QRImageView.wantsLayer = true
//        QRImageView.layer?.setNeedsDisplay()
//        QRImageView.layer?.backgroundColor = font_color.cgColor
        
        
        let lineOne = NSView.init(frame: NSRect.init(x: 20, y: 120, width: width - 40, height: 4))
        lineOne.wantsLayer = true
        lineOne.layer?.setNeedsDisplay()
        lineOne.layer?.backgroundColor = font_color.cgColor
        
        let lineTwo = NSView.init(frame: NSRect.init(x: 20, y: 117, width: width - 40, height: 1))
        lineTwo.wantsLayer = true
        lineTwo.layer?.setNeedsDisplay()
        lineTwo.layer?.backgroundColor = font_color.cgColor
        
        recommedView.frame = NSRect.init(x: 0, y: 20, width: width, height: 90)
        recommedView.wantsLayer = true
        recommedView.layer?.setNeedsDisplay()
        recommedView.layer?.backgroundColor = jike_Y.cgColor
        recommedView.tapFunc { (url) in
            NSWorkspace.shared.open(NSURL.init(string: url)! as URL);
        }
        
        
        
        calendarView.addSubview(dateLineTwo)
        calendarView.addSubview(friTip)
        calendarView.addSubview(fortuneLine)
        calendarView.addSubview(QRImageView)
        calendarView.addSubview(dateLineOne)
        calendarView.addSubview(lineOne)
        calendarView.addSubview(lineTwo)
        calendarView.addSubview(recommedView)
        
        self.addSubview(calendarView)
    }
    
    func initBottomTool() {
        let bottomBar = NSView.init(frame: NSRect.init(x: 0, y: 0, width: width, height: topStart))
        
        let jikeBtn = NSButton.init(frame: NSRect.init(x: 15, y: 10, width: 25, height: 25))
        jikeBtn.image = NSImage.init(named: "jike")
        jikeBtn.imageScaling = .scaleProportionallyUpOrDown
        jikeBtn.isBordered = false
        jikeBtn.target = self
        jikeBtn.action = #selector(self.jumpToJike)
        bottomBar.addSubview(jikeBtn)
        
        
        
        userName.frame = NSRect.init(x: 45, y: 15, width: width - 90, height: 20)
        userName.isEditable = false
        userName.isBordered = false
        userName.alignment = .center
        userName.backgroundColor = NSColor.clear
        userName.font = NSFont.systemFont(ofSize: 10)
        userName.textColor = font_color
        bottomBar.addSubview(userName)
        
        userLv.frame = NSRect.init(x: 45, y: 0, width: width - 90, height: 20)
        userLv.isEditable = false
        userLv.isBordered = false
        userLv.alignment = .center
        userLv.backgroundColor = NSColor.clear
        userLv.font = NSFont.systemFont(ofSize: 10)
        userLv.textColor = font_color
        bottomBar.addSubview(userLv)
        
        let statusMode = UserDefaults.standard.string(forKey: "AppleInterfaceStyle")
        if (statusMode == "Dark") {
            userName.textColor = NSColor.white
            userLv.textColor = NSColor.white
        }
        
        let exitBtn = NSButton.init(frame: NSRect.init(x: 245, y: 10, width: 25, height: 25))
        exitBtn.image = NSImage.init(named: "exit")
        exitBtn.imageScaling = .scaleProportionallyUpOrDown
        exitBtn.isBordered = false
        exitBtn.target = self
        exitBtn.action = #selector(self.exitApp)
        bottomBar.addSubview(exitBtn)
        
        self.addSubview(bottomBar)
    }

    
    @objc func exitApp () {
        // 退出
        NSApplication.shared.terminate(self)
    }
    
    @objc func jumpToJike () {
        NSWorkspace.shared.open(NSURL.init(string: "https://web.okjike.com")! as URL);
    }
    
}
