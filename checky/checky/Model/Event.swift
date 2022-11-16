//
//  Event.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/05.
//

import Foundation
import EventKit

struct Event: Hashable, CheckyEventkitRepositoryProtocol {
  var ek: EKCalendarItem
  var category: EKCalendar
}
