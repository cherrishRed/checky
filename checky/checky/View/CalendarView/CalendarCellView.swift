//
//  CalendarCellView.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/05.
//

import SwiftUI

struct CalendarCellView: View {
  @State var dateValue: DateValue
  @State var allEvnets: [Event] = []
  
    var body: some View {
      ZStack(alignment: .top) {
        Rectangle()
          .fill(.white)
          .border(.gray)
        VStack {
          Text(dateValue.date.day)
            .foregroundColor(dateValue.isCurrentMonth ? .black : .gray)
          ForEach(allEvnets, id: \.self) { event in
            Text(event.ekevent.title)
              .lineLimit(1)
              .font(.caption)
              .foregroundColor(.white)
              .background(Color(event.category.cgColor))
              .cornerRadius(2)
              .frame(maxWidth: .infinity)
        }
        }
      }
    }
}
