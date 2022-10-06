//
//  CalendarGridView.swift
//  checky
//
//  Created by song on 2022/10/06.
//

import SwiftUI

struct DayOfWeekStackView: View {
  @ObservedObject var viewModel: DayOfWeekStackViewModel = DayOfWeekStackViewModel()
  
  var body: some View {
    HStack(spacing: 1) {
      ForEach(CalendarHelper().startingWeek.allWeeks(), id: \.rawValue) { week in
        if CalendarHelper().weekOption == WeekOption.KoreanShort {
          Text(week.koreanShort)
            .weekStyle()
        } else if CalendarHelper().weekOption == WeekOption.EnglishShort {
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
