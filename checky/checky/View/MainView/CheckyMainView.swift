//
//  CheckyMainView.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/10.
//

import SwiftUI

struct CheckyMainView: View {
  @ObservedObject var checkyMainViewModel: CheckyMainViewModel = CheckyMainViewModel()
  
  var body: some View {
    CustomTabBarContainerView(selection: $checkyMainViewModel.tabSelection) {
//      CalendarView(viewModel: CalendarViewModel(dateHolder: DateHolder(), eventManager: EventManager(), calendarHelper: CalendarHelper()))
      WeeklyView(viewModel: WeeklyViewModel(dateHolder: DateHolder(), eventManager: EventManager(), calendarHelper: CalendarHelper()))
        .tabBarItem(tab: .calendar, selection: $checkyMainViewModel.tabSelection)
      Color.red
        .tabBarItem(tab: .daily, selection: $checkyMainViewModel.tabSelection)
      Color.orange
        .tabBarItem(tab: .add, selection: $checkyMainViewModel.tabSelection)
      Color.green
        .tabBarItem(tab: .setting, selection: $checkyMainViewModel.tabSelection)
      Color.blue
        .tabBarItem(tab: .market, selection: $checkyMainViewModel.tabSelection)
    }
  }
}

struct CheckyMainView_Previews: PreviewProvider {
  static var previews: some View {
    CheckyMainView()
  }
}
