//
//  DailyCellView.swift
//  checky
//
//  Created by RED on 2022/10/29.
//

import SwiftUI

struct DailyCellView: View {
    var body: some View {
      ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 6)
          .stroke(Color.pointRed)
          .background(Color.basicWhite)
          
        HStack {
          ZStack {
            RoundedRectangle(cornerRadius: 4)
              .fill(Color.pointRed)
              .frame(width: 40)
            Circle()
              .fill(Color.basicWhite)
              .frame(width: 30)
            Text("😗")
          }
          
          VStack(alignment: .leading) {
            Text("태엔젤 생일")
              .font(.title3)
              .fontWeight(.semibold)
            Text("설명충 어쩌구 저쩌구 ")
          }
          .padding(.horizontal, 10)
          .padding(.vertical, 6)
        }
      }
      .fixedSize(horizontal: false, vertical: true)
    }
}

struct DailyCellView_Previews: PreviewProvider {
    static var previews: some View {
        DailyCellView()
    }
}
