//
//  EventButtonViewModel.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import Foundation
import EventKit
import SwiftUI
import Combine

class EventCategoriSettingViewModel: ObservableObject {
  let category: EKCalendar
  let eventManager: EventManager
  @Published var imoji: String = ""
  @Published var color: Color = .white
  
  init (
    category: EKCalendar,
    eventManager: EventManager,
    imoji: String = "",
    color: Color = .white
    
  ) {
    self.imoji = imoji
    self.color = color
    self.category = category
    self.eventManager = eventManager
  }
}
