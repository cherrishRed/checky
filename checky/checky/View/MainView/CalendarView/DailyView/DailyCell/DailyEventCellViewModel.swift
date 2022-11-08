//
//  DailyEventCellViewModel.swift
//  checky
//
//  Created by RED on 2022/10/31.
//

import Foundation

class DailyEventCellViewModel: ViewModelable {
  @Published var event: Event
  var eventManager: EventManager
  
  init(event: Event,
       eventManager: EventManager) {
    self.event = event
    self.eventManager = eventManager
  }
  
  var isAllday: Bool {
    return event.ekevent.isAllDay
  }
  
  enum Action {
    case none
  }
  
  func action(_ action: Action) {
    
  }
  
}
