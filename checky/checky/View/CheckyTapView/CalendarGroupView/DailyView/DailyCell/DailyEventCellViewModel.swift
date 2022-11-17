//
//  DailyEventCellViewModel.swift
//  checky
//
//  Created by RED on 2022/10/31.
//

import SwiftUI

final class DailyEventCellViewModel: ViewModelable {
  @Published var event: Event
  var eventManager: EventManager
  
  init(event: Event,
       eventManager: EventManager) {
    self.event = event
    self.eventManager = eventManager
  }
  
  var color: Color {
    let userColor = fetchUserDefaultColor(calendarIdentifier: event.category.calendarIdentifier)
    
    if userColor == Color.white {
      return Color(event.category.cgColor)
    } else {
      return fetchUserDefaultColor(calendarIdentifier: event.category.calendarIdentifier)
    }
  }
  
  var icon: String {
    let emoji = fetchUserDefaultEmoji(calendarIdentifier: event.category.calendarIdentifier)
    if emoji.count == 0 {
      return "😀"
    }
    return emoji
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
