//
//  checkyApp.swift
//  checky
//
//  Created by RED, Taeangel on 2022/09/30.
//

import SwiftUI

@main
struct checkyApp: App {
    var body: some Scene {
        WindowGroup {
          let dataHolder = DateHolder()
            CalendarView()
            .environmentObject(dataHolder)
        }
    }
}
