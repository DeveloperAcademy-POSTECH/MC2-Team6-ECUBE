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
                
                Image("cassette_horizontal")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350)
                    .padding()
                    .shadow(color:Color(hex: "D2D2D2"), radius: 10, x: 0, y: 1)
                
                Spacer()
                
                ZStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(Color.shadowColor)
                        .blendMode(.multiply)
                    
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
                .frame(maxWidth: .infinity, maxHeight: 340, alignment: .center)
                .overlay(
                    VStack {
                        Text(vm.title)
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.bodyTextColor)

                        Text(vm.createDate)
                            .font(.subheadline)
                            .foregroundColor(Color.bodyTextColor)
                            .opacity(0.8)
                    }
                        .padding(.top, 32)
                    .frame(maxWidth: .infinity, maxHeight: 300, alignment: .top)
                )
                .background(RoundedRectangle(cornerRadius: 20).fill(.white).shadow(color:Color.shadowColor, radius: 12, x: 0, y: -3))
//
//                Spacer()
//
            }
            
        }
        .task {
            getSingleVoicemail(id: vm.voiceMailId)
        }
        .ignoresSafeArea(edges: .bottom)
        
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
