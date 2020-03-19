//
//  ExtensionDelegate.swift
//  covid19-applewatch WatchKit Extension
//
//  Created by h4nuko0n on 2020/02/25.
//  Copyright © 2020 hanukoon. All rights reserved.
//

import WatchKit
import UIKit
import CoreLocation
import UserNotifications

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    func tokenAddtoServer(token :String) {
        let uuid = NSUUID().uuidString
        print(uuid)
            let url = "https://covidwatch.danal.me/apns/register"
            let arg = "?uuid=\(uuid)&token=\(token)"
           guard let totalurl = URL(string:url+arg) else {return}
        var request = URLRequest(url: totalurl)
            request.httpMethod = "get" //get : Get 방식, post : Post 방식
          let session = URLSession.shared
                let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                    
                    //error 일경우 종료
                    guard error == nil && data != nil else {
                        if let err = error {
                            print(err.localizedDescription)
                        }
                        return
                    }
                    if let _data = data {
                        if let strData = NSString(data: _data, encoding: String.Encoding.utf8.rawValue) {
                            let str: String = String(strData)
                            //print(str)
                            //메인쓰레드에서 출력하기 위해
                            DispatchQueue.main.async {
                                print(str)
                            }
                        }
                    }else{
                        print("data null")
                    }
                })
                task.resume()

    }
    
    func applicationDidFinishLaunching() {
        WKExtension.shared().registerForRemoteNotifications()
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge],
            completionHandler: { (didAllow, error) in
                print(didAllow)
            }
        )

    }
    
    
    func didRegisterForRemoteNotifications (withDeviceToken deviceToken: Data) {
        print("success")
        let token = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("APNs Device Token is \(token)")
        tokenAddtoServer(token: token)
        
        
    }
    
    func didReceiveRemoteNotification(_ userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (WKBackgroundFetchResult) -> Void) {
        print("recv")
    }
    
    func didFailToRegisterForRemoteNotificationsWithError(_ error: Error) {
        tokenAddtoServer(token: "asd")
        print("asdf")
        print(error)
    }
    
    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompletedWithSnapshot(false)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                // Be sure to complete the relevant-shortcut task once you're done.
                relevantShortcutTask.setTaskCompletedWithSnapshot(false)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                // Be sure to complete the intent-did-run task once you're done.
                intentDidRunTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }

}
