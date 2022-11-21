//
//  EventSettingViewModel.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import EventKit
import SwiftUI

final class SettingViewModel: ObservableObject {
  let eventManager: EventManager
  let reminderManager: ReminderManager
  var eventCategories: [EKCalendar]
  let reminderCategories: [EKCalendar]
 
  init(
    eventManager: EventManager,
    reminderManager: ReminderManager
  ) {
    self.eventManager = eventManager
    self.eventCategories = eventManager.getTaskCategories()
    self.reminderManager = reminderManager
    self.reminderCategories = reminderManager.getTaskCategories()
  }
}
