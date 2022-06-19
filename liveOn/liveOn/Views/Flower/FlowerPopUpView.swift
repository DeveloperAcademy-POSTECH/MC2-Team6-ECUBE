//
//  FlowerPopUpView.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/13.
//

import SwiftUI

struct FlowerPopUpView: View {
    @Binding var popUpBoolean: Bool
    @Binding var indexOfCard: Int
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Button {
                    withAnimation(.linear(duration: 0.24)) {
                        popUpBoolean.toggle()
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(flowerList[indexOfCard].imageName)
                            .resizable()
                            .padding()
                            .frame(width: 300, height: 300, alignment: .center)
                        
                        Text(flowerList[indexOfCard].name)
                            .font(.title3)
                            .foregroundColor(.bodyTextColor)
                            .fontWeight(.bold)
                        Text(flowerList[indexOfCard].meaning)
                            .font(.subheadline)
                            .foregroundColor(.bodyTextColor)
                            .opacity(0.9)
                        
                        // 쪽지
                        VStack(alignment: .center, spacing: 4) {
                            Text(flowerList[indexOfCard].message)
                                .setHandWritten()
                                .frame(maxWidth:.infinity)
                                .padding()
                            Text("20220613")
                                .setHandWritten()
                                .font(.callout)
                        }
                        .frame(width: 280, height: 240, alignment: .center)
                        .foregroundColor(.bodyTextColor)
                        .background(
                            Image("letter_yellow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: .infinity))
                        
                    } // VStack
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } // VStack
            } // VStack
        } // ZStack
    } // body
}
//
// struct FlowerPopUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        FlowerPopUpViewTest()
//        
//    }
// }
