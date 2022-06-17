//
//  VoicemailPopUpView.swift
//  liveOn
//
//  Created by 이성민 on 2022/06/17.
//

import SwiftUI

struct VoicemailPopUpView: View {
    
    var vm: Voicemail
    
    var body: some View {
        
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 140)
                
                Text(vm.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.bodyTextColor)
                    .frame(width: 300, height: 20)
                
                Text(vm.createDate)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.bodyTextColor)
                
                Image("cassette_horizontal")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350)
                    .padding()
                
                Spacer()
            }
            
            
        }
        .background(Color.white.opacity(0))
    }
    
    func getURLForVoicemail(id: Int) {
        moyaService.request(.voicemailGet(id: id)) { response in
            switch response {
            case .success(let result):
                do {
                    let url = try result.
                }
            }
        }
    }
    
}
