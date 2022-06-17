//
//  VoicemailListView_.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/16.
//

import SwiftUI

struct VoicemailsView: View {
    
    //    private let communication = ServerCommunication()
    @State var loadedVM: [VoicemailGetResponse] = []
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            if loadedVM.count > 8 {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Spacer()
                        VStack(alignment: .trailing, spacing: 16) {
                            ForEach(loadedVM, id: \.giftVoiceMailID) { vm in
                                VoicemailCassette(voiceMail: vm.convertToVoicemail())
                            }
                        }
                        .padding(12)
                        .border(.thinMaterial, width: 1)
                        .background(.regularMaterial)
                        .padding(16)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationTitle("카세트테이프")
                    .navigationBarTitleDisplayMode(.inline)
                    .background(Color.background)
                }
            } else {
                VStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 16) {
                        ForEach(loadedVM, id: \.giftVoiceMailID) { vm in
                            VoicemailCassette(voiceMail: vm.convertToVoicemail())
                        }
                        
                    }
                    .padding(12)
                    .border(.thinMaterial, width: 1)
                    .background(.regularMaterial)
                    .padding(16)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle("카세트테이프")
                .navigationBarTitleDisplayMode(.inline)
                .background(Color.background)
            }
            
        }
        .task {
            vmGet()
        }
        
    }
    
    func vmGet() {
        
        moyaService.request(.voicemailListGet) { response in
            switch response {
            case .success(let result):
                do {
                    print("result : ", result.data)
                    let data = try result.map([VoicemailGetResponse].self)
                    print("Data : \(data)")
                    
                    mapData(data: data)
                    
                } catch let err {
                    print(err.localizedDescription)
                    print("음성메시지를 디코딩하는데 실패했습니다")
                    break
                }
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        }
    }
    
    func mapData(data: [VoicemailGetResponse]) {
        for vm in data {
            loadedVM.append(vm)
        }
        print("loadedVM : ", loadedVM)
    }
    
}

// var voiceMailDummy = [
//    Voicemail(title: "재허나뭐해잉", createDate: "220616", whoSent: mailConstants.user1, vmBackgroundColor: mailConstants.green, vmIconImageName: "flower", soundLength: "00:48"),
//    Voicemail(title: "유지나뭐해잉", createDate: "220314", whoSent: mailConstants.user2, vmBackgroundColor: mailConstants.orange, vmIconImageName: "flower", soundLength: "00:39"),
//    Voicemail(title: "유sdf잉", createDate: "220314", whoSent: mailConstants.user2, vmBackgroundColor: mailConstants.orange, vmIconImageName: "flower", soundLength: "00:39"),
//    Voicemail(title: "유지나뭐fsd잉", createDate: "220314", whoSent: mailConstants.user2, vmBackgroundColor: mailConstants.orange, vmIconImageName: "flower", soundLength: "00:39"),
//    Voicemail(title: "유지나뭐해잉", createDate: "220314", whoSent: mailConstants.user2, vmBackgroundColor: mailConstants.orange, vmIconImageName: "fdsower", soundLength: "00:39"),
//    Voicemail(title: "유지나뭐해잉", createDate: "220314", whoSent: mailConstants.user2, vmBackgroundColor: mailConstants.orange, vmIconImageName: "flower", soundLength: "00:39"),
//    Voicemail(title: "유지나뭐해잉", createDate: "220314", whoSent: mailConstants.user2, vmBackgroundColor: mailConstants.orange, vmIconImageName: "flower", soundLength: "00:39")
//
// ]
