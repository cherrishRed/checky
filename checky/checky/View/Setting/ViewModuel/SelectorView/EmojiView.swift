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
  @State var firstUnicode: UInt32
  @State var lastUnicode: UInt32
  
  var body: some View {
    VStack {
      HStack {
        Button("첫번쨰이모지") {
          firstUnicode = 0x1F600
          lastUnicode = 0x1F64F
        }
        Button("두번쨰이모지") {
          firstUnicode = 0x1F300
          lastUnicode = 0x1F5FF
        }
        Button("세번쨰이모지") {
          firstUnicode = 0x1F680
          lastUnicode = 0x1F6FF
        }
        Button("네번쨰이모지") {
          firstUnicode = 0x2600
          lastUnicode = 0x26FF
        }
        Button("다섯번쨰이모지") {
          firstUnicode = 0x2700
          lastUnicode = 0x27BF
        }
        Button("여섯번쨰이모지") {
          firstUnicode = 0x1F912
          lastUnicode = 0x1F9FF
        }
        
      }
      ZStack(alignment: .topLeading)   {
        ScrollView(.vertical, showsIndicators: false) {
          VStack(spacing: 15) {
            
            ForEach(self.getEmojiList(firstUnicode, lastUnicode), id: \.self) { i in
              
              HStack(spacing: 25) {
                ForEach(i, id: \.self) { j in
                  Button(action: {
                    guard let unicode = UnicodeScalar(j) else {
                      return
                    }
                    self.txt = String(unicode)
                    UserDefaults.standard.set(txt, forKey: "\(calendarIdentifier)_emoji")
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
    
  }
  
  func getEmojiList(_ firstUnicode: UInt32, _ lastUnicode: UInt32) -> [[UInt32]] {
    var emoji: [[UInt32]] = []
    
    for i in stride(from: firstUnicode, to: lastUnicode , by: 6)  {
      var temp: [UInt32] = []
      for j in i...i+5 {
        temp.append(j)
      }
      emoji.append(temp)
    }
    return emoji
  }
}
