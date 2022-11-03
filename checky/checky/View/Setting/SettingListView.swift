//
//  SettingView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI

struct SettingListView: View {
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

