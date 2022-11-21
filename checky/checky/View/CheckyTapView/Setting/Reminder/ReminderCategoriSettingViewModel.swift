//
//  EventButtonViewModel.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import Foundation
import EventKit
import SwiftUI

final class ReminderCategoriSettingViewModel: ObservableObject {
  let category: EKCalendar
  let reminderManager: ReminderManager
  @Published var imoji: String = ""
  @Published var color: Color = .white
  
  init (
    category: EKCalendar,
    reminderManager: ReminderManager
  ) {
    self.category = category
    self.reminderManager = reminderManager
    self.imoji = imoji
  }
}
