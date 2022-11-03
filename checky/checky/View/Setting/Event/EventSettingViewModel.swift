//
//  EventSettingViewModel.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import Foundation
import EventKit

class EventSettingViewModel: ObservableObject {
  let eventManager: EventManager
  @Published var categories: [EKCalendar]

  init(
    eventManager: EventManager
  ) {
    self.eventManager = eventManager
    self.categories = eventManager.getTaskCategories()
  }
}
