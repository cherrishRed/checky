//
//  EventButtonViewModel.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import Foundation
import EventKit

class ReminderButtonViewModel: ObservableObject {
  let category: EKCalendar
  let reminderManager: ReminderManager
  
  init (
    category: EKCalendar,
    reminderManager: ReminderManager
  ) {
    self.category = category
    self.reminderManager = reminderManager
  }
   
}
