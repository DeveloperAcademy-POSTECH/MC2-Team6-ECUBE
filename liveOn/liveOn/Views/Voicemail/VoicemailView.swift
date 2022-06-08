//
//  VoicemailView.swift
//  liveOn
//
//  Created by 이성민 on 2022/06/04.
//

import SwiftUI

struct VoicemailView: View {
    @State var title: String = ""
    
    let nowDate = Date.now
    
    var body: some View {
        VStack {
            TextField("제목을 입력하세요", text: $title)
                .multilineTextAlignment(.center)
                .frame(width: 150, height: 20)
            Text(DateToString(_:nowDate))
        }
    }
}

struct VoicemailView_Previews: PreviewProvider {
    static var previews: some View {
        VoicemailView(title: "")
    }
}
