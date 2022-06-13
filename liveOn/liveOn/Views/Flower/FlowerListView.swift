//
//  FlowerListView.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/10.
//

import SwiftUI

struct FlowerListView: View {
    
    @State var flowerClicked: Bool = false
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        ZStack {
            
            // 꽃병
            Circle()
                .foregroundColor(.gray)
                .opacity(0.36)
                .padding()
            
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 42) {
                ForEach(0..<9, id: \.self) { _ in
                    ZStack {
                        Button {
                            flowerClicked.toggle()
                        } label: {
                            Image("flower")
                                .resizable()
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.width * 0.18)
                }
            }
            .padding()
            
            if flowerClicked {
                FlowerPopUpView(popUpBoolean: $flowerClicked)
            }
            
        } // ZStack
        .navigationTitle("꽃")
        .navigationBarTitleDisplayMode(.inline)
        .background(.background)
        
    } // body
}

struct FlowerListView_Previews: PreviewProvider {
    static var previews: some View {
        
        FlowerListView()
        
    }
}
