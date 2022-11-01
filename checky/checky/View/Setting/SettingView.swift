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
    
    VStack {
      Button(action: {
        coordinator.show(.EventSetting)
      }, label: {
        Text("이벤트 세팅")
      })
      
      Button(action: {
        coordinator.show(.ReminderSetting)
      }, label: {
        Text("리마인더 세팅")
      })
    }
  }
}

struct SettingView_Previews: PreviewProvider {
  static var previews: some View {
    SettingView()
  }
}
