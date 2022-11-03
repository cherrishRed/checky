//
//  SettingViewModel.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import Foundation
import SwiftUI
import EventKit

struct SettingButtonView: View {
  let category: EKCalendar
  let buttonAction: () -> ()
  
  var body: some View {
    Button(action: {
      buttonAction()
    }, label: {
      ZStack {
        Rectangle()
          .fill(Color.white)
          .frame(height: 30)
          .frame(maxWidth: .infinity)

        HStack {
          Text(category.title)
            .foregroundColor(Color.fontDarkBlack)
            .font(.title3)
          
          Spacer()
          
          Rectangle()
            .fill(fetchUserDefaultColor(calendarIdentifier: category.calendarIdentifier))
            .frame(width: 10, height: 10)
        }
        .padding(.horizontal)
      }
    })
  }
}

struct SettingView: View {
  
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
        EmojiView(txt: $emoji, calendarIdentifier: calendarIdentifier)
        Spacer()
      }
      .padding(.horizontal, 15)
    }
    
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
