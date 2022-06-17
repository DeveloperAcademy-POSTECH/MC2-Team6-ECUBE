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
    @State var pointColor: Color = Color.deepGreen
    
    var body: some View {
     
            Button(
                action: {
                    withAnimation(.linear(duration: 0.4)) {
                        showPillPopUp.toggle()
                    }},
                label: {
                    HStack {
                        VStack {
                            ZStack {
                                
                                VStack(alignment: .center, spacing: 8) {
                                    VStack(alignment: .center, spacing: 4) {
                                        Image("medicine0"+String(Int.random(in: 0..<8)))
                                            .resizable()
                                            .scaledToFit()
                                            .padding(32)
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                        Text("\(pillList[indexOfCard].name)")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                        Text("\(pillList[indexOfCard].prescribedDate)")
                                            .font(.caption)
                                            .opacity(0.8)
                                        
                                        Text("\(pillList[indexOfCard].effect)")
                                    }
                                    .frame(maxHeight: .infinity)
                                    Divider()
                                    HStack(spacing: 4) {
                                        Image(systemName: "cross.fill")
                                        Text("\(pillList[indexOfCard].sender)약국")
                                            .fontWeight(.heavy)
                                            .font(.system(size: 18))
                                    }
                                    .padding()
                                    .foregroundColor(pointColor)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.bottom, 4)
                                } // VStack
                            } // ZStack
                            .foregroundColor(Color.bodyTextColor)
                            .frame(width: 250, height: 360, alignment: .center)
                            .overlay(LinearGradient(colors: [.white, .clear], startPoint: .leading, endPoint: .bottomTrailing).blendMode(.hardLight).opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .background(RoundedRectangle(cornerRadius: 10).fill(.thickMaterial).shadow(color: Color(uiColor: .systemGray5), radius: 5, x: 0, y: 2))
                        }
                    } // Button
                    .onAppear {
                        pointColor = (pillList[indexOfCard].sender) == "재헌" ? Color.deepGreen : Color.coralPink
                    }
                })
         // ZStack
    } // body
}

// struct PillPopUpView_Previews: PreviewProvider {
//    static var previews: some View {
//
//            PillPopUpView()
//        
//    }
// }
