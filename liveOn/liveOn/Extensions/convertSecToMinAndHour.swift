//
//  convertSecToMin.swift
//  liveOn
//
//  Created by 이성민 on 2022/06/09.
//

import Foundation

extension VoiceRecorderVM {
    func covertSecToMinAndHour(seconds: Int) -> String {
        
        let (_, m, s) = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        let sec: String = s < 10 ? "0\(s)" : "\(s)"
        return "\(m):\(sec)"
        
    }
}
