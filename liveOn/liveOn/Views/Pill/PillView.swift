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
        } label: {Text("보내기").fontWeight(.bold)}.disabled(!input.inputEntered))
        .padding(.horizontal, 32)
    } // body
}

struct PillBodyView: View {
    
    // MARK: Property
    @State private var pillImageCounter: Int = 0
    @State private var pillName: String = ""
    @State private var pillEffect: String = ""
    
    var body: some View {
        
        // Sample data
        let pillColorList: [Color] = [.blue, .red, .black]
        
        ZStack{
            
            // 약 이미지 들어갈 곳을 잠시 둥글려진 사각형이 차지
            RoundedRectangle(cornerRadius: 24)
                .frame(width: 320, height: 320, alignment: .center)
                .foregroundColor(pillColorList[pillImageCounter])
                .onTapGesture {
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
        .padding(.top, 64)
        
        VStack {
            
            ZStack(alignment: .center) {
                // 여기에 말풍선 넣기
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 180, height: 40, alignment: .center)
                    .foregroundColor(Color(uiColor: .systemGray4))
                
                Text("탭해서 다른 약으로 바꾸기")
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                
            } // ZStack
            .padding(.bottom, 24)
            
            Group {
                TextField("어떤 약인가요?", text: .constant(""))
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16))
                    .padding(.vertical, 12)
                
                BarUnderTextField()
                    .padding(.bottom, -24)
                
                // Message string counter
                Text("(\(pillName.count)/12)")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
            } // Group
            .padding(.horizontal, 100)
            .frame(width: 360, height: 12, alignment: .trailing)
            
            Group {
                TextField("약 효과를 적어보세요", text: .constant(""))
                    .foregroundColor(Color(uiColor: .systemGray4))
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                
                BarUnderTextField()
                
                // Message string counter
                Text("(\(pillEffect.count)/40)")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
            } // Group
            .padding(.horizontal, 18)
            .frame(width: 360, height: 12, alignment: .trailing)
            
            Spacer()
            
        } // VStack
        .padding(.top, 36)
        
    } // body
}

struct BarUnderTextField: View {
    var body: some View {
        Divider()
            .frame(height: 1)
            .padding(.horizontal, 32)
            .background(Color.gray)
    }
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        
        PillView()
        
    }
}

