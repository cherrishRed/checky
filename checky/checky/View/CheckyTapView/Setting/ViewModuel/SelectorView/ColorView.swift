//
//  ColorView.swift
//  checky
//
//  Created by song on 2022/11/02.
//

import SwiftUI

struct ColorView: View {
  @Binding var color: Color
  let calendarIdentifier: String
  let colorList: [Color] = [
    Color.basicRed,
    Color.basicOrange,
    Color.basicYellow,
    Color.basicLightGreen,
    Color.basicGreen,
    Color.basicSkyblue,
    Color.basicLightIndigo,
    Color.basicIndigo,
    Color.basicPink,
    Color.basicPurple
  ]
  
  let columns = Array(repeating: GridItem(.flexible(), spacing: 20, alignment: nil), count: 5)
  
  var body: some View {
    
    LazyVGrid(columns: columns, spacing: 30) {
      ForEach(colorList, id: \.self) { color in
        Button(action: {
          self.color = color
          UserDefaults.standard.set(UIColor(color).cgColor.components, forKey: "\(calendarIdentifier)_color")
        }, label: {
          RoundedRectangle(cornerRadius: 10)
            .fill(color)
            .frame(width: 40, height: 40)
        })
      }
    }
    .padding(.horizontal, 20)
    .frame(height: UIScreen.main.bounds.height / 5)
    .background(Color.basicWhite)
    .cornerRadius(25)
  }
}
