//
//  EventCreateView.swift
//  checky
//
//  Created by RED on 2022/10/11.
//

import SwiftUI

struct EventCreateView: View {
    var body: some View {
        VStack {
            headerView
        }
        
    }
    
    var headerView: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.red)
                    .padding()
            }

            Text("새로운 이벤트 추가")
                .font(.title2)
                .frame(maxWidth: .infinity)
            
            Button {
                
            } label: {
                Image(systemName: "checkmark")
                    .foregroundColor(.green)
                    .padding()
            }
        }
    }
}

struct EventCreateView_Previews: PreviewProvider {
    static var previews: some View {
        EventCreateView()
    }
}
