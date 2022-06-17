//
//  VoicemailListAssetView.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/16.
//

import SwiftUI
import Alamofire

struct Voicemail {
    let voiceMailId: Int
    let title: String
    let createDate: String
    let whoSent: String
    let vmBackgroundColor: Color
    let vmIconImageName: String
    let soundLength: String
}

struct mailConstants {
    static let user1 = "재헌"
    static let user2 = "유진"
    static let green = Color(hex: "717339")
    static let orange = Color(hex: "A6633C")
}

// 카세트 하나 뷰
struct VoicemailCassette: View {
    
//    @Binding var isShowPopUp: Bool
    
    let voiceMail: Voicemail
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Rectangle()
                    .fill(Color(hex: "F2F0F0"))
                    .frame(width: 10, height: 60, alignment: .center)
                
                HStack {
                    Image(voiceMail.vmIconImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44, alignment: .center)
                    
                    // MARK: 정보부분
                    VStack(alignment: .leading, spacing: 4) {
                        Text(voiceMail.title)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        HStack {
                            Text(voiceMail.createDate)
                            Spacer()
                            Text("from. \(voiceMail.whoSent)")
                        }
                    }
                    .font(.caption)
                    .opacity(0.9)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
                    .background(voiceMail.vmBackgroundColor)
                    .foregroundColor(.white)
                    
                    VStack(alignment: .center) {
                        if Int(voiceMail.soundLength)! < 10 {
                        Text("00:0\(voiceMail.soundLength)")
                            .rotationEffect(.degrees(-90.0))
                            .font(.caption)
                            .foregroundColor(.bodyTextColor)
                        } else {
                            Text("00:\(voiceMail.soundLength)")
                                .rotationEffect(.degrees(-90.0))
                                .font(.caption)
                                .foregroundColor(.bodyTextColor)
                        }
                    }
                }
                .background(.thinMaterial)
                .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
            }
            Rectangle()
                .fill(Color(uiColor: .systemGray5))
                .frame(width: .infinity, height: 4, alignment: .leading)
        }
        .border(.thinMaterial, width: 3)
        .border(.white, width: 2)
        .border(.thinMaterial, width: 2)
        .overlay(Rectangle().fill(.regularMaterial).opacity(0.2))
    }
}
