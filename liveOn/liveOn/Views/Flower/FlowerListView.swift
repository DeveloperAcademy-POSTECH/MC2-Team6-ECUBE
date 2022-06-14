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
            VStack {
                Spacer()
                
                Text("꽃을 눌러 상세 정보를 확인할 수 있어요")
                    .foregroundColor(.bodyTextColor)
                    .padding(.top, 96)
                    .opacity(0.8)
                
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
                    
                } // ZStack
                .navigationTitle("꽃")
                .navigationBarTitleDisplayMode(.inline)
                .background(.background)
                
                Text("이전에 받은 꽃은\n달력에서 확인할 수 있어요.")
                    .foregroundColor(Color(uiColor: .systemGray2))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 32)
                                    
            } // VStack
            
            if flowerClicked {
                FlowerPopUpView(popUpBoolean: $flowerClicked)
                
            }
        } // ZStack
        .navigationTitle("꽃다발")
        .navigationBarTitleDisplayMode(.inline)
        .background(.background)
        
    } // body
}

struct FlowerListView_Previews: PreviewProvider {
    static var previews: some View {
        
        FlowerListView()
        
    }
}
