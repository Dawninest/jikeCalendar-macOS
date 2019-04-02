//
//  StatusMenuController.swift
//  J2K
//
//  Created by Dawninest on 2019/4/2.
//  Copyright © 2019 dawninest. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    
    var mainBack: MainBackView!
    
    var mainItem: NSMenuItem!
    
    let connect = ConnectTool()
    
    
    @IBOutlet weak var menuMain: NSMenu!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    override func awakeFromNib() {
        statusItem.button?.title = "J2K"
        statusItem.menu = menuMain
        
        
        mainBack = MainBackView.init()
       
        mainItem = menuMain.item(withTitle: "main")
        mainItem.view = mainBack
        
    }
    
   
}
