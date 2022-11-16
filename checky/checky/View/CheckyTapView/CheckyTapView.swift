//
//  CheckyMainView.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/10.
//

import SwiftUI

struct CheckyTapView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  @ObservedObject var checkyTapViewModel: CheckyTapViewModel = CheckyTapViewModel()
  
  var body: some View {
    VStack {
      CustomTabBarContainerView(selection: $checkyTapViewModel.tabSelection) {
        CalendarGroupView(eventManager: EventManager(), reminderManager: ReminderManager())
          .environmentObject(coordinator)
          .tabBarItem(tab: .calendar, selection: $checkyTapViewModel.tabSelection)
        ReminderView(viewModel: ReminderViewModel(eventManager: EventManager(), reminderManager: ReminderManager()))
          .tabBarItem(tab: .reminder, selection: $checkyTapViewModel.tabSelection)
        SettingListView(viewModel: SettingViewModel(eventManager: EventManager(), reminderManager: ReminderManager()))
          .tabBarItem(tab: .setting, selection: $checkyTapViewModel.tabSelection)
      }
    }
    .onAppear {
      coordinator.navigationController.navigationBar.isHidden = false
    }
  }
}

struct CheckyMainView_Previews: PreviewProvider {
  static var previews: some View {
    CheckyTapView()
  }
}
