//
//  DailyCellView.swift
//  checky
//
//  Created by RED on 2022/10/29.
//

import SwiftUI

struct DailyCellView: View {
  @State var event: Event
  
  init(event: Event) {
    self.event = event
  }
  
    var body: some View {
      ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 6)
          .stroke(Color(event.category.cgColor))
          .background(Color.basicWhite)
          
        HStack {
          ZStack {
            RoundedRectangle(cornerRadius: 4)
              .fill(Color(event.category.cgColor))
              .frame(width: 40)
            Circle()
              .fill(Color.basicWhite)
              .frame(width: 30)
            Text("😗")
          }
          
          VStack(alignment: .leading) {
            Text(event.ekevent.title)
              .font(.title3)
              .fontWeight(.semibold)
            Text(event.ekevent.notes ?? "")
          }
          .padding(.horizontal, 10)
          .padding(.vertical, 6)
        }
      }
      .fixedSize(horizontal: false, vertical: true)
    }
}
