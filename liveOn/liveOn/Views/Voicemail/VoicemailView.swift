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
    
    let nowDate = Date.now
    
    var body: some View {
        
        ZStack {
            
            Color.background
                .ignoresSafeArea()
            
            VStack {
                
                // MARK: 제목 입력과 카세트테이프 이미지 부분
                VoicemailMainView(title: $vm.title)
                
                // MARK: 녹음 부분
                VStack {
                    
                    if vm.isRecording == false && vm.isRecorded == false {
                        Text("")
                    } else if vm.isRecorded == false && vm.isRecording == true {
                        Text(vm.timer)
                    } else {
                        
                    }
                    
                    // MARK: 녹음 버튼
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
                                VStack {
                                    Image(systemName: "stop.fill")
                                        .resizable()
                                        .foregroundColor(Color.recordingBtn)
                                        .frame(width: 40, height: 40)
                                        .onTapGesture {
                                            vm.stopRecording()
                                            vm.fetchAllRecording()
                                            vm.isRecording = false
                                            vm.isRecorded = true
                                            vm.timer = "0:00"
                                    }
                                }
                                
                            } else {
                                
                                // MARK: 녹음하고 난 다음 재생해보고 싶을 때
                                ZStack {
                                    
                                    HStack {
                                        
                                        Image(systemName: "play.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(Color.recordingBtn)
                                            .frame(width: 40)
                                            .onTapGesture {
                                                vm.startPlaying(url: vm.recordingsList[vm.recordingsList.count - 1].fileURL)
                                            }
                                            .padding(.leading, 5)
                                        
                                    }
                                    
                                    HStack {
                                        
                                        Spacer()
                                            .frame(width: 40)
                                        
                                        Image(systemName: "gobackward")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20)
                                            .onTapGesture {
                                                
                                                // MARK: 녹음한 파일을 재생중이면 멈추기
                                                if vm.recordingsList[vm.recordingsList.count - 1].isPlaying {
                                                    
                                                    vm.stopPlaying(url: vm.recordingsList[vm.recordingsList.count - 1].fileURL)
                                                    
                                                }
                                                
                                                // MARK: 재녹음을 위해 이전에 녹음한 것 삭제
                                                vm.deleteAllRecordings()
                                                vm.isRecorded = false
                                                vm.isRecording = false
                                            }
                                        Spacer()
                                    }
                                }
                            }
                        }
                        
//                    Button(action: {
//                        vm.deleteAllRecordings()
//                    }) {
//                        Text("delete files")
//                    }
                    
                    }
                    Spacer()
                        .frame(height: 90)
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
            .onTapGesture {
                hideKeyboard()
            }
        .foregroundColor(Color.bodyTextColor)
        }
    }
}

struct VoicemailView_Previews: PreviewProvider {
    static var previews: some View {
        VoicemailView()
    }
}
