//
//  ReminderCreateViewModel.swift
//  checky
//
//  Created by RED on 2022/10/13.
//

import Foundation

class ReminderCreateViewModel: ObservableObject {
  let reminderMenuViewModel = ReminderMenuViewModel()
  
  func tappedCloseButton() {
    reminderMenuViewModel.reset()
  }
  func tappedCreateButton() {
    reminderMenuViewModel.saveNewReminder()
    reminderMenuViewModel.reset()
  }
}
