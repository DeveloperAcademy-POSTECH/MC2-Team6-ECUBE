//
//  VoiceRecorderVM.swift
//  liveOn
//
//  Created by 이성민 on 2022/06/05.
//

import Foundation
import AVFoundation

class VoiceRecorderVM: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    @Published var isRecording: Bool = false
    @Published var recordingsList = [Recording]()
    
    override init() {
        super.init()
    }
    
    func startRecording() {
        
        let recordingSession = AVAudioSession.sharedInstance()
        do{
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Can not setup the recording")
        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let fileName = path.appendingpathcomponent
    }
    
}
