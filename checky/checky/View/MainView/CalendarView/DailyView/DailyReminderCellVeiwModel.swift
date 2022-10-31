//
//  DailyReminderCellVeiwModel.swift
//  checky
//
//  Created by RED on 2022/10/31.
//

import Foundation
import Combine

class DailyReminderCellViewModel: ViewModelable {
  @Published var reminder: Reminder
  @Published var isCompletion: Bool
  var reminderManager: ReminderManager
  var store =  Set<AnyCancellable>()
  
  init(reminder: Reminder,
       reminderManager: ReminderManager) {
    self.reminder = reminder
    self.isCompletion = reminder.ekreminder.isCompleted
    self.reminderManager = reminderManager
  }
  
  enum Action {
    case tappedCompletion
  }
  
  func action(_ action: Action) {
    switch action {
      case .tappedCompletion:
        reminder.ekreminder.isCompleted.toggle()
        let result = reminderManager.editReminder(reminder.ekreminder)
        switch result {
          case .success(let success):
            isCompletion = success
          case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
  }
}
