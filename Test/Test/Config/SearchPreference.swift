//
//  SearchPreference.swift
//  MasterTemplate
//
//  Created by Tanawat Suriyachai on 04/17/2560 BE.
//  Copyright (c) 2560 S-Planet. All rights reserved.
//

import UIKit

class SearchPreference {
    
    static let jobType = "jobType"
    static let jobExp = "jobExp"
    static let jobAge = "jobAge"
    static let jobEducation = "jobEducation"
    static let jobMinSalary = "jobMinSalary"
    static let jobMaxSalary = "jobMaxSalary"

    
    var defaults: UserDefaults
    
    init() {
        defaults = UserDefaults(suiteName: "search")!
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
    
    func setValueBoolean(_ key: String, value: Bool) {
        defaults.setValue(value, forKey: key)
    }
    
    func setValueObject(_ key: String, value: Any) {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: value)
        defaults.setValue(encodedData, forKey: key)
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
    
    func synchronize() {
        defaults.synchronize()
    }
    
    func clear() {
        for key in Array(defaults.dictionaryRepresentation().keys) {
            defaults.removeObject(forKey: key)
        }
    }
    
}
