//
//  VoiceRecorderVM.swift
//  liveOn
//
//  Created by 이성민 on 2022/06/05.
//

import Foundation
import AVFoundation
import SwiftUI

class VoiceRecorderVM: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    @Published var isRecording: Bool = false
    @Published var recordingsList = [Recording]()
    
    override init() {
        super.init()
    }
    
    // Recording 시작하고 파일명을 녹음 시작한 순간의 시간으로 설정
    func startRecording() {
        
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Can not setup the recording")
        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = path.description.appendingPathComponent("live-On: \(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            isRecording = true
        } catch {
            print("Failed to Setup the Recording")
        }
    }
    
    // Recording 멈춤
    func stopRecording() {
        audioRecorder.stop()
        isRecording = false
    }
    
    // Recording 내역 가져오기
    func fetchAllRecordings() {
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        
        for i in directoryContents {
            recordingsList.append(Recording(fileURL: i, createdAt: getFileDate(for: i), isPlaying: false))
        }
        
        recordingsList.sort(by: { $0.createdAt.compare($1.createdAt) == .orderdDescending })
    }
    
    // 제작한 Recordings 재생하기
    func startPlaying(url: URL) {
        
        let playSession = AVAudioSession.sharedInstance()
        
        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing failed in device")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            
            for i in 0..<recordingsList.count {
                if recordingsList[i].fileURL == url {
                    recordingsList[i].isPlaying = true
                }
            }
        } catch {
            print("Playing Failed")
        }
    }
    
    // 제작한 Recordings 재생중인 것 멈추기
    func stopPlaying(url : URL) {
        
        audioPlayer.stop()
        
        for i in 0..<recordingsList.count {
            if recordingsList[i].fileURL == url {
                recordingsList[i].isPlaying = false
            }
        }
    }

    // 제작한 당시의 날짜 가져옴
    func getFileDate(for file: URL) -> Date {
        if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
            let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
            return creationDate
        } else {
            return Date()
        }
    }
    
}

