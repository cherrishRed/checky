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
  let calendar = Calendar.current
  
  func getPermission() {
    store.requestAccess(to: .reminder) { granted, error in
      guard error == nil else {
        print("에러가 있습니다")
        return
      }
      
      guard granted == true else {
        print("권한이 이상합니다")
        return
      }
    }
    
    store.requestAccess(to: .event) { granted, error in
      guard error == nil else {
        print("에러가 있습니다")
        return
      }
      
      guard granted == true else {
        print("권한이 이상합니다")
        return
      }
    }
  }
  
  func getAllEventforThisMonth(date: Date) -> [EKEvent] {
    let allDates = date.getAllDates()
    guard let firstDate = allDates.first, let lastDate = allDates.last else {
      return []
    }
    
    let predicate = store.predicateForEvents(withStart: firstDate, end: lastDate, calendars: [])
    
    let list = store.events(matching: predicate)
    
    return list
  }
}