//
//  EventCreateViewModel.swift
//  checky
//
//  Created by RED on 2022/10/13.
//

import Foundation

class EventCreateViewModel: ObservableObject {
  let eventMenuViewModel: EventMenuViewModel = EventMenuViewModel()
  
  func tappedOutOfButton() {
    eventMenuViewModel.closeAllPickers()
  }
  
  func tappedCreateButton() {
    eventMenuViewModel.createEvent()
  }
  
  func tappedCloseButton() {
    eventMenuViewModel.reset()
  }
}
