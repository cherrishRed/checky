//
//  EventManager.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/04.
//

import Foundation
import EventKit

class EventManager {
  let store = EKEventStore()
  
  func getPermission() {
    store.requestAccess(to: .reminder) { granted, error in
      if granted == true {
        print("권한 얻기 성공")
      } else {
        print("에러 : \(String(describing: error?.localizedDescription))")
      }
    }
    store.requestAccess(to: .event) { granted, error in
      if granted == true {
        print("권한 얻기 성공")
      } else {
        print("에러 : \(String(describing: error?.localizedDescription))")
      }
    }
  }
}
