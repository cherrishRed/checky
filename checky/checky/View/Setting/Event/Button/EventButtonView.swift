//
//  EventButtonView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI
import EventKit

struct EventButtonView: View {
  @ObservedObject var viewModel: EventButtonViewModel
  
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
            Text(viewModel.imoji)
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
              .fill(viewModel.color)
              .frame(width: 15, height: 15)
            
          }
          .padding(.horizontal, 17)
        }
        Spacer()
        ColorView(color: $viewModel.color, calendarIdentifier: viewModel.category.calendarIdentifier)
        EmojiView(txt: $viewModel.imoji, calendarIdentifier: viewModel.category.calendarIdentifier)
        Spacer()
      }
      .padding(.horizontal, 15)
    }
    .onAppear {
      viewModel.imoji = UserDefaults.standard.string(forKey: ("\(viewModel.category.calendarIdentifier)_imoji")) ?? ""
      
      guard let colorComponent = UserDefaults.standard.object(forKey: ("\(viewModel.category.calendarIdentifier)_color")) as? [CGFloat] else {
        return
      }
      
      viewModel.color = Color(.sRGB, red: colorComponent[0], green: colorComponent[1], blue: colorComponent[2], opacity: colorComponent[3])
    }
    .background(Color.backgroundGray)
  }
}

