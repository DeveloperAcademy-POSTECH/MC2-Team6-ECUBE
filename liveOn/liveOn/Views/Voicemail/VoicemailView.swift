//
//  VoicemailView.swift
//  liveOn
//
//  Created by 이성민 on 2022/06/04.
//
import SwiftUI
import AVFoundation

struct VoicemailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var vm = VoiceRecorderVM()
    
    @State private var showAlertforSend: Bool = false
    @State var gotoTransport: Bool = false
    @State private var showLoading = false
    @State private var loadingState: Int = 0
    
    @Binding var gotoMain: Bool
    
    private let communication = ServerCommunication()
    let nowDate = Date.now
    
    var body: some View {
        
        ZStack {
            
            Color.background
                .ignoresSafeArea()
            
            VStack {
                
                // MARK: 제목 입력과 카세트테이프 이미지 부분
                VoicemailCassetteView(title: $vm.title)
                
                // MARK: 녹음 부분
                VStack {
                    
                    if vm.isRecording == false && vm.isRecorded == false {
                        Text("")
                    } else if vm.isRecorded == false && vm.isRecording == true {
                        Text(vm.timer)
                        Spacer()
                            .frame(height: 50)
                    } else {
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
                            .frame(height: 50)
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
                                VStack {
                                    
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
                                }
                            }
                        }
                        
                        Button(action: {
                            vm.deleteAllRecordings()
                        }) {
                            Text("delete files")
                        }
                        Button(action: {
                            vm.fetchAllRecording()
                        }) {
                            Text("test")
                        }
                    }
                    Spacer()
                        .frame(height: 90)
                }
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button(action: {
                        showAlertforSend = true
                    }) {
                        Text("선물하기")
                            .fontWeight(.bold)
                    }
                    .disabled(vm.cantSend())
                    .background(
                        NavigationLink(
                            destination: PhotoTransport(gotoMain: $gotoMain),
                            isActive: $gotoTransport,
                            label: {EmptyView()})
                    )
                    .alert(isPresented: $showAlertforSend) {
                        Alert(
                            title: Text("선물 보내기"),
                            message: Text("선물은 하루에 하나만 보낼 수 있어요. 음성메시지를 보낼까요?"),
                            primaryButton: .cancel(Text("취소")),
                            secondaryButton: .default(Text("보내기")) {
                                
                                communication.uploadVM(
                                    title: vm.title,
                                    name: vm.getFileName(for: vm.recordingsList[vm.recordingsList.count - 1].fileURL.deletingPathExtension()),
                                    duration: String(vm.countSec)
                                )
                                
                                showLoading.toggle()
                                Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                                    loadingState += 1
                                    gotoTransport = true
                                }
                            }
                        )
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("음성메시지")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
            }
            .blur(radius: showLoading ? 6 : 0)
            .onTapGesture {
                hideKeyboard()
            }
            .foregroundColor(Color.bodyTextColor)
            
            if showLoading == true {
                
                Image(loadingState == 0 ? "LoadingCharacter" : "")
                    .frame(width: 300, height: 300, alignment: .center)
                    .frame(maxWidth:.infinity, maxHeight: .infinity)
            }
        }
        .navigationToBack(dismiss)
    }
}

//struct VoicemailView_Previews: PreviewProvider {
//    static var previews: some View {
//        VoicemailView()
//    }
//}
