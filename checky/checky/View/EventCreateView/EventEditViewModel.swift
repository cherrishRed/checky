//
//  EventEditViewModel.swift
//  checky
//
//  Created by RED on 2022/10/13.
//

import Foundation

class EventEditViewModel: ObservableObject {
  let eventMenuViewModel: EventMenuViewModel = EventMenuViewModel()
  
  func tappedOutOfButton() {
    eventMenuViewModel.closeAllPickers()
  }
  
  func tappedEditButton() {
    //
  }
  
  func tappedCloseButton() {
    eventMenuViewModel.reset()
  }
}
