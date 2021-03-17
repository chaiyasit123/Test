//
//  Connection.swift
//  Master
//
//  Created by Tanawat Suriyachai on 04/17/2560 BE.
//  Copyright (c) 2560 S-Planet. All rights reserved.
//

import Alamofire

protocol ConnectionDelegate {
    func onSuccess(_ result: String)
    func onLostConnection()
}

protocol ConnectionUpdateDelegate {
    func onUpdate(_ progress: Int...)
}

open class Connection: NSObject {
    
    var url: String!
    open var delay: TimeInterval!
    var requestMethod: String = "POST"
    
    fileprivate var postData: [NameValue]!, fileData: [NameValue]!
    fileprivate var timer: Timer!
    
    var delegate: ConnectionDelegate!
    var updateDelegate: ConnectionUpdateDelegate!
    
    public typealias completionClosure = (_ result: String) -> Void
    public typealias lostClosure = () -> Void
    
    private var requestCount = 0
    open var maxRequestTime = 3
    
    open var innerAction: (completionClosure)?
    open var lostAction: (lostClosure)?
    
    open var useGPS = true
    open var needCached = false
    open var useCachePreload = false
    
    public init(url: String) {
        self.url = url
        delay = 0
    }
    
    public func addPostData(_ name: String, value: String) {
        if (postData == nil) {
            postData = []
        }
        postData.append(NameValue(name: name, value: value))
    }
    
    public func addFileData(_ name: String, value: String) {
        if (fileData == nil) {
            fileData = []
        }
        fileData.append(NameValue(name: name, value: value))
    }
    
    public func onComplete(_ innerAction: (completionClosure)?) {
        if let options = innerAction {
            self.innerAction = options
        }
    }
    
    public func onLostConnection(_ lostAction: (lostClosure)?) {
        if let options = lostAction {
            self.lostAction = options
        }
    }
    
    public func execute() {
        requestCount += 1
        delay = 0
        
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
        timer = Timer.scheduledTimer(timeInterval: delay
            , target: self
            , selector: #selector(self.doRequest)
            , userInfo: nil
            , repeats: false)
        
        //  Return cache for preload
        if useCachePreload {
            if let options = self.innerAction {
                //  Get result from preference
                let appPreference = AppPreference()
                let result = appPreference.getValueString(self.url)
                options(result)
            }
        }
    }
    
    @objc func doRequest() {
        //  Add default data
        let appPreference = AppPreference()
        var language = appPreference.getValueString(AppPreference.language)
        if language.isEmpty {
            language = Constant.DEFAULT_LANGUAGE
        }
        let latitude = appPreference.getValueDouble(AppPreference.latitude)
        let longitude = appPreference.getValueDouble(AppPreference.longitude)
        let personId = appPreference.getValueString(AppPreference.personId)
        
        let timeStamp = Date.currentTimeStamp
        addPostData("key", value: Constant.API_KEY)
        addPostData("Content-Type", value: "application/x-www-form-urlencoded")
        addPostData("authenkey", value: Constant.API_KEY_Node)
        addPostData("lang", value: language)
        addPostData("timestamp", value: String(timeStamp))
        if useGPS {
            addPostData("latitude", value: String(latitude))
            addPostData("longitude", value: String(longitude))
        }
        addPostData("person_id", value: personId)
        
        let headers: HTTPHeaders = [
            "lang": language
            , "Accept-Encoding": "gzip"
            , "authenkey": Constant.API_KEY_Node
            , "timestamp": String(timeStamp)
        ]
        
        let modelName = UIDevice.modelName
        let os =  UIDevice.current.systemName
        let version = UIDevice.current.systemVersion
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let uid = UIDevice.current.identifierForVendor!.uuidString
        
        addPostData("brand", value: Constant.BRAND)
        addPostData("model", value: modelName)
        addPostData("os", value: os)
        addPostData("version", value: version)
        addPostData("app_version", value: appVersion!)
        addPostData("device_id", value: uid)
        
        if fileData == nil {
            var parameters: Parameters = [:]
            if postData != nil {
                for data in postData {
                    let value = data.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                    //NSLog("name : \(data.name), value : \(value!)")
                    parameters.updateValue(value!, forKey: data.name)
                }
            }
            
            AF.request(url, method: .get,  parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseString(completionHandler: { (response) in
                switch response.result {
                    case .success(let value):
                        if let json = value as? String {
                            print("Result\(response.response!.statusCode) : \(json)")
                            if let options = self.innerAction {
                                let decodedData = Data(base64Encoded: json)!
                                let decodedString = String(data: decodedData, encoding: .utf8)!
                                //options(response.value!)
                                options(decodedString)

                                //  Save result to preference
                                if self.needCached {
                                    let appPreference = AppPreference()
                                    appPreference.setValueString(self.url, value: response.value!)
                                    appPreference.synchronize()
                                }
                            }
                        }
                    case .failure(let error):
                        print(error)
                        NSLog("Lost connection")
                        if let options = self.lostAction {
                            if self.requestCount == self.maxRequestTime {
                                //  Get result from preference
                                let appPreference = AppPreference()
                                let result = appPreference.getValueString(self.url)
                                if result.isEmpty || !self.needCached {
                                    options()
                                } else {
                                    if let options2 = self.innerAction {
                                        options2(result)
                                    }
                                }
                            } else {
                                self.execute()
                            }
                        }
                }
            })
        } else {
            AF.upload(multipartFormData: { (formData) in
                if self.postData != nil {
                    for data in self.postData {
                        let value = data.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                        formData.append((value?.data(using: .utf8)!)!, withName: data.name)
                    }
                }

                if self.fileData != nil {
                    for data: NameValue in self.fileData {
                        //  Check file exist
                        let fileUrl = URL(string: data.value)
                        formData.append(fileUrl!, withName: data.name)
                    }
                }
            }, to: url)
            .uploadProgress { progress in
                print("Upload Progress: \(progress.fractionCompleted)")
            }
            .responseString(completionHandler: { (response) in
                switch response.result {
                    case .success(let value):
                        if let options = self.innerAction {
                            let result = String(data: response.data!, encoding: .utf8)
                            //NSLog("Result : \(result!)")
                            print("Result : \(result!)")
                            options(result!)
                        }
                    case .failure(let error):
                        print(error)
                        NSLog("Lost connection")
                        if let options = self.lostAction {
                            if self.requestCount == self.maxRequestTime {
                                options()
                            } else {
                                self.execute()
                            }
                        }
                }
            })
        }
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
            for data: NameValue in postData {
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

class NameValue {
    
    var name: String!
    var value: String!
    
    init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}

extension Date {
    static var currentTimeStamp: Int64{
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    
    static var yesterday: Date { return Date().dayBefore }
    
    static var tomorrow:  Date { return Date().dayAfter }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
    
}
