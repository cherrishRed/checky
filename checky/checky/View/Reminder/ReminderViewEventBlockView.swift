//
//  ReminderViewEventBlockView.swift
//  checky
//
//  Created by RED on 2022/11/08.
//

import SwiftUI

struct ReminderViewEventBlockView: View {
  let event: Event

  var body: some View {
    ZStack(alignment: .leading) {
      RoundedRectangle(cornerRadius: 4)
        .fill(color)
        .frame(maxWidth: .infinity)
        .layoutPriority(1)

      Text(event.ekevent.title)
        .lineLimit(1)
        .font(.caption)
        .fontWeight(.semibold)
        .foregroundColor(Color.basicWhite)
        .fixedSize(horizontal: true, vertical: false)
        .padding(.horizontal, 4)
    }
  }

  var color: Color {
    let userColor = fetchUserDefaultColor(calendarIdentifier: event.category.calendarIdentifier)

    if userColor == Color.white {
      return Color(event.category.cgColor)
    } else {
      return fetchUserDefaultColor(calendarIdentifier: event.category.calendarIdentifier)
    }
  }
}
