//
//  RecommedCell.swift
//  J2K
//
//  Created by Dawninest on 2019/4/2.
//  Copyright © 2019 dawninest. All rights reserved.
//

import Cocoa

typealias tapBlock = (String) -> Void

class RecommedCell: NSView {
    
    let width: CGFloat = 375 * 0.75
    let jike_Y = NSColor(red:0.98, green:0.89, blue:0.31, alpha:1.00) // FFE411
    let font_color = NSColor(red:0.25, green:0.25, blue:0.25, alpha:1.00)
    
    var recommedDes = NSTextField() // 显示 沙雕网友的评论
    var recommedName = NSTextField() // 显示 沙雕网友的昵称
    var url = ""
    
    var tapCallBack: tapBlock?
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        
        recommedDes.frame = NSRect.init(x: 20, y: 20, width: width - 40, height: 70)
        recommedDes.isEditable = false
        recommedDes.isBordered = false
        recommedDes.backgroundColor = jike_Y
        recommedDes.alignment = .left
        recommedDes.font = NSFont.systemFont(ofSize: 14)
        recommedDes.textColor = font_color
        
        recommedName.frame = NSRect.init(x: 20, y: 0, width: width - 40, height: 20)
        recommedName.isEditable = false
        recommedName.isBordered = false
        recommedName.backgroundColor = jike_Y
        recommedName.alignment = .right
        recommedName.font = NSFont.systemFont(ofSize: 12)
        recommedName.textColor = NSColor(red:0.60, green:0.53, blue:0.09, alpha:1.00)
        
        self.addSubview(recommedDes)
        self.addSubview(recommedName)
        
    }
    
    override func mouseDown(with event: NSEvent) {
        tapCallBack!(self.url)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecommedCell {
    func tapFunc(callBack: @escaping tapBlock) {
        tapCallBack = callBack
    }
}
