//
//  ReminderViewModel.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import Foundation
import EventKit

class ReminderCategoriListViewModel: ObservableObject {
  let reminderManager: ReminderManager
  let categories: [EKCalendar]
  init (
    reminderManager: ReminderManager
  ) {
    self.reminderManager = reminderManager
    self.categories = reminderManager.getTaskCategories()
  }
}
