//
//  DailyHeaderView.swift
//  checky
//
//  Created by RED on 2022/11/02.
//

import SwiftUI

struct DailyHeaderView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  @State var date: Date
  let calendarHelper = WeeklyCalendarHelper()
    
    var body: some View {
      ZStack(alignment: .leading) {
        Text(displayMonth)
            .font(.title)
            .bold()
            .foregroundColor(Color.fontBlack)
            .frame(maxWidth: .infinity)
        
        Button {
          coordinator.pop()
        } label: {
          Image(systemName: "chevron.backward")
            .foregroundColor(Color.fontBlack)
            .padding(.horizontal)
        }
      }
      .background(Color.basicWhite)
    }
  
  var displayMonth: String {
    return calendarHelper.monthYearDayString(date)
  }
}
