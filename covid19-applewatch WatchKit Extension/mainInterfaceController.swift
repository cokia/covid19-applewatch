//
//  mainInterfaceController.swift
//  covid19-applewatch WatchKit Extension
//
//  Created by h4nuko0n on 2020/02/25.
//  Copyright © 2020 hanukoon. All rights reserved.
//

import WatchKit
import Foundation

class mainInterfaceController: WKInterfaceController {

    @IBOutlet weak var mainbutton: WKInterfaceButton!
    @IBOutlet weak var listPicker: WKInterfacePicker?
    
     
     var shapeList: [(String, String)] = [
         ("CU", "cu"),
         ("GS25", "gs25"),
         ("이디야커피", "coffee"),
         ("BHC", "bhc"),
         ("스타벅스", "starbucks"),
        ("설빙", "bingsu")];
     

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    override func willActivate() {
        let pickerItems: [WKPickerItem?] = shapeList.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = $0.0// 列表项的标题文本
            pickerItem.caption = $0.1// 提示信息文本
            return pickerItem
        }
        listPicker?.setItems(pickerItems as? [WKPickerItem])
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
//     func replace(main: String,target: String, withString: String) -> String { return main.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil) }
//    func onHttpRequest(_ reqtype:String) {
//
//        //URL생성
//        let url = "https://covidwatch.danal.me/" //확진자
//        guard let totalurl = URL(string:url+reqtype) else {return}
//        var request = URLRequest(url: totalurl)
//        request.httpMethod = "get" //get : Get 방식, post : Post 방식
//
//        let session = URLSession.shared
//        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
//
//            //error 일경우 종료
//            guard error == nil && data != nil else {
//                if let err = error {
//                    print(err.localizedDescription)
//                }
//                return
//            }
//
//            //data 가져오기
//            if let _data = data {
//                if let strData = NSString(data: _data, encoding: String.Encoding.utf8.rawValue) {
//                    let str: String = String(strData)
//                    //print(str)
//                    //메인쓰레드에서 출력하기 위해
//                    DispatchQueue.main.async {
//                        print(str)
//
//                        if(reqtype == "confirmator"){
//                             self.totallabel.setText(str)
//                        }
//                        if(reqtype == "release"){
//                             self.releaselabel.setText(str)
//                        }
//                        if(reqtype == "death"){
//                             self.deathlabel.setText(str)
//                        }
////                        let labelname:String = reqtype + "label"
////                        self.labelname.setText(str)
//                    }
//                }
//            }else{
//                print("data nil")
//            }
//        })
//        task.resume()
//    }
//}
}
