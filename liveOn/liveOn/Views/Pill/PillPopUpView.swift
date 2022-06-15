//
//  PillPopUpView.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/15.
//

import SwiftUI

struct PillPopUpView: View {
    
    @Binding var showPillPopUp: Bool
    @Binding var indexOfCard: Int
    
    var body: some View {
        
        ZStack {
            
            Button(
                action: {
                    withAnimation(.linear(duration: 0.4)) {
                        showPillPopUp.toggle()
                    }},
                label: {
                    
                    VStack {
                        
                        Text("Click to Dismiss")
                            .foregroundColor(.gray)
                            .opacity(0.8)
                            .padding(.bottom, 12)
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.white)
                            
                            RoundedRectangle(cornerRadius: 8)
                                .stroke()
                                .foregroundColor(.green)
                                .opacity(0.6)
                            
                            VStack {
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke()
                                        .frame(width: CGFloat(pillList[indexOfCard].name.count) * 16 + 8, height: 24, alignment: .center)
                                        .foregroundColor(.green)
                                    
                                    Text("\(pillList[indexOfCard].name)")
                                        .foregroundColor(.green)
                                }
                                .padding(.top)
                                
                                Text("\(pillList[indexOfCard].prescribedDate)")
                                    .font(.system(size: 12))
                                
                                Image("medicine")
                                    .scaledToFit()
                                
                                Text("\(pillList[indexOfCard].effect)")
                                    .padding(8)
                                    .padding(.horizontal, 8)
                                
                                Divider()
                                
                                Text("\(pillList[indexOfCard].sender)약국")
                                    .fontWeight(.heavy)
                                    .font(.system(size: 18))
                                    .frame(height: 18)
                                    .padding()
                                
                            } // VStack
                            .frame(width: 220)
                            .foregroundColor(.green)
                            
                        } // ZStack
                        .frame(width: 212, height: 360, alignment: .center)
                        
                    } // Button
                })
        } // ZStack
    } // body
}
