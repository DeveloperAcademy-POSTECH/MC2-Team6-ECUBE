//
//  FlowerPopUpView.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/13.
//

import SwiftUI

struct FlowerPopUpView: View {
    
    @State var showPopUp: Bool = false
    
    var body: some View {
        ZStack{
            Button(
                action: {
                    withAnimation(.linear(duration: 0.3)) {
                        showPopUp.toggle()
                    }},
                label: {
                    Text("POPUP")
                })
            
            if showPopUp {
                PopUpView(popUpBoolean: $showPopUp)
            }
        }
        .background(.background)
    } // body
}

struct PopUpView: View {
    
    @Binding var popUpBoolean: Bool
    
    var body: some View {
        ZStack {
            
            Color.white.opacity(popUpBoolean ? 0.3 : 0).edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                Button {
                    withAnimation(.linear(duration: 0.3)) {
                        popUpBoolean = false
                    }
                } label: {
                    Text("Dismiss")
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke()
                        .background(Color.white)
                    
                    FlowerCardView(content: flowerList[0])
                        .padding()
                    
                } // VStack
                .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.64, alignment: .center)
                
            } // VStack
        } // ZStack
    } // body
}

struct FlowerPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        
        FlowerPopUpView()
        
    }
}
