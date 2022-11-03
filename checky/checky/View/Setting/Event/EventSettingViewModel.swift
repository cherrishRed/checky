//
//  EventSettingViewModel.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import Foundation
import EventKit
import SwiftUI
import Combine

class EventSettingViewModel: ObservableObject {
  let eventManager: EventManager
  @Published var categories: [EKCalendar]
  @Published var color: Color = .white

  init(
    eventManager: EventManager
  ) {
    self.eventManager = eventManager
    self.categories = eventManager.getTaskCategories()
  }
}
