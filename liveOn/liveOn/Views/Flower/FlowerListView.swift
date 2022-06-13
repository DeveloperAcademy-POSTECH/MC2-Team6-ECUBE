//
//  FlowerListView.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/10.
//

import SwiftUI

struct FlowerListView: View {
    
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
                        Image("flower")
                            .resizable()
                            .onTapGesture {
                                ShowFlowerCardPopUp(clickedFlower: flowerList[0])
                            }
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.width * 0.18)
                }
            }
            .padding()
            
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

 func ShowFlowerCardPopUp(clickedFlower: Flower) {
    
    // Blur the background behind flower card
    // Show Flower card on top of the FlowerListView
    FlowerCardView(content: clickedFlower)
    
 }
