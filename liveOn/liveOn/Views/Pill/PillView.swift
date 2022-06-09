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
    } // VStack
}

struct PillBodyView: View {
    
    // MARK: Property
    @State private var pillImageCounter: Int = 0
    @State private var pillName: String = ""
    @State private var pillEffect: String = ""

    
    var body: some View {
        
        // TODO: 알약 이미지 OnTapGesture
        let pillColorList: [Color] = [.blue, .red, .black]
        
        ZStack{
            
        // 약 이미지 들어갈 곳을 잠시 둥글려진 사각형이 차지
        RoundedRectangle(cornerRadius: 12)
            .frame(width: 240, height: 240, alignment: .center)
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
                .frame(width: 180, height: 180, alignment: .center)
        }
        
        VStack {
            
            ZStack {
                
                Text("탭해서 다른 약으로 바꾸기")
                    .foregroundColor(.white)
                    .font(.system(size: 12))
                    .fontWeight(.medium)
            } // ZStack
            
            Group {
                TextField("약 이름?", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                
                // Message string counter
                Text("(\(pillName.count)/12)")
                    .foregroundColor(.gray)
                
                BarUnderTextField()
                
            } // Group
            
            Group {
                TextField("약 효과?", text: .constant(""))
                    .multilineTextAlignment(.center)
                
                // Message string counter
                Text("(\(pillEffect.count)/40)")
                    .foregroundColor(.gray)
                
                BarUnderTextField()
                
            } // Group
            
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
            .background(Color(uiColor: .systemGray4))
    }
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        
        PillView()
        
    }
}

