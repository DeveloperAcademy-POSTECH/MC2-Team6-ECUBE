//
//  PillView.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/07.
//

import SwiftUI

struct PillView: View {
    var body: some View {
        
        VStack {
            
            PillHeaderView()
            PillBodyView()
            
        }
        .navigationTitle("영양제")
        .navigationBarTitleDisplayMode(.inline)
        .background(.background)
    }
}

struct PillHeaderView: View {
    var body: some View {
        
        HStack {
            
            Button {
                
            } label: {
                Text("<")
            }
            
            Spacer()
            
            
            Button {
                // Submit 기능
            } label: {
                Text("Send")
            }
            
        } // HStack
    } // body}
}

struct PillBodyView: View {
    
    // MARK: Property
    @State private var pillImageCounter: Int = 0
    @State private var pillName: String = ""
    @State private var pillEffect: String = ""

    
    var body: some View {
        
        // TODO: 알약 이미지 OnTapGesture
        let pillColorList: [Color] = [.blue, .red, .black]
        
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
        
        VStack {
            
            ZStack {
                
                // [임시] 호버링 메시지카드
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 160, height: 40, alignment: .center)
                    .foregroundColor(.gray)
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
                
                Divider()
                    .frame(height: 1)
                    .padding(.horizontal, 32)
                    .background(Color.gray)
            } // Group
            
            Group {
                TextField("약 효과?", text: .constant(""))
                    .multilineTextAlignment(.center)
                
                // Message string counter
                Text("(\(pillEffect.count)/40)")
                    .foregroundColor(.gray)
                
                Divider()
                    .frame(height: 1)
                    .padding(.horizontal, 32)
                    .background(Color.gray)
            } // Group
            
            Spacer()
            
        } // VStack
        .padding(.top, 36)
        
    } // body
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        
        PillView()
        
    }
}
