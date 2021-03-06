//
//  VoicemailListView_.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/16.
//

import SwiftUI

struct VoicemailsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var loadedVM: [VoicemailGetResponse] = []
    @State var selectedVM: Int = 0
    @State var isShowPopUp: Bool = false
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack {
                if loadedVM.count > 8 {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            Spacer()
                            VStack(alignment: .trailing, spacing: 16) {
                                ForEach(loadedVM, id: \.giftVoiceMailID) { vm in
                                    VoicemailCassette(voiceMail: vm.convertToVoicemail())
                                        .onTapGesture {
                                            withAnimation(.easeOut) {
                                                isShowPopUp.toggle()
                                            }
                                            selectedVM = findIndex(of: vm.giftVoiceMailID, in: loadedVM)
                                            print("selectedVM: ", selectedVM)
                                        }
                                }
                            }
                            .padding(12)
                            .border(.thinMaterial, width: 1)
                            .background(.regularMaterial)
                            .padding(16)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .navigationTitle("음성메세지")
                        .navigationBarTitleDisplayMode(.inline)
                        .background(Color.background)
                    }
                } else {
                    VStack {
                        Spacer()
                        VStack(alignment: .trailing, spacing: 16) {
                            ForEach(loadedVM, id: \.giftVoiceMailID) { vm in
                                VoicemailCassette(voiceMail: vm.convertToVoicemail())
                                    .onTapGesture {
                                        withAnimation(.easeOut) {
                                            isShowPopUp.toggle()
                                        }
                                        selectedVM = findIndex(of: vm.giftVoiceMailID, in: loadedVM)
                                        print("selectedVM: ", selectedVM)
                                    }
                            }
                        }
                        .padding(12)
                        .border(.thinMaterial, width: 1)
                        .background(.regularMaterial)
                        .padding(16)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationTitle("음성메세지")
                    .navigationBarTitleDisplayMode(.inline)
                    .background(Color.background)
                }
            }
            .blur(radius: isShowPopUp ? 6 : 0)
            Color(uiColor: .systemBackground).opacity(isShowPopUp ? 0.8 : 0)
            if isShowPopUp {
                VoicemailPopUpView(vm: loadedVM[selectedVM].convertToVoicemail())
            }
            
        }
        .task {
            vmListGet()
        }
        .onTapGesture {
            withAnimation(.easeOut) {
                isShowPopUp = false
            }
        }
        .navigationToBack(dismiss)
    }
    
    // MARK: Voicemail List 가져오기
    func vmListGet() {
        moyaService.request(.voicemailListGet) { response in
            switch response {
                case .success(let result):
                    do {
                        print("result : ", result.data)
                        let data = try result.map([VoicemailGetResponse].self)
                        print("Data : \(data)")
                        
                        mapListData(data: data)
                        
                    } catch let err {
                        print(err.localizedDescription)
                        print("음성메세지 리스트를 디코딩하는데 실패했습니다")
                        break
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    break
            }
        }
    }
    
    // MARK: Voicemail 하나를 클릭했을 때 그 특정 Voicemail에 관한 데이터 받기
    func vmGet(id: Int) {
        moyaService.request(.voicemailGet(id: id)) { response in
            switch response {
                case .success(let result):
                    print("result : ", result.data)
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
    // MARK: 서버에서 받아온 데이터를 사용 가능한 데이터로 변환
    func mapListData(data: [VoicemailGetResponse]) {
        for vm in data {
            loadedVM.append(vm)
        }
        print("loadedVM : ", loadedVM)
    }
    
    // MARK: VoicemailID로 index 찾기
    func findIndex(of id: Int, in array: [VoicemailGetResponse]) -> Int {
        var index: Int = 0
        for i in 0..<array.count {
            if array[i].giftVoiceMailID == id {
                index = i
                break
            }
        }
        return index
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
