//
//  FlowerPopUpView.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/13.
//

import SwiftUI

struct FlowerPopUpViewTest: View {
    
    @State var showPopUp: Bool = false
    
    var body: some View {
        ZStack {
            Button(
                action: {
                    withAnimation(.linear(duration: 0.2)) {
                        showPopUp.toggle()
                    }},
                label: {
                    Text("POPUP")
                })
            
            if showPopUp {
                FlowerPopUpView(popUpBoolean: $showPopUp)
            }
        }
        .background(.background)
    } // body
}

struct FlowerPopUpView: View {
    
    @Binding var popUpBoolean: Bool
    
    var body: some View {
        ZStack {
            
            Color.white.opacity(popUpBoolean ? 0.88 : 0).edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                Button {
                    withAnimation(.linear(duration: 0.24)) {
                        popUpBoolean = false
                    }
                } label: {
                    Text("Dismiss")
                }
                
                VStack {
                    ZStack {
                            
                        VStack {
                            FlowerCardView(content: flowerList[0])
                                .padding()
                            ZStack {
                                RoundedRectangle(cornerRadius: 4)
                                    .foregroundColor(.white)
                                    .shadow(color: .gray, radius: 2, x: 2, y: 2)
                                    .frame(height: 128, alignment: .center)
                                VStack {
                                    Text("엄지 손가락으로 장미 꽃을 피워")
                                        .foregroundColor(.bodyTextColor)
                                                                        
                                    Text("20220613")
                                        .foregroundColor(.bodyTextColor)
                                        .padding(.top, 8)
                                    
                                } // VStack
                            } // ZStack
                        } // VStack
                    } // VStack
                    .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.64, alignment: .center)
                    
                } // VStack
            } // VStack
        } // ZStack
    } // body
}

struct FlowerPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        
        FlowerPopUpViewTest()
        
    }
}
