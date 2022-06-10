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
    
    var indexOfPlayer = 0
    
    @Published var isRecording: Bool = false
    @Published var isRecorded: Bool = false
    @Published var recordingsList = [Recording]()
    
    @Published var countSec = 0
    @Published var timerCount: Timer?
    @Published var blinkingCount: Timer?
    @Published var timer: String = "0:00"
    @Published var toggleColor: Bool = false
    
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
    
    func startRecording() {
        
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Cannot setup the Recording")
        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = path.appendingPathComponent("CO-Voice : \(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).m4a")
        
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
            blinkColor()
            
        } catch {
            print("Failed to Setup the Recording")
        }
    }
    
    func stopRecording() {
        
        audioRecorder.stop()
        
        isRecording = false
        
        self.countSec = 0
        
        timerCount!.invalidate()
        blinkingCount!.invalidate()
        
    }
    
    func fetchAllRecording() {
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)

        for i in directoryContents {
            recordingsList.append(Recording(fileURL: i, createdAt: getFileDate(for: i), isPlaying: false))
        }
        
        recordingsList.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending})
        
    }
    
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
    

    // 제작한 Recordings 재생중인 것 멈추기
    func stopPlaying(url: URL) {
        
        audioPlayer.stop()
        
        for i in 0..<recordingsList.count {
            if recordingsList[i].fileURL == url {
                recordingsList[i].isPlaying = false
            }
        }
    }
 
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
    
    func blinkColor() {
        
        blinkingCount = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (_) in
            self.toggleColor.toggle()
        })
        
    }
    
    func getFileDate(for file: URL) -> Date {
        if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
            let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
            return creationDate
        } else {
            return Date()
        }
    }
    
    func showFiles() {
        for recording in recordingsList {
            print(DateToString(recording.createdAt))
        }
        print(recordingsList.count)
    }
    
    func deleteAllRecordings() {
        
        for i in 0..<recordingsList.count {
            do {
                try FileManager.default.removeItem(at: recordingsList[i].fileURL)
            } catch {
                print("can't delete")
            }
        }
        
        recordingsList.removeAll()
        
//        do {
//            try FileManager.default.removeItem(at: url)
//        } catch {
//            print("Can't delete")
//        }
        
//        for i in 0..<recordingsList.count {
//            do {
//                if recordingsList[i].isPlaying == true {
//                    stopPlaying(url: recordingsList[i].fileURL)
//                }
//                recordingsList.remove(at: i)
//                print("\(i) removed")
//            } catch {
//                print("\(i) removing error")
//            }
//
//        }
//        recordingsList.removeAll()
    }
    
    func deleteFirstRecording() {
        
    }
    
}
