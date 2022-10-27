//
//  CheckyMainView.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/10.
//

import SwiftUI

struct CheckyMainView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  @ObservedObject var checkyMainViewModel: CheckyMainViewModel = CheckyMainViewModel()
  
  var body: some View {
    VStack {
      CustomTabBarContainerView(selection: $checkyMainViewModel.tabSelection) {
        CalendarView()
          .tabBarItem(tab: .calendar, selection: $checkyMainViewModel.tabSelection)
        Color.red
          .tabBarItem(tab: .reminder, selection: $checkyMainViewModel.tabSelection)
        Color.green
          .tabBarItem(tab: .setting, selection: $checkyMainViewModel.tabSelection)
      }
    }
  }
}

struct CheckyMainView_Previews: PreviewProvider {
  static var previews: some View {
    CheckyMainView()
  }
}
