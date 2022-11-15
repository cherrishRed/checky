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
  let eventManager = EventManager()
  let reminderManager = ReminderManager()
  
  var body: some View {
    VStack {
      CustomTabBarContainerView(selection: $checkyMainViewModel.tabSelection) {
        CalendarView(eventManager: eventManager, reminderManager: reminderManager)
          .environmentObject(coordinator)
          .tabBarItem(tab: .calendar, selection: $checkyMainViewModel.tabSelection)
        ReminderView(viewModel: ReminderViewModel(eventManager: eventManager, reminderManager: reminderManager))
          .tabBarItem(tab: .reminder, selection: $checkyMainViewModel.tabSelection)
        SettingListView(viewModel: SettingViewModel(eventManager: EventManager(), reminderManager: ReminderManager()))
          .tabBarItem(tab: .setting, selection: $checkyMainViewModel.tabSelection)
      }
    }.onAppear {
      coordinator.navigationController.navigationBar.isHidden = false
    }
  }
}

struct CheckyMainView_Previews: PreviewProvider {
  static var previews: some View {
    CheckyMainView()
  }
}
