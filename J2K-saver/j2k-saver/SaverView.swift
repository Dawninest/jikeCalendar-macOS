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
    override init!(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        self.initUI()
        
    }
    
    func initUI () {
        let text = NSTextField.init(frame: NSRect.init(x: 100, y: 100, width: 500, height: 500))
        text.isEditable = false
        text.isBordered = false
        text.drawsBackground = false
        text.font = NSFont.systemFont(ofSize: 100)
        text.textColor = .white
        text.stringValue = "jike calendar"
        self.addSubview(text)
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
    }
    
    override func animateOneFrame() {
        return
    }
    
    override var hasConfigureSheet: Bool {
        return true
    }
    
    override var configureSheet: NSWindow? {
        return nil
    }
}
