//
//  VoicemailView.swift
//  liveOn
//
//  Created by 이성민 on 2022/06/04.
//

import SwiftUI
import AVFoundation

struct VoicemailView: View {
    
    @ObservedObject var voiceMail = VoiceRecorderVM()
    @State var title: String = ""
    
    let nowDate = Date.now
    
    var body: some View {
        GeometryReader{ frame in
            VStack {
                Spacer()
                
                // 제목을 voiceMailVM 클래스에도 추가해야 하지 않을까?
                //
                TextField("제목을 입력하세요", text: $title)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, height: 20)
                
                Text(DateToString(_:nowDate))
                    .foregroundColor(Color.bodyTextColor)
                
                Image("cassette_horizontal")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    
                Spacer()
                    .frame(height: 80)
                
                ZStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(Color.recordingBtnBackground)
                    
//                    Image(systemName: voiceMail.isRecording ? "stop.fill" : "circle.fill")
//                        .resizable()
//                        .foregroundColor(Color.recordingBtn)
//                        .frame(width: 50, height: 50)
//                        .onTapGesture {
//                            if voiceMail.isRecording == true {
//                                voiceMail.stopRecording()
//                            } else {
//                                voiceMail.startRecording()
//                            }
//                        }
                    
                    if voiceMail.isRecording == true {
                        Image(systemName: "stop.fill")
                            .resizable()
                            .foregroundColor(Color.recordingBtn)
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                voiceMail.stopRecording()
                            }
                    } else {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .foregroundColor(Color.recordingBtn)
                            .frame(width: 50, height: 50)
                            .onTapGesture {
                                voiceMail.startRecording()
                            }
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct VoicemailView_Previews: PreviewProvider {
    static var previews: some View {
        VoicemailView(title: "")
    }
}
