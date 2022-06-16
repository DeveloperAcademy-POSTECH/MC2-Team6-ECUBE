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
    @State private var isTapped: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            
            FlowerCardView(content: flowerList[Int.random(in: 0..<3)])
            
            VStack {
                // 메시지 카드
                ZStack {
                    
                    VStack(alignment: .center) {
                        
                        TextEditor(text: $input.value)
                            .foregroundColor(input.value.count < input.limit ? .black : .red)
                        
                        // MARK: placeholder 사라지게
                            .onTapGesture {
                                if input.value == input.placeholder {
                                    input.value = ""
                                    isitEntered = true
                                }
                            }
                        
                        Text("(\(isitEntered ? input.value.count : 0)/\(input.limit))")
                            .foregroundColor(input.value.count < input.limit ? .bodyTextColor : .red)
                            .fontWeight(input.value.count < input.limit ? .medium : .bold)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .foregroundColor(.bodyTextColor)
                            .opacity(0.6)
                        
                    } // VStack
                    .frame(maxWidth: UIScreen.main.bounds.width*0.8, maxHeight: UIScreen.main.bounds.width*0.4)
                    .padding()
                    
                } // ZStack
                .background(Image("letter_white").resizable().frame(width: 360, height: 240, alignment: .center))
                .padding(.top, 54)
                
            } // VStack
        } // VStack
        .navigationTitle("꽃")
        .navigationBarTitleDisplayMode(.inline)
        .background(.background)
        .navigationBarItems(trailing: Button {
            showAlertforSend = true
        } label: {
            Text("선물하기")
                .fontWeight(.bold)
                .alert(isPresented: $showAlertforSend) {
                    Alert(title: Text("선물 보내기"), message: Text("선물은 하루에 하나만 보낼 수 있어요. 사진을 보낼까요?"), primaryButton: .cancel(Text("취소")), secondaryButton: .default(Text("보내기")) {
                        isTapped.toggle()}
                    )
                }
        }.disabled(!input.inputEntered))
        
    } // body
}

// MARK: Flower Card
struct FlowerCardView: View {
    
    var content: Flower
    
    var body: some View {
        
        VStack {
            
            // 꽃 이름
            Text("\(content.name)")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.bottom, 2)
                .foregroundColor(.bodyTextColor)
            
            // 꽃 설명
            Text("\(content.meaning)")
                .font(.system(size: 12))
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
