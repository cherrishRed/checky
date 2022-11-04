//
//  CheckMainView.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/10.
//

import Foundation

class CheckyMainViewModel: ObservableObject {
  @Published var selection: String = "home"
  @Published var tabSelection: TabBarItem = .calendar
  
  init(
    selection: String = "home",
    tabSelection: TabBarItem = .calendar
  ) {
    self.selection = selection
    self.tabSelection = tabSelection
  }
}
