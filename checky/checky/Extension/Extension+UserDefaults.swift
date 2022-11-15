//
//  Extension+UserDefaults.swift
//  checky
//
//  Created by RED on 2022/11/15.
//

import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
        let appGroupId = "group.checky.red.taeangel"
        return UserDefaults(suiteName: appGroupId)!
    }
}
