//
//  EventButtonViewModel.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import EventKit
import SwiftUI

class EventCategoriSettingViewModel: ObservableObject {
  let category: EKCalendar
  let eventManager: EventManager
  @Published var emoji: String = ""
  @Published var color: Color = .white
  
  init (
    category: EKCalendar,
    eventManager: EventManager,
    emoji: String = "",
    color: Color = .white
    
  ) {
    self.emoji = emoji
    self.color = color
    self.category = category
    self.eventManager = eventManager
  }
}
