//
//  ConnectionPrompt.swift
//  M Help Me
//
//  Created by S-Planet01 on 26/4/2563 BE.
//  Copyright © 2563 S-planet. All rights reserved.
//

import UIKit

protocol ConnectionPromptDelegate {
    func onSuccess(_ result: String)
    func onLostConnection()
}

protocol ConnectionPromptUpdateDelegate {
    func onUpdate(_ progress: Int...)
}

class ConnectionPrompt: NSObject {

    var url: String!
    var delay: TimeInterval!
    var requestMethod: String = "POST"

    fileprivate var postData: [NameValue2]!, fileData: [NameValue2]!
    fileprivate var timer: Timer!

    var delegate: ConnectionPromptDelegate!
    var updateDelegate: ConnectionPromptUpdateDelegate!

    typealias completionClosure = (_ result: String) -> Void
    typealias lostClosure = () -> Void

    fileprivate var innerAction: (completionClosure)?
    fileprivate var lostAction: (lostClosure)?
    
    open var useGPS = true
    open var needCached = false
    open var useCachePreload = false

    init(url: String) {
        self.url = url
        delay = 0
    }

    func addPostData(_ name: String, value: String) {
        if (postData == nil) {
            postData = []
        }
        postData.append(NameValue2(name: name, value: value))
    }

    func addFileData(_ name: String, value: String) {
        if (fileData == nil) {
            fileData = []
        }
        fileData.append(NameValue2(name: name, value: value))
    }

    func onComplete(_ innerAction: (completionClosure)?) {
        if let options = innerAction {
            self.innerAction = options
        }
    }

    func onLostConnection(_ lostAction: (lostClosure)?) {
        if let options = lostAction {
            self.lostAction = options
        }
    }

    func execute() {
        timer = Timer.scheduledTimer(timeInterval: delay
            , target: self
            , selector: #selector(ConnectionPrompt.doPost)
            , userInfo: nil
            , repeats: false)
    }

