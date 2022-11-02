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
  
  @Published var imoji: String?
  
  init (
    category: EKCalendar,
    eventManager: EventManager
  ) {
    self.category = category
    self.eventManager = eventManager
    self.imoji = imoji
  }
}
