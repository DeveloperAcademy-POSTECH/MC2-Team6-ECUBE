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
            
            FlowerCardView(content: flowerList[Int.random(in: 0..<3)])
            
            VStack {
                // 메시지 카드
                ZStack {
                    
                    VStack(alignment: .center) {
                        
                        TextEditor(text: $input.value)
                            .foregroundColor(isitEntered ? .black : .gray)
                        // MARK: placeholder 사라지게
                            .onTapGesture {
                                if input.value == input.placeholder {
                                    input.value = ""
                                    isitEntered = true
                                }
                            }
                            .alert("쪽지는 \(input.limit)글자까지만 쓸 수 있어요.", isPresented: $input.hasReachedLimit) {
                                Button("확인", role: .cancel) {}
                            }
                        // TODO: 배경이 허옇게 나오는 것.. 해결하기..
                        
                        Text("(\(isitEntered ? input.value.count : 0)/\(input.limit))")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .foregroundColor(.bodyTextColor)
                            .opacity(0.6)
                            .padding(.trailing, 12)
                        
                    } // VStack
                    .frame(maxWidth: UIScreen.main.bounds.width*0.8, maxHeight: UIScreen.main.bounds.width*0.4)
                    .padding()
                    
                } // ZStack
                .background(.gray)
                .padding(.top, 24)

            } // VStack
        } // VStack
        .navigationTitle("꽃")
        .navigationBarTitleDisplayMode(.inline)
        .background(.background)
        .navigationBarItems(trailing: Button {
            showAlertforSend = true
        } label: {Text("선물하기").fontWeight(.bold)}.disabled(!input.inputEntered))
        
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
