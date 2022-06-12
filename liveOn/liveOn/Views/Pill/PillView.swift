//
//  PillView.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/07.
//

import SwiftUI

struct PillView: View {
    
    // MARK: Property
    @ObservedObject var input =  TextLimiter(limit: 40, placeholder: "짧은 메시지도 남겨볼까요?")
    @State var showAlertforSend: Bool = false
    @State var isitEntered: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            
            PillBodyView()
            
        } // VStack
        .navigationTitle("영양제")
        .navigationBarTitleDisplayMode(.inline)
        .background(.background)
        .navigationBarItems(trailing: Button {
            showAlertforSend = true
        } label: {
            Text("보내기")
                .fontWeight(.bold)
        }
            .disabled(!input.inputEntered))
        .padding(.horizontal, 32)
    } // body
}

struct PillBodyView: View {
    
    // MARK: Property
    @State private var pillImageCounter: Int = 0
    @State private var pillName: String = ""
    @State private var pillEffect: String = ""
    @State private var isShowingPopover = true
    
    var body: some View {
        
        // Sample data
        let pillColorList: [Color] = [.yellow, .background, .green, .orange]
        
        ZStack {
            // 약 이미지 들어갈 곳을 잠시 둥글려진 사각형이 차지
            RoundedRectangle(cornerRadius: 24)
                .frame(width: 280, height: 280, alignment: .center)
                .foregroundColor(pillColorList[pillImageCounter])
                .onTapGesture {
                    
                    isShowingPopover = false
                    
                    if pillImageCounter < 3 {
                        pillImageCounter += 1
                    } else {
                        pillImageCounter = 0
                    }
                    
                }
            
            Image("medicine")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
        }
        .padding(.vertical, 36)
        
        VStack {
            if (isShowingPopover) {
                ZStack(alignment: .center) {
                    
                    // 임시입니다... 말풍선
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 180, height: 40, alignment: .center)
                        .foregroundColor(Color(uiColor: .systemGray4))
                    
                    // 이 또한 임시입니다
                    // 더 나은 방법이 있겠지요..
                    Text("⬆️ 탭해서 다른 약으로 바꾸기 ⬆️")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                    
                }
            } // if
        } // ZStack
        .padding(.bottom, 24)
        
        Group {
            TextField("어떤 약인가요?", text: $pillName)
                .multilineTextAlignment(.center)
                .font(.system(size: 16))
                .padding(.vertical, 12)
            
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 32)
                .background(pillName.count < 12 ? .gray : .red)
                .padding(.bottom, -24)
            
            // Message string counter
            Text("(\(pillName.count)/12)")
                .font(.system(size: 12))
                .foregroundColor(pillName.count < 12 ? .gray : .red)
                .fontWeight(pillName.count < 12 ? .medium : .bold)
            
        } // Group
        .padding(.horizontal, 100)
        .frame(width: 360, height: 12, alignment: .trailing)
        
        Group {
            TextField("약 효과를 적어보세요", text: $pillEffect)
                .foregroundColor(Color(uiColor: .systemGray4))
                .font(.system(size: 16))
                .multilineTextAlignment(.center)
            
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 32)
                .background(pillEffect.count < 40 ? .gray : .red)
                .padding(.bottom, -24)
            
            // Message string counter
            Text("(\(pillEffect.count)/40)")
                .font(.system(size: 12))
                .foregroundColor(pillEffect.count < 40 ? .gray : .red)
                .fontWeight(pillEffect.count < 40 ? .medium : .bold)
            
        } // Group
        .padding(.top, 24)
        .padding(.horizontal, 18)
        .frame(width: 360, height: 12, alignment: .trailing)
        
        Spacer()
        
    } // VStack
} // body

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        
        PillView()
        
    }
}
