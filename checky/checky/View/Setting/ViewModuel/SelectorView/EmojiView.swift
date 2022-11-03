//
//  EmojiView.swift
//  checky
//
//  Created by song on 2022/11/02.
//

import SwiftUI

struct EmojiView: View {
  @Binding var txt: String
  let calendarIdentifier: String
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 15) {
          ForEach(self.getEmojiList(), id: \.self) { i in
            HStack(spacing: 25) {
              ForEach(i, id: \.self) { j in
                Button(action: {
                  guard let unicode = UnicodeScalar(j) else {
                    return
                  }
                  self.txt = String(unicode)
                  UserDefaults.standard.set(txt, forKey: "\(calendarIdentifier)_imoji")
                },
                       label: {
                  if UnicodeScalar(j)?.properties.isEmoji != nil, let unicode = UnicodeScalar(j) {
                    Text(String(unicode))
                      .font(.system(size: 25))
                  } else {
                    Text("")
                  }
                })
              }
            }
          }
        }
        .padding(.top)
      }
      .frame(maxWidth: .infinity)
      .frame(height: UIScreen.main.bounds.height / 3)
      .background(Color.white)
      .cornerRadius(25)
    }
  }
  
  func getEmojiList() -> [[Int]] {
    var emoji: [[Int]] = []
    
    for i in stride(from: 0x1F601, to: 0x1F64F, by: 6)  {
      var temp: [Int] = []
      for j in i...i+5 {
        temp.append(j)
      }
      emoji.append(temp)
    }
    return emoji
  }
}
