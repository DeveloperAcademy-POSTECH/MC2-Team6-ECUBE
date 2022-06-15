//
//  CoupleInformation.swift
//  liveOn
//
//  Created by Jisu Jang on 2022/06/15.
//

import SwiftUI

struct CoupleInformation: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(Color.background)
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                Text("재헌 ❤️ 유진")
                    .frame(width: 300, height: 150, alignment: .center)
                    .background(.white)
                    .cornerRadius(20)
                
                settingList("우리의 1일")
                settingList("알림 설정")
                
                Spacer()
            }
        }
        .navigationToBack(dismiss)
    }
    
    private func settingList(_ settingText: String) -> some View {
        NavigationLink(destination: DetailedInformationView()) {
            HStack {
                Text(settingText)
                    .foregroundColor(.black)
                    .bold()
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
            }
            .frame(width: 300, alignment: .leading)
        }
    }
}

struct CoupleInformation_Previews: PreviewProvider {
    static var previews: some View {
        CoupleInformation()
    }
}
