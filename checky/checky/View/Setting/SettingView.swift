//
//  SettingView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI

struct SettingView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  
  var body: some View {
    GeometryReader { geo in
      VStack {
        ButtonView(buttonTitle: "캘린더 카테고리 수정", geo: geo) {
          coordinator.show(.EventSetting)
        }
        
        ButtonView(buttonTitle: "미리알림 카테고리 수정", geo: geo) {
          coordinator.show(.ReminderSetting)
        }
      }
    }
    .background(Color.backgroundGray)
  }
}

struct ButtonView: View {
  let buttonTitle: String
  let geo: GeometryProxy
  var buttonAction: () -> ()
  
  var body: some View {
    Button(action: {
      buttonAction()
    }, label: {
      ZStack {
        Rectangle()
          .fill(Color.white)
          .padding(.horizontal)
          .frame(width: geo.size.width, height: geo.size.height / 20)
        
        Text(buttonTitle)
          .frame(alignment: .leading)
          .foregroundColor(Color.fontDarkBlack)
          .fontWeight(.semibold)
      }
    })
  }
}

struct SettingView_Previews: PreviewProvider {
  static var previews: some View {
    SettingView()
  }
}
