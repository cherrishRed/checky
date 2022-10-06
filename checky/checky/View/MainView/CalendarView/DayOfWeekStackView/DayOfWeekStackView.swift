//
//  CalendarGridView.swift
//  checky
//
//  Created by song on 2022/10/06.
//

import SwiftUI

struct DayOfWeekStackView: View {
  @ObservedObject var viewModel: DayOfWeekStackViewModel
  
  
  var body: some View {
    HStack(spacing: 1) {
      ForEach(viewModel.calendarHelper.startingWeek.allWeeks(), id: \.rawValue) { week in
        if viewModel.calendarHelper.weekOption == WeekOption.KoreanShort {
          Text(week.koreanShort)
            .weekStyle()
        } else if viewModel.calendarHelper.weekOption == WeekOption.EnglishShort {
          Text(week.short)
            .weekStyle()
        } else {
          Text("\(week.rawValue)")
            .weekStyle()
        }
      }
    }
  }
}