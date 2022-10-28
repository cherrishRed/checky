//
//  DailyView.swift
//  checky
//
//  Created by RED on 2022/10/29.
//

import SwiftUI

struct DailyView: View {
  var body: some View {
    VStack {
      HeaderView(viewModel: HeaderViewModel(dateHolder: DateHolder(), calendarHelper: WeeklyCalendarHelper()))
      VStack {
        
        ZStack(alignment: .leading) {
          RoundedRectangle(cornerRadius: 6)
            .stroke(Color.pointRed)
            .background(Color.basicWhite)
            
          HStack {
            ZStack {
              RoundedRectangle(cornerRadius: 4)
                .fill(Color.pointRed)
                .frame(width: 40)
              Circle()
                .fill(Color.basicWhite)
                .frame(width: 30)
              Text("😗")
            }
            
            VStack(alignment: .leading) {
              Text("태엔젤 생일")
                .font(.title3)
                .fontWeight(.semibold)
              Text("설명충 어쩌구 저쩌구 ")
            }
            .padding()
          }
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding()
        
      }
    }
    .background(Color.backgroundGray)
  }
}

struct DailyView_Previews: PreviewProvider {
  static var previews: some View {
    DailyView()
  }
}
