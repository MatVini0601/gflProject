//
//  UserDefaultsUtils.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 20/03/23.
//

import Foundation

class UserDefaultsUtils {
    
    static var shared = UserDefaultsUtils()
        
    func setDarkMode(enable: Bool) {
           let defaults = UserDefaults.standard
           defaults.set(enable, forKey: Constants.DARK_MODE)
    }
    
    func getDarkMode() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: Constants.DARK_MODE)
    }
}
