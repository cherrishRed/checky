//
//  EventButtonViewModel.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import Foundation
import EventKit

class EventButtonViewModel: ObservableObject {
  let category: EKCalendar
  let eventManager: EventManager
  
  init (
    category: EKCalendar,
    eventManager: EventManager
  ) {
    self.category = category
    self.eventManager = eventManager
  }
   
}
