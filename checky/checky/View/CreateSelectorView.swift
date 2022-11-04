//
//  CreateSelectorView.swift
//  checky
//
//  Created by RED on 2022/10/26.
//

import SwiftUI

struct CreateSelectorView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  var body: some View {
    ZStack(alignment: .topLeading) {
      Rectangle()
        .fill(Color.backgroundGray)
        .ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 20) {
        
        Button {
          coordinator.dismiss()
          coordinator.show(.createEvent)
        } label: {
          HStack {
            Image(systemName: "rectangle.fill")
              .resizable()
              .frame(width: 22, height: 14)
              .padding(.horizontal, 1)
              .foregroundColor(.pointRed)
            Text("이벤트 추가")
          }
        }
        .buttonStyle(CreateButtonStyle())
        
        Button {
          coordinator.dismiss()
          coordinator.show(.createReminder)
        } label: {
          HStack {
            ZStack {
              Image(systemName: "circle")
                .resizable()
                .frame(width: 20, height: 20)
              Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 10, height: 10)
            }
            .frame(width: 24, height: 20)
            .foregroundColor(.pointRed)
            
            Text("미리알림 추가")
          }
        }
        .buttonStyle(CreateButtonStyle())
      }
      .padding(.vertical, 40)
      .padding(.horizontal, 30)
    }
  }
}