    @objc func doPost() {
        let lineEnd = "\r\n";
        let twoHyphens = "--";
        let boundary = "*****";

        //  Start request
        let url: URL = URL(string: self.url)!
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = requestMethod
        //      request.cachePolicy = NSURLRequest.CachePolicy.ReloadIgnoringCacheData

        //  Check if upload file
        if (fileData == nil) {
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        } else {
            request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
            request.addValue("multipart/form-data;boundary=" + boundary, forHTTPHeaderField: "Content-Type")
        }

        request.addValue("gzip", forHTTPHeaderField: "Accept-Encoding")
        //request.addValue(language, forHTTPHeaderField: "lang")

        //  Add default data
        let appPreference = AppPreference()
        var language = appPreference.getValueString(AppPreference.language)
        if language.isEmpty {
            language = Constant.DEFAULT_LANGUAGE
        }
        let latitude = appPreference.getValueDouble(AppPreference.latitude)
        let longitude = appPreference.getValueDouble(AppPreference.longitude)
        let registerId = appPreference.getValueString(AppPreference.registerId)
        
        addPostData("key", value: Constant.API_KEY)
        addPostData("authenkey", value: Constant.API_KEY_Node)
        addPostData("lang", value: language)
        if useGPS {
            addPostData("latitude", value: String(latitude))
            addPostData("longitude", value: String(longitude))
        }
        
        request.addValue(language, forHTTPHeaderField: "lang")
        request.addValue(Constant.API_KEY_Node, forHTTPHeaderField: "authenkey")
        
        let modelName = UIDevice.modelName
        let version = UIDevice.current.systemVersion
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let uid = UIDevice.current.identifierForVendor!.uuidString

        addPostData("brand", value: Constant.BRAND)
        addPostData("model", value: modelName)
        addPostData("os", value: "ios")
        addPostData("version", value: version)
        addPostData("app_version", value: appVersion!)
        addPostData("device_id", value: uid)
        addPostData("device_token", value: registerId)
    
        //  Check if upload file
        let body = NSMutableData()
        let encryptString: String
        do {
            encryptString = try MCrypt.encode(getPostDataString())
        } catch _ {
            encryptString = ""
        }
        //NSLog("encryptString \(encryptString)")
        if (fileData == nil) {
            //            body.append(NSString(format: "input=%@", encryptString).data(using: String.Encoding.utf8.rawValue)!)
            if requestMethod == "POST" || requestMethod == "PUT" {
                body.append(NSString(format: "%@", encryptString).data(using: String.Encoding.utf8.rawValue)!)
            }
        } else {
            //  Define content data
            if (postData != nil) {
                for data: NameValue2 in postData {
                    let key = data.name;
                    let value = data.value
                    body.append(NSString(format: "%@%@%@", twoHyphens, boundary, lineEnd).data(using: String.Encoding.utf8.rawValue)!)
                    body.append(NSString(format: "Content-Disposition: form-data; name=\"%@\"%@", key!, lineEnd).data(using: String.Encoding.utf8.rawValue)!)
                    body.append(NSString(format: "Content-Type: text/plain; charset=UTF-8%@", lineEnd).data(using: String.Encoding.utf8.rawValue)!)
                    body.append(NSString(format: "Content-Length: %d%@%@", (value?.count)!, lineEnd, lineEnd).data(using: String.Encoding.utf8.rawValue)!)
                    body.append(NSString(format: "%@", value!).data(using: String.Encoding.utf8.rawValue)!)
                    body.append(NSString(format: "%@", lineEnd).data(using: String.Encoding.utf8.rawValue)!)
                }
            }

            //  Define file data
            var fileIndex = 0
            for data: NameValue2 in fileData {
                //  Check file exist
                let fileUrl = NSURL(string: data.value)
                if FileManager.default.fileExists(atPath: fileUrl!.path ?? "") {
                    let fileName = data.value.components(separatedBy: "/").last
                    let mimeType = "application/octet-stream"
                    body.append(NSString(format: "%@%@%@", twoHyphens, boundary, lineEnd).data(using: String.Encoding.utf8.rawValue)!)
                    body.append(NSString(format: "Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"%@", data.name, fileName!, lineEnd).data(using: String.Encoding.utf8.rawValue)!)
                    body.append(NSString(format: "Content-Type: %@%@%@", mimeType, lineEnd, lineEnd).data(using: String.Encoding.utf8.rawValue)!)

                    //  Get file lenght
                    //let contentData = NSData(contentsOfURL: NSURL(string: data.value)!)
                    //                    let fileLength: Int = contentData == nil ? 1 : contentData!.length

                    //  Open stream
                    let stream: InputStream = InputStream(url: fileUrl! as URL)!
                    stream.schedule(in: RunLoop.current, forMode: RunLoop.Mode.default)
                    stream.open()
                    var buffer = [UInt8](repeating: 0, count: 1024)
                    var total: Int = 0
                    while stream.hasBytesAvailable {
                        let count = stream.read(&buffer, maxLength: buffer.count)
                        total += count
                        body.append(buffer, length: count)
                        //                        let progress = Int(total * 100 / fileLength)
                        //publishProgress(fileIndex, progress)
                    }

                    body.append(NSString(format: "%@", lineEnd).data(using: String.Encoding.utf8.rawValue)!)
                    body.append(NSString(format: "%@%@%@%@", twoHyphens, boundary, twoHyphens, lineEnd).data(using: String.Encoding.utf8.rawValue)!)

                    fileIndex += 1
                }
            }
        }
        request.httpBody = body as Data
        let task = session.dataTask(with: request as URLRequest) {
            ( data, response, error) in

            guard let _:Data = data, let _:URLResponse = response, error == nil else {
                print("error \(error)")
                //  Send to main thread
                DispatchQueue.main.async(execute: {
                    if self.delegate == nil {
                        if let options = self.lostAction {
                            options()
                        }
                    } else {
                        self.delegate.onLostConnection()
                    }
                })
                return
            }
            let resultText = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
            NSLog("resultText \(resultText)")
            let decryptString: String
            do {
                decryptString = try MCrypt.decode(resultText)
            } catch _ {
                decryptString = ""
            }

            //  Send to main thread
            DispatchQueue.main.async(execute: {
                if self.delegate == nil {
                    if let options = self.innerAction {
//                        let decodedData = Data(base64Encoded: resultText)
//                        let decodedString = String(data: decodedData!, encoding: .utf8)
                        options(decryptString)
                        //options(decodedString!)
                    }
                } else {
                    self.delegate.onSuccess(decryptString)
                }
            })
        }
        task.resume()
    }

    private func publishProgress(progress: Int...) {
        if (updateDelegate != nil) {
            //  Send to main thread
            DispatchQueue.main.async(execute: {
                self.updateDelegate.onUpdate(progress[0], progress[1])
            })

        }
    }

    private func getPostDataString() -> String {
        var result = ""
        var isFirst = true
        if (postData != nil) {
            for data: NameValue2 in postData {
                if (isFirst) {
                    isFirst = false
                } else {
                    result += "&"
                }

                let value = data.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                result += (data.name + "=" + value!)
            }
        }
        return result
    }

}

class NameValue2 {

    var name: String!
    var value: String!

    init(name: String, value: String) {
        self.name = name
        self.value = value
    }

}


