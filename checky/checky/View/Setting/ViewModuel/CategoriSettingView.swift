//
//  CategoriSettingView.swift
//  checky
//
//  Created by song on 2022/11/03.
//

import SwiftUI
import EventKit

struct CategoriSettingView: View {
  @Binding var emoji: String
  @Binding var color: Color
  let calendarIdentifier: String
  var body: some View {
    
    HStack {
      VStack(spacing: 30) {
        ZStack {
          Rectangle()
            .fill(Color.white)
            .frame(height: 30)
            .frame(maxWidth: .infinity)
          
          HStack {
            Text("이모지")
            Spacer()
            Text(emoji)
          }
          .padding(.horizontal, 15)
        }
        
        ZStack {
          Rectangle()
            .fill(Color.white)
            .frame(height: 30)
            .frame(maxWidth: .infinity)
          
          HStack {
            Text("색상")
            Spacer()
            
            Rectangle()
              .fill(color)
              .frame(width: 15, height: 15)
            
          }
          .padding(.horizontal, 17)
        }
        Spacer()
        ColorView(color: $color, calendarIdentifier: calendarIdentifier)
        EmojiView(txt: $emoji, calendarIdentifier: calendarIdentifier, firstUnicode: 0x1F600, lastUnicode: 0x1F64F)
        Spacer()
      }
      .padding(.horizontal, 15)
    }
    
  }
}
