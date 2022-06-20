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
    @Published var isRecorded: Bool = false
    @Published var recordingsList = [Recording]()
    
    @Published var countSec = 0
    @Published var timerCount: Timer?
    @Published var blinkingCount: Timer?
    @Published var timer: String = "0:00"
    @Published var toggleColor: Bool = false
    
    @Published var title: String = ""
    
//    @Published var sampleList: [Recording] = [
//        Recording(fileURL: Bundle.main.url(forResource: "test1", withExtension: "m4a")!, createdAt: Date.now, title: "test1", isPlaying: false),
//        Recording(fileURL: Bundle.main.url(forResource: "test2", withExtension: "m4a")!, createdAt: Date.now, title: "test2", isPlaying: false),
//        Recording(fileURL: Bundle.main.url(forResource: "test3", withExtension: "m4a")!, createdAt: Date.now, title: "test3", isPlaying: false)
//    ]
    
    var playingURL: URL?
    
    override init() {
        super.init()
        
        fetchAllRecording()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
       
        for i in 0..<recordingsList.count {
            if recordingsList[i].fileURL == playingURL {
                recordingsList[i].isPlaying = false
            }
        }
    }
    
    // MARK: 녹음 시작하는 함수
    func startRecording() {
        
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Cannot setup the Recording")
        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = path.appendingPathComponent("live-On : \(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).m4a")
        
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
            
            timerCount = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
                self.countSec += 1
                self.timer = self.covertSecToMinAndHour(seconds: self.countSec)
            })
            self.countSec = 0
        } catch {
            print("Failed to Setup the Recording")
        }
    }
    
    // MARK: 녹음 완료했을 시 녹음 멈추는 함수
    func stopRecording() {
        
        audioRecorder.stop()
        
        isRecording = false
        
//        self.countSec = 0
        
        timerCount!.invalidate()
        
    }
    
    // MARK: 녹음한 파일들 모두 가져오기
    func fetchAllRecording() {
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        
        print(directoryContents)
        
        for i in directoryContents {
            recordingsList.append(Recording(fileURL: i, createdAt: getFileDate(for: i), title: title, duration: String(countSec), isPlaying: false))
        }
        
        recordingsList.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending})
        
        print(recordingsList)
    }
    
    // MARK: 녹음한 파일 다시 들어보는 함수
    func startPlaying(url: URL) {
        
        playingURL = url
        
        let playSession = AVAudioSession.sharedInstance()
        
        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing failed in Device")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
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
    
    // MARK: 제작한 Recordings 재생 후 멈추기
    func stopPlaying(url: URL) {
        
        audioPlayer.stop()
        
        for i in 0..<recordingsList.count {
            if recordingsList[i].fileURL == url {
                recordingsList[i].isPlaying = false
            }
        }
    }
    
    // MARK: recordingsList에 있는 녹음 파일 하나를 삭제하는 함수
    // 테스트 과정에서만 사용
    func deleteRecording(url: URL) {
        
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Can't delete")
        }
        
        for i in 0..<recordingsList.count {
            
            if recordingsList[i].fileURL == url {
                if recordingsList[i].isPlaying == true {
                    stopPlaying(url: recordingsList[i].fileURL)
                }
                recordingsList.remove(at: i)
                
                break
            }
        }
    }
    
    // MARK: 녹음된 날짜 YYMMDD 형식으로 가져오는 함수
    func getFileDate(for file: URL) -> Date {
        if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
            let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
            return creationDate
        } else {
            return Date()
        }
    }
    
    // MARK: 녹음 파일 이름 가져오는 함수
    func getFileName(for file: URL) -> String {
        
        print(file.lastPathComponent)
        return file.lastPathComponent
        
    }
    
    // MARK: recordingsList에 어떤 파일들 있는지 terminal에 보여주는 함수
    // 테스트 과정에서만 사용
    func showFiles() {
        for recording in recordingsList {
            print(DateToString(recording.createdAt))
        }
        print(recordingsList.count)
    }
    
    // MARK: recordingsList에 있는 녹음 파일들 다 삭제하는 함수
    // 녹음 완료 후 다시 녹음 버튼 누르면 실행됨
    func deleteAllRecordings() {
        
        for i in 0..<recordingsList.count {
            do {
                try FileManager.default.removeItem(at: recordingsList[i].fileURL)
            } catch {
                print("can't delete")
            }
        }
        recordingsList.removeAll()
        print("deleted")
    }
    
    // MARK: 현재 녹음파일을 보낼 수 있는 상태인지 확인
    // 제목 & 녹음파일 모두 있어야지 보낼 수 있음
    func cantSend() -> Bool {
        var check: Bool = false
        
        if title.isEmpty || recordingsList.isEmpty {
            check = true
        } else {
            check = false
        }
        return check
    }
    
}
