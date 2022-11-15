//
//  DailyReminderCellVeiwModel.swift
//  checky
//
//  Created by RED on 2022/10/31.
//

import SwiftUI

class DailyReminderCellViewModel: ViewModelable {
  @Published var reminder: Reminder
  @Published var isCompletion: Bool
  @Published var isShowAlert: Bool
  @Published var alertDescription: String
  var reminderManager: ReminderManager
  
  init(reminder: Reminder,
       reminderManager: ReminderManager,
       isShowAlert: Bool = false,
       alertDescription: String = ""
  ) {
    self.reminder = reminder
    self.isCompletion = reminder.ekreminder.isCompleted
    self.reminderManager = reminderManager
    self.isShowAlert = isShowAlert
    self.alertDescription = alertDescription
  }
  
  var color: Color {
    let userColor = fetchUserDefaultColor(calendarIdentifier: reminder.category.calendarIdentifier)
    
    if userColor == Color.white {
      return Color(reminder.category.cgColor)
    } else {
      return fetchUserDefaultColor(calendarIdentifier: reminder.category.calendarIdentifier)
    }
  }
  
  enum Action {
    case tappedCompletion
  }
  
  func action(_ action: Action) {
    switch action {
    case .tappedCompletion:
      reminder.ekreminder.isCompleted.toggle()
      switch reminderManager.editReminder(reminder.ekreminder) {
      case .success(let success):
        isCompletion = success
        alertDescription = "reminder 수정 성공😃"
        isShowAlert.toggle()
      case .failure(let failure):
        alertDescription = failure.localizedDescription
        isShowAlert.toggle()
      }
    }
  }
}
