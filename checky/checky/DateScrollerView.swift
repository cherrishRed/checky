//
//  DateScrollerView.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/03.
//

import SwiftUI

struct DateScrollerView: View {
  @EnvironmentObject var dateHolder: DateHolder

    var body: some View {

      HStack {
        Spacer()
        Button {
          previousMonth()
        } label: {
          Image(systemName: "arrow.left")
            .imageScale(.large)
            .font(Font.title.weight(.bold))
        }
        
        Text(CalendarHelper().monthYearString(dateHolder.date))
          .font(.title)
          .bold()
          .animation(.none)
          .frame(maxWidth: .infinity)
        
        Button {
          nextMonth()
        } label: {
          Image(systemName: "arrow.right")
            .imageScale(.large)
            .font(Font.title.weight(.bold))
        }
        
        Spacer()
      }
    }
  
  func previousMonth() {
    dateHolder.date = CalendarHelper().minusMonth(dateHolder.date)
  }
  
  func nextMonth() {
    dateHolder.date = CalendarHelper().plusMonth(dateHolder.date)
  }
}

struct DateScrollerView_Previews: PreviewProvider {
    static var previews: some View {
        DateScrollerView()
    }
}
