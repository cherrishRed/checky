//
//  ReminderEditViewModel.swift
//  checky
//
//  Created by RED on 2022/10/13.
//

import Foundation

class ReminderEditViewModel: ObservableObject {
  let reminderMenuViewModel = ReminderMenuViewModel()
  
  func tappedCloseButton() {
    reminderMenuViewModel.reset()
  }
  func tappedCreateButton() {
    reminderMenuViewModel.reset()
  }
}
