//
//  Event.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/05.
//

import Foundation
import EventKit

struct Event: Hashable {
  var ekevent: EKEvent
  var category: EKCalendar
}
