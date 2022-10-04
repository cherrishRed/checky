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
 
        Text(CalendarHelper().monthYearString(dateHolder.date))
          .font(.title)
          .bold()
          .animation(.none)
          .frame(maxWidth: .infinity)
        
        Spacer()
      }
    }
}

struct DateScrollerView_Previews: PreviewProvider {
    static var previews: some View {
        DateScrollerView()
    }
}
