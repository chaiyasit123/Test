//
//  AppPreference.swift
//  MasterTemplate
//
//  Created by Tanawat Suriyachai on 04/17/2560 BE.
//  Copyright (c) 2560 S-Planet. All rights reserved.
//

import UIKit

class AppPreference {
    
    static let firstTime = "firstTime"
    
    static let language = "language"
    
    static let registerId = "registerId"
    static let memberId = "memberId"
    static let personId = "personId"
    static let name = "name"
    static let surname = "surname"
    static let email = "email"
    static let birthday = "birthday"
    static let phone = "phone"
    static let grantPermissionNotification = "grantPermissionNotification"
    
    static let isLogin = "isLogin"
    static let isOTP = "isOTP"
    
    static let profileImageUrl = "profileImageUrl"
        
    static let latitude = "latitude"
    static let longitude = "longitude"
    
    static let paymentUrl = "paymentUrl"
    static let bidsFee = "bidsFee"
    static let offerFee = "offerFee"

    static let walletTransactionLink = "walletTransactionLink"
    static let offeringTransactionLink = "offeringTransactionLink"
    static let bidsTransactionLink = "bidsTransactionLink"
    static let updateProfileLink = "updateProfileLink"
    static let updateBankLink = "updateBankLink"
    static let lottoRoundDate = "lottoRoundDate"
    
    static let provinceId = "provinceId"
    static let districtId = "districtId"
    static let subDistrictId = "subDistrictId"
    static let shopProvinceId = "shopProvinceId"
    static let shopDistrictId = "shopDistrictId"
    static let shopSubDistrictId = "shopSubDistrictId"
    
    static let requestDataEncode = "requestDataEncode"

    static let grantPermissionLocation = "grantPermissionLocation"
    
    //  Register
    static let registerName = "registerName"
    static let registerPhone = "registerPhone"
    static let registerAddress = "registerAddress"
    static let registerIdCard = "registerIdCard"
    static let registerBirthday = "registerBirthday"
    static let registerLine = "registerLine"
    static let registerPost = "registerPost"
    static let registerFacebook = "registerFacebook"
    static let registerIdCardImage = "registerIdCardImage"
    
    static let registerShopName = "registerShopName"
    static let registerAddressShop = "registerAddressShop"
    static let registerBankName = "registerBankName"
    static let registerBankNo = "registerBankNo"
    static let registerBankLocation = "registerBankLocation"
    static let registerPostCode = "registerPostCode"
    static let registerShopImage = "registerShopImage"
    static let scanList = "scanList"
    
    
    
    var defaults: UserDefaults
    
    init() {
        defaults = UserDefaults(suiteName: "app")!
    }
    
    func setValueString(_ key: String, value: String) {
        defaults.setValue(value, forKey: key)
    }
    
    func setValueStringArray(_ key: String, value: [String]) {
        defaults.setValue(value, forKey: key)
    }
    
    
    
    func setValueInt(_ key: String, value: Int) {
        defaults.setValue(value, forKey: key)
    }
    
    func setValueDouble(_ key: String, value: Double) {
        defaults.setValue(value, forKey: key)
    }
    
    func setValueFloat(_ key: String, value: Float) {
        defaults.setValue(value, forKey: key)
    }
    
    func setValueBoolean(_ key: String, value: Bool) {
        defaults.setValue(value, forKey: key)
    }
    
    func setValueObject(_ key: String, value: Any) {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: value)
        defaults.setValue(encodedData, forKey: key)
    }
    
    func setValueChatArray(_ key: String, value: Data) {
        defaults.setValue(value, forKey: key)
    }
    
    func getValueString(_ key: String) -> String {
        let value = defaults.string(forKey: key)
        return value == nil ? "" : value!
    }
    
    func getValueStringArray(_ key: String) -> [String] {
        let value = defaults.object(forKey: key)
        return value == nil ? [] : value as! [String]
    }
    
    func getValueInt(_ key: String) -> Int {
        let value = defaults.object(forKey: key)
        return value == nil ? 0 : value as! Int
    }
    
    func getValueFloat(_ key: String) -> Float {
        let value = defaults.object(forKey: key)
        return value == nil ? 0 : value as! Float
    }
    
    func getValueDouble(_ key: String) -> Double {
        let value = defaults.object(forKey: key)
        return value == nil ? 0 : value as! Double
    }
    
    func getValueBoolean(_ key: String) -> Bool {
        let value = defaults.object(forKey: key)
        return value == nil ? false : value as! Bool
    }
    
    func getValueObject(_ key: String) -> Any? {
        let value = defaults.object(forKey: key)
        if value == nil {
            return nil
        }
        let decoded = NSKeyedUnarchiver.unarchiveObject(with: value as! Data) as Any
        return decoded
    }
    
    func getValueChatArray(_ key: String) -> Data? {
        let value = defaults.object(forKey: key)
        return value == nil ? nil : value as? Data
    }
    
    func synchronize() {
        defaults.synchronize()
    }
    
    func clear() {
        for key in Array(defaults.dictionaryRepresentation().keys) {
            defaults.removeObject(forKey: key)
        }
    }
    
}
