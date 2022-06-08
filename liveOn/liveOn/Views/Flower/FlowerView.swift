//
//  FlowerView.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/07.
//

import SwiftUI

// MARK: Property
let horizontalPaddingValue: CGFloat = 48

struct Flower: Hashable {
    let name: String
    let color: String
    let meaning: String
    let lastsfor: Int
}

let flowerList: [Flower] = [
    // Sample data
    Flower(
        name: "리시안셔스",
        color: "붉은색",
        meaning: "변치않는 사랑",
        lastsfor: 2),
    Flower(
        name: "금목서",
        color: "붉은색",
        meaning: "당신의 마음을 끌다",
        lastsfor: 8),
    Flower(
        name: "안개꽃",
        color: "노란색",
        meaning: "성공",
        lastsfor: 6)
]

struct FlowerView: View {
    var body: some View {
        VStack {
            
            FlowerHeaderView()
            FlowerBodyView()
            
        }
    }
}

// MARK: Flower Header
struct FlowerHeaderView: View {
    var body: some View {
        
        HStack(alignment: .top) {
            Text("<")
            
            Text("꽃")
                .font(.headline)
            
            Button("선물하기") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                // Submit 기능
            }
        } // HStack
    } // body
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
                    VStack {
                        TextField("짧은 메시지도 남겨볼까요?", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                            .border(.gray)
                            .padding(.horizontal, horizontalPaddingValue)
                        Text("(\(message.count)/40)")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.trailing)
                    }
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
                .padding(.top)
            
            // 꽃 설명
            Text("\(content.meaning)")
                .foregroundColor(.gray)
                .padding(.bottom)
            
            // 꽃 대신 잠깐 둥글려진 사각형
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.blue)
                .padding(.horizontal, 64)

                .padding(.bottom, 32)
                .frame(width: 280, height: 300, alignment: .center)
            
        } // VStack
    } // body
}

// MARK: FlowerView Preview
struct FlowerView_Previews: PreviewProvider {
    static var previews: some View {
        
        FlowerView()
        
    }
}
