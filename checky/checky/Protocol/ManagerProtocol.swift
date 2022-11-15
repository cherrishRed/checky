//
//  ManagerProtocol.swift
//  checky
//
//  Created by song on 2022/10/27.
//

import Foundation
import EventKit

protocol ManagerProtocol {
  var store: EKEventStore { get set }
  var calendar: Calendar { get set }
  
  associatedtype task
  
  func getPermission()
  func filterTask(_ taget: [task], _ date: Date) -> [task]
  func getAllTaskforThisMonth(date: Date, completionHandler: @escaping ([task]) -> Void)
  func createNewTask(newTask: EKCalendarItem) -> String
  func getTaskCategories() -> [EKCalendar]
}
