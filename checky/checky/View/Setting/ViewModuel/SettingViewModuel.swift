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
  let geo: GeometryProxy
  var buttonAction: () -> ()
  
  var body: some View {
    Button(action: {
      buttonAction()
    }, label: {
      ZStack(alignment: .leading) {
        Rectangle()
          .fill(Color.white)
          .padding(.horizontal)
          .frame(width: geo.size.width, height: geo.size.height / 20)
        
        Text(buttonTitle)
          .frame(alignment: .leading)
          .padding(.horizontal, 20)
          .foregroundColor(Color.fontDarkBlack)
          .fontWeight(.semibold)
      }
    })
  }
}
