//
//  checkyApp.swift
//  checky
//
//  Created by RED, Taeangel on 2022/09/30.
//

import SwiftUI

struct checkyApp: View {
  var body: some View {
      let dataHolder = DateHolder()
      let eventManager = EventManager()
      let calendarHelper = CalendarHelper()
      
      CalendarView(viewModel: CalendarViewModel(dateHolder: dataHolder, eventManager: eventManager, calendarHelper: calendarHelper))
  }
}
