//
//  FlowerListView.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/10.
//

import SwiftUI

struct FlowerListView: View {
    @Environment(\.dismiss) private var dismiss
    @State var showFlowerPopUp = false
    @State var clickedFlowerIndex = 0
    
    let columns : [GridItem] = [
        GridItem(.flexible(), spacing: -10, alignment: .bottom),
        GridItem(.flexible(), spacing: 20, alignment: .top)
    ]
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Text("꽃을 눌러 상세 정보를 확인할 수 있어요")
                    .foregroundColor(.bodyTextColor)
                    .padding(.top, 96)
                    .opacity(0.8)
                
                ZStack(alignment: .center) {
                    // 꽃병
                    Image("backgroundForVase")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(color: Color.shadowColor, radius: 2, x: 0, y: 0)
                        .padding(24)
                    Circle().fill(.white).frame(width: 160, height: 160, alignment: .center)
                    
                    Circle()
                        .fill(.regularMaterial)
                        .padding()
                        .overlay(Circle().fill(.gray).frame(width: 100, height: 100, alignment: .center).opacity(0.9))
                    
                  
                    
                    LazyVGrid(columns: columns, spacing: -40) {
                        ForEach(0..<flowerList.count, id: \.self) { index in
                            FlowerPopUp(content: flowerList[index])
                                .onTapGesture {withAnimation(.linear(duration: 0.5)) {
                                    showFlowerPopUp = true
                                    clickedFlowerIndex = index
                                }
                                }
                        }
                    }
                    .padding()
                    
                } // ZStack
                
                Text("이전에 받은 꽃은\n달력에서 확인할 수 있어요.")
                    .foregroundColor(Color(uiColor: .systemGray2))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 32)
                
            } // VStack
            .blur(radius: showFlowerPopUp ? 6 : 0)
            Color(uiColor: .systemBackground).opacity(showFlowerPopUp ? 0.8 : 0)
            
            if showFlowerPopUp {
                FlowerPopUpView(popUpBoolean: $showFlowerPopUp, indexOfCard: $clickedFlowerIndex)
            }
        } // ZStack
       
        
        .navigationToBack(dismiss)
        .navigationTitle("꽃")
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.background)
        
    } // body
}

struct FlowerListView_Previews: PreviewProvider {
    static var previews: some View {
        
        FlowerListView()
        
    }
}

extension FlowerListView {
    struct FlowerPopUp: View {
        let content : Flower
        var body: some View {
            Image(content.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
        }
    }
}
