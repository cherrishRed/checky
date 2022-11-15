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
  
  associatedtype Task
  associatedtype ManagerError: Error
  
  func getPermission()
  func filterTask(_ taget: [Task], _ date: Date) -> [Task]
  func getAllTaskforThisMonth(date: Date, completionHandler: @escaping ([Task]) -> Void)
  func createNewTask(newTask: EKCalendarItem) -> Result<String, ManagerError>
  func getTaskCategories() -> [EKCalendar]
}

