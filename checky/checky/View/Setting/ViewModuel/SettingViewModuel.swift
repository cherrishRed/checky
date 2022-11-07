//
//  SettingViewModel.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI
import EventKit

struct SettingListCell: View {
  let buttonTitle: String
  var buttonAction: () -> ()
  
  var body: some View {
    Button(action: {
      buttonAction()
    }, label: {
      ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 4)
          .fill(Color.white)
          .cornerRadius(4)
        
        Text(buttonTitle)
          .foregroundColor(Color.fontDarkBlack)
          .fontWeight(.semibold)
          .padding(.horizontal, 20)
          .padding(.vertical, 10)
      }
      .fixedSize(horizontal: false, vertical: true)
    })
  }
}
