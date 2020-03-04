//
//  NotificationController.swift
//  covid19-applewatch WatchKit Extension
//
//  Created by h4nuko0n on 2020/02/25.
//  Copyright © 2020 hanukoon. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications


class NotificationController: WKUserNotificationInterfaceController {
//    @IBOutlet weak var mainlabel: WKInterfaceLabel!
//    @IBOutlet weak var curelabel: WKInterfaceLabel!
//    @IBOutlet weak var deathlabel: WKInterfaceLabel!
    
    
    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func didReceive(_ notification: UNNotification) {
        // This method is called when a notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
    }

}
