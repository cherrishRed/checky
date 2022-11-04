//
//  DailyHeaderView.swift
//  checky
//
//  Created by RED on 2022/11/02.
//

import SwiftUI

struct DailyHeaderView: View {
  @State var date: Date
  let calendarHelper = WeeklyCalendarHelper()
    
    var body: some View {
        Text(displayMonth)
            .font(.title)
            .bold()
            .foregroundColor(Color.fontBlack)
            .animation(.none)
            .frame(maxWidth: .infinity)
            .background(Color.basicWhite)
            .padding(.top)
    }
  
  var displayMonth: String {
    return calendarHelper.monthYearDayString(date)
  }
}
