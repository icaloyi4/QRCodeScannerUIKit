//
//  SharedPrefference.swift
//  qrcodereader
//
//  Created by Rizky Haris Risaldi on 06/08/23.
//

import Foundation

class SharedPrefference{
    let preferences = UserDefaults.standard
    func getDataString(key : String) -> String? {
        if preferences.object(forKey: key) == nil {
            return nil
        } else {
            return preferences.string(forKey: key)
        }
    }
    
    func writeDataString(key:String, data:String){
        preferences.set(data, forKey: key)
    }
}
