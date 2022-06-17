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
                
                Image(systemName: isPlaying ? "pause.circle.fill": "play.circle.fill")
                    .font(.system(size: 25))
                    .padding(.trailing)
                    .onTapGesture {
                        voicemailPlayer.PlaySound(voicemailURL: voicemailURL!)
                        isPlaying.toggle()
                        
                        if isPlaying {
                            voicemailPlayer.player?.play()
                        } else {
                            voicemailPlayer.player?.pause()
                        }
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
