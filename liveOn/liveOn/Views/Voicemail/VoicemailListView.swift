//
//  VoicemailListView.swift
//  liveOn
//
//  Created by 이성민 on 2022/06/15.
//

import SwiftUI

struct VoicemailListView: View {
    
    @ObservedObject var vm = VoiceRecorderVM()
    
    @State var showModal: Bool = false
    
    private let communication = ServerCommunication().getVM()
    
    var body: some View {
        ZStack {
            
            Color.background
                .ignoresSafeArea()
            
            ScrollView {
                ZStack {
                    VStack {
                        ForEach(vm.sampleList, id: \.fileURL) { vm in
                            HStack {
                                ZStack {
                                    Color.white
                                    Color.cassetteBorder
                                        .overlay(RoundedRectangle(cornerRadius: 8)
                                            .frame(width: 330, height: 35)
                                            .foregroundColor(.white))
                                    Text(vm.title)
                                }
                            }
                            .frame(width: 350, height: 55)
                            .cornerRadius(8)
                            .onTapGesture {
                                showModal.toggle()
                            }
                        }
                    }
                    .blur(radius: showModal ? 3 : 0)
                    
                    if showModal {
                        VStack {
                            Text("blur")
                                
                        }
                    }
                }
            }
        }
    }
}

// class Storage: ObservableObject {
//
//    @Published var list: [Recording]
//
//    init() {
//        list = [
//            Recording(fileURL: Bundle.main.url(forResource: "test1", withExtension: "m4a")!, createdAt: Date.now, title: "test1", isPlaying: false),
//            Recording(fileURL: Bundle.main.url(forResource: "test2", withExtension: "m4a")!, createdAt: Date.now, title: "test2", isPlaying: false),
//            Recording(fileURL: Bundle.main.url(forResource: "test3", withExtension: "m4a")!, createdAt: Date.now, title: "test3", isPlaying: false)
//        ]
//    }
// }

struct VoicemailListView_Previews: PreviewProvider {
    static var previews: some View {
        VoicemailListView()
    }
}
