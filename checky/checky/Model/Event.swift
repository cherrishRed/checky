//
//  Event.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/05.
//

import Foundation
import EventKit

struct Event: Hashable, EventProtocol {
  var ekevent: EKEvent
  var category: EKCalendar
}

protocol EventProtocol {
  var ekevent: EKEvent { get set }
  var category: EKCalendar { get set }
}

protocol TaskProtocol: EventProtocol, ReminderProtocol {}


