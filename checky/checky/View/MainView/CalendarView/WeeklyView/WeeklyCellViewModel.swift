//
//  WeeklyCellViewModel.swift
//  checky
//
//  Created by song on 2022/10/17.
//

import Foundation

class WeeklyCellViewModel: ObservableObject {
  @Published var dateValue: DateValue
  @Published var allEvnets: [Event] = []
  @Published var allReminders: [Reminder] = []
  
  init(
    dateValue: DateValue,
    allEvnets: [Event] = [],
    allReminders: [Reminder] = []
  ) {
    self.dateValue = dateValue
    self.allEvnets = allEvnets
    self.allReminders = allReminders
  }
}
