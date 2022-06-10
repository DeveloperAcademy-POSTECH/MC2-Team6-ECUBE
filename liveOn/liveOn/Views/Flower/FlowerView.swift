//
//  FlowerView.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/07.
//

import SwiftUI

// Values for UI Adjustment
let horizontalPaddingValue: CGFloat = 48

struct FlowerView: View {
    
    // MARK: Property
    @ObservedObject var input =  TextLimiter(limit: 40, placeholder: "짧은 메시지도 남겨볼까요?")
    @State var showAlertforSend: Bool = false
    @State var isitEntered: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            FlowerBodyView()
            
        }
        .navigationTitle("꽃")
        .navigationBarTitleDisplayMode(.inline)
        .background(.background)
        .navigationBarItems(trailing: Button {
            showAlertforSend = true
        } label: {Text("선물하기").fontWeight(.bold)}.disabled(!input.inputEntered))
    }
}

// MARK: Flower Body
struct FlowerBodyView: View {
    
    var message: String = ""
    
    var body: some View {
        
        VStack {
            
            FlowerCardView(content: flowerList[Int.random(in: 0..<3)])
            
            VStack {
                // 메시지 카드
                ZStack {
                    // 메시지 이미지 대신 잠시 둥글린 사각형
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 24)
                        .frame(height: 240)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.background)
                            .frame(width: 360, height: 150, alignment: .center)
                        
                        VStack(alignment: .center) {
                            TextField("짧은 메시지도 남겨볼까요?", text: .constant(""))
                                .padding(.horizontal, horizontalPaddingValue)
                                .frame(width: 300, height: 80, alignment: .center)
                            Text("(\(message.count)/40)")
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                                .frame(width: 360, height: 20, alignment: .trailing)
                                .padding(.trailing, 36)
                            
                        } // VStack
                    } // ZStack
                } // ZStack
            } // VStack
        } // VStack
    } // body
}

// MARK: Flower Card
struct FlowerCardView: View {
    
    var content: Flower
    
    var body: some View {
        
        VStack {
            
            // 꽃 이름
            Text("\(content.name)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 2)
                .foregroundColor(.bodyTextColor)
            
            // 꽃 설명
            Text("\(content.meaning)")
                .foregroundColor(.gray)
            
            // 꽃
            Image("flower")
                .resizable()
                .frame(width: 280, height: 168, alignment: .center)
                .padding(.top, 42)

            
        } // VStack
    } // body
}

// MARK: FlowerView Preview
struct FlowerView_Previews: PreviewProvider {
    static var previews: some View {
        
        FlowerView()
        
    }
}
