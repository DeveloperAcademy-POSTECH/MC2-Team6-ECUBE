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
//    @State var recordingIndex: Int = voiceMail.recordingsList.count
    
    let nowDate = Date.now
    
    var body: some View {
        GeometryReader { frame in
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
                
                HStack {
                    ZStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color.recordingBtnBackground)
                        
                        if voiceMail.isRecording == false && voiceMail.isRecorded == false {
                            
                            // MARK: 녹음하지 않은 경우
                            Image(systemName: "circle.fill")
                                .resizable()
                                .foregroundColor(Color.recordingBtn)
                                .frame(width: 50, height: 50)
                                .onTapGesture {
                                    voiceMail.startRecording()
                                    voiceMail.isRecording = true
//                                    voiceMail.isRecorded = true
                                }
                            
                        } else if voiceMail.isRecorded == false && voiceMail.isRecording == true {
                            
                            // MARK: 녹음하고 있는 경우
                            Image(systemName: "stop.fill")
                                .resizable()
                                .foregroundColor(Color.recordingBtn)
                                .frame(width: 40, height: 40)
                                .onTapGesture {
                                    voiceMail.stopRecording()
                                    voiceMail.isRecording = false
                                    voiceMail.isRecorded = true
                                }
                            
                        } else {
                            
                            // MARK: 녹음하고 난 다음 재생해보고 싶을 때
                            ZStack {
                                HStack {
                                    Spacer()
                                    Image(systemName: "play.fill")
                                        .resizable()
                                        .foregroundColor(Color.recordingBtn)
                                        .frame(width: 40, height: 40)
                                        .onTapGesture {
                                            voiceMail.startPlaying(url: voiceMail.recordingsList[voiceMail.recordingsList.count - 1].fileURL)
                                    }
                                    Spacer()
                                }
                                
                                HStack {
                                    Spacer()
                                        .frame(width: 30)
                                    
                                    Image(systemName: "gobackward")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .onTapGesture {
                                            
                                            voiceMail.stopPlaying(url: voiceMail.recordingsList[voiceMail.recordingsList.count - 1].fileURL)
                                            voiceMail.deleteRecording(url: voiceMail.recordingsList[voiceMail.recordingsList.count - 1].fileURL)
                                            voiceMail.isRecorded = false
                                            voiceMail.isRecording = false
                                        }
                                    
                                    Spacer()
                                }
                                
                            }
                        }
                    }
                    
//                    ScrollView(.horizontal) {
//                        VStack {
//                            ForEach(voiceMail.recordingsList, id: \.createdAt) { recording in
//                                Text("\(recording.fileURL)")
//                            }
//                        }
//                    }
                    Button(action: {
                        voiceMail.showFiles()
                    }) {
                        Text("show files")
                    }
                    
                    Button(action: {
                        voiceMail.deleteAllRecordings()
                    }) {
                        Text("delete files")
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
