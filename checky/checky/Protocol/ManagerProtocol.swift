//
//  ManagerProtocol.swift
//  checky
//
//  Created by song on 2022/10/27.
//

import Foundation
import EventKit

// EventManager Event
// reminderManager Reminder

protocol ManagerProtocol {
  var store: EKEventStore { get set }
  var calendar: Calendar { get set }
  
  associatedtype ManagerError: Error
  
  func getPermission()
  func filterTask(_ target: [CheckyEventkitRepositoryProtocol], _ date: Date) -> [CheckyEventkitRepositoryProtocol]
  func getAllTaskforThisMonth(date: Date, completionHandler: @escaping ([CheckyEventkitRepositoryProtocol]) -> Void)
  func createNewTask(newTask: EKCalendarItem) -> Result<String, ManagerError>
  func getTaskCategories() -> [EKCalendar]
  func editTask(task: EKCalendarItem) -> Result<Bool, ManagerError>
  func deleteTask(task: EKCalendarItem) -> Result<String, ManagerError>
}

protocol CheckyEventkitRepositoryProtocol {
  var ek: EKCalendarItem { get set }
}
