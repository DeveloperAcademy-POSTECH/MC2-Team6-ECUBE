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
                                .padding(.bottom, 120)
                            
                            ZStack {
                                
                                VStack {
                                    Text("뭔가 제법 로맨틱한 멘트")
                                        .foregroundColor(.bodyTextColor)
                                    
                                    Text("20220613")
                                        .foregroundColor(.bodyTextColor)
                                        .font(.system(size: 12))
                                        .opacity(0.7)
                                        .padding(.top, 8)
                                    
                                } // VStack
                                .background(
                                    Image("letterImage_lavender")
                                        .scaledToFit()
                                        .padding()
                                        .frame(width: 240, height: 180, alignment: .center))
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
