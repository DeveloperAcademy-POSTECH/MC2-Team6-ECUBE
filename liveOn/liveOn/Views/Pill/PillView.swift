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
    }
}

struct PillHeaderView: View {
    var body: some View {
        
        Text("I'm the header")
        
        ZStack {
            // 약 이미지 들어갈 곳을 잠시 둥글려진 사각형이 차지
            RoundedRectangle(cornerRadius: 24)
                .frame(width: 280, height: 280, alignment: .center)
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
            .padding(.top, 24)
            .padding(.horizontal, 18)
            .frame(width: 360, height: 12, alignment: .trailing)
            
            Spacer()
            
        } // VStack
        .padding(.top, 36)
        
    } // body
}

struct PillBodyView: View {
    var body: some View {
        
        Text("I'm the body")

    }
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        
        PillView()
        
    }
}
