//
//  Reminder.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/05.
//

import Foundation
import EventKit

struct Reminder: Hashable, ReminderProtocol {
  var ekreminder: EKReminder
  var category: EKCalendar
}

protocol ReminderProtocol {
  var ekreminder: EKReminder { get set }
  var category: EKCalendar { get set }
}
