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
    
    var dateLineOne = NSTextField() // 显示 2019 四月 星期X
    var dateLineTwo = NSTextField() // 显示 号数 的大字
    var fortuneLine = NSTextField() // 显示 宜xx 的大字
//    var recommedDes = NSTextField() // 显示 沙雕网友的评论
//    var recommedName = NSTextField() // 显示 沙雕网友的昵称
    
    var recommedView = RecommedCell() // 沙雕网友的日常推荐
    
    var titleLabel = NSTextField()
    
    let connect = ConnectTool()
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        self.initListUI()
        self.initDate()
        self.getCalendarData()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // 发现在主屏上每次都会打印 draw,然而在外接屏上不会每次打印
        print("draw")
        self.initDate()
        self.getCalendarData()
    }
    
    func initDate() {
        let mouthArr = ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]
        let weekArr = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"]
        let date = Date.init()
        let chinese = Calendar.init(identifier: .gregorian)
        let components = Set<Calendar.Component>([.year, .month, .day, .weekday])
        let theComponents = chinese.dateComponents(components, from: date)
        let year = theComponents.year!.description
        let mouth = mouthArr[theComponents.month! - 1]
        let dayStr = theComponents.day!.description
        let day = theComponents.day! < 10 ? "0\(dayStr)" : dayStr
        let week = weekArr[theComponents.weekday! - 1]
        
        
        self.dateLineOne.stringValue = "\(year) \(mouth) \(week)"
        self.dateLineTwo.stringValue = day
    }
    
    func getCalendarData() {
        self.connect.getDataJWT { (jwt) in
            self.connect.getDailyData(jwt: jwt, success: { (data) in
                self.updateData(data)
            })
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
        DispatchQueue.main.sync {
            self.fortuneLine.stringValue = fortune
            self.recommedView.recommedDes.stringValue = recommedDes
            self.recommedView.recommedName.stringValue = "via \(recommedName)"
            self.recommedView.url = url
        }
        
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
        
        dateLineOne.frame = NSRect.init(x: 0, y: (calenderHeight - topStart - 30), width: width, height: 20)
        dateLineOne.isEditable = false
        dateLineOne.isBordered = false
        dateLineOne.backgroundColor = jike_Y
        dateLineOne.maximumNumberOfLines = 1
        dateLineOne.alignment = .center
        dateLineOne.stringValue = "2019 三月 星期四"
        dateLineOne.font = NSFont.boldSystemFont(ofSize: 14)
        dateLineOne.textColor = font_color
        
        dateLineTwo.frame = NSRect.init(x: 0, y: (calenderHeight - topStart - 120), width: width, height: 100)
        dateLineTwo.isEditable = false
        dateLineTwo.isBordered = false
        dateLineTwo.backgroundColor = jike_Y
        dateLineTwo.maximumNumberOfLines = 1
        dateLineTwo.alignment = .center
        dateLineTwo.stringValue = "02"
        dateLineTwo.font = NSFont.boldSystemFont(ofSize: 85)
        dateLineTwo.textColor = font_color
        
        fortuneLine.frame = NSRect.init(x: 30, y: (calenderHeight - topStart - 240), width: width - 60, height: 125)
        fortuneLine.isEditable = false
        fortuneLine.isBordered = false
        fortuneLine.backgroundColor = jike_Y
        fortuneLine.alignment = .center
        fortuneLine.font = NSFont.systemFont(ofSize: 25)
        fortuneLine.textColor = font_color
        
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
        calendarView.addSubview(fortuneLine)
        calendarView.addSubview(dateLineOne)
        calendarView.addSubview(lineOne)
        calendarView.addSubview(lineTwo)
        calendarView.addSubview(recommedView)
        
        self.addSubview(calendarView)
    }
    
    func initBottomTool() {
        let bottomBar = NSView.init(frame: NSRect.init(x: 0, y: 0, width: width, height: topStart))
        
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
    
}
