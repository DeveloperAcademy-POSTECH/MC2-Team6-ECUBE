//
//  VoicemailPopUpView.swift
//  liveOn
//
//  Created by 이성민 on 2022/06/17.
//

import SwiftUI

struct VoicemailPopUpView: View {
    
    @ObservedObject private var voicemailPlayer = VoicemailPlayer()
    
    @State var voicemailURL: URL?
    @State var isPlaying: Bool = false
    
    var vm: Voicemail
    
    var body: some View {
        
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 140)
                
                Text(vm.title)
                    .font(.system(size: 24))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.bodyTextColor)
                    .frame(width: 300, height: 20)
                
                Text(vm.createDate)
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.bodyTextColor)
                
                Image("cassette_horizontal")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350)
                    .padding()
                
                Spacer()
                
                ZStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(Color.recordingBtnBackground)
                    
                    Image(systemName: isPlaying ? "pause.fill": "play.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.recordingBtn)
                        .frame(width: isPlaying ? 30 : 40)
                        .onTapGesture {
                            voicemailPlayer.PlaySound(voicemailURL: voicemailURL!)
                            isPlaying.toggle()
                            if isPlaying {
                                voicemailPlayer.player?.play()
                                
//                                if voicemailPlayer.player?.rate == 0 {
//                                    isPlaying = false
//                                }
                            } else {
                                voicemailPlayer.player?.pause()
                            }
                            
                        }
                        .padding(.leading, isPlaying ? 0 : 5)
                    
                }
                
                Spacer()
                
            }
            
        }
        .task {
            getSingleVoicemail(id: vm.voiceMailId)
        }
        .background(Color.white.opacity(0))
        
    }
    
    // MARK: Additional Functions
    // Fetch Get response of path "/api/v1/gifts/voicemail/{id}"
    func getSingleVoicemail(id: Int) {
        moyaService.request(.voicemailGet(id: id)) { response in
            switch response {
            case .success(let result):
                do {
                    let data = try result.map(SingleVoicemailResponse.self)
                    print(data)
                    convertURL(data.voiceMail)
                } catch let err {
                    print(err.localizedDescription)
                }
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    // Map decoded data for real use
    func convertURL(_ url: String) {
        voicemailURL = URL(string: url)!
    }
    
}
