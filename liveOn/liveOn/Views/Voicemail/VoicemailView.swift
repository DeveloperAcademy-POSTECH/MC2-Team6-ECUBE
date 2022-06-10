//
//  VoicemailView.swift
//  liveOn
//
//  Created by 이성민 on 2022/06/04.
//

import SwiftUI
import AVFoundation

struct VoicemailView: View {
    
    @ObservedObject var vm = VoiceRecorderVM()
    
    @State var title: String = ""
    //    @State var recordingIndex: Int = vm.recordingsList.count
    
    let nowDate = Date.now
    
    var body: some View {
        
        VStack {
            Spacer()
            
            // 제목을 voiceMailVM 클래스에도 추가해야 하지 않을까?
            TextField("제목을 입력하세요", text: $vm.title)
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
                    
                    if vm.isRecording == false && vm.isRecorded == false {
                        
                        // MARK: 녹음하지 않은 경우
                        Image(systemName: "circle.fill")
                            .resizable()
                            .foregroundColor(Color.recordingBtn)
                            .frame(width: 50, height: 50)
                            .onTapGesture {
                                vm.startRecording()
                                vm.isRecording = true
                            }
                        
                    } else if vm.isRecorded == false && vm.isRecording == true {
                        
                        // MARK: 녹음하고 있는 경우
                        Image(systemName: "stop.fill")
                            .resizable()
                            .foregroundColor(Color.recordingBtn)
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                vm.stopRecording()
                                vm.fetchAllRecording()
                                vm.isRecording = false
                                vm.isRecorded = true
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
                                        vm.startPlaying(url: vm.recordingsList[vm.recordingsList.count - 1].fileURL)
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
                                        
                                        // MARK: 녹음한 파일을 재생중이면 멈추기
                                        if vm.recordingsList[vm.recordingsList.count - 1].isPlaying {
                                            
                                            vm.stopPlaying(url: vm.recordingsList[vm.recordingsList.count - 1].fileURL)
                                            
                                        }
                                        
                                        // MARK: 재녹음을 위해 이전에 녹음한 것 삭제
                                        vm.deleteRecording(url: vm.recordingsList[vm.recordingsList.count - 1].fileURL)
                                        vm.isRecorded = false
                                        vm.isRecording = false
                                    }
                                Spacer()
                            }
                        }
                    }
                }
                
//                Button(action: {
//                    vm.showFiles()
//                }) {
//                    Text("show files")
//                }
//
//                Button(action: {
//                    vm.deleteAllRecordings()
//                }) {
//                    Text("delete files")
//                }
//
            }
            Spacer()
        }
        .toolbar {
            Button(action: {
                
            }) {
                Text("선물하기")
            }
            .disabled(!vm.canSend())
        }
    }
}

struct VoicemailView_Previews: PreviewProvider {
    static var previews: some View {
        VoicemailView(title: "")
    }
}
