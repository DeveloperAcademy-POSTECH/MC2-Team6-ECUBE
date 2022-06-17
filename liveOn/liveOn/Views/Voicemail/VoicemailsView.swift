//
//  VoicemailListView_.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/16.
//

import SwiftUI

struct VoicemailsView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
    
        if voiceMailDummy.count > 8 {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Spacer()
                VStack(alignment: .trailing, spacing: 16) {
                    ForEach(voiceMailDummy) { vm in
                        VoicemailCassette(voiceMail: vm)
                    }
                    //            }
                    //            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    //            .background(.blue)
                }
                .padding(12)
                .border(.thinMaterial, width: 1)
                .background(.regularMaterial)
                .padding(16)
               
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("카세트테이프")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.background)
        }
    } else {
        VStack {
            Spacer()
            VStack(alignment: .trailing, spacing: 16) {
                ForEach(voiceMailDummy) { vm in
                    VoicemailCassette(voiceMail: vm)
                }
                //            }
                //            .frame(maxWidth: .infinity, maxHeight: .infinity)
                //            .background(.blue)
            }
            .padding(12)
            .border(.thinMaterial, width: 1)
            .background(.regularMaterial)
            .padding(16)
           
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("카세트테이프")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.background)
        .navigationBarBackButtonHidden(true)
        .navigationToBack(dismiss)
    }
    
    }
}

var voiceMailDummy = [
    Voicemail(title: "재허나뭐해잉", createDate: "220616", whoSent: MailConstants.user1, vmBackgroundColor: MailConstants.green, vmIconImageName: "flower", soundLength: "00:48"),
    Voicemail(title: "유지나뭐해잉", createDate: "220314", whoSent: MailConstants.user2, vmBackgroundColor: MailConstants.orange, vmIconImageName: "flower", soundLength: "00:39"),
    Voicemail(title: "유sdf잉", createDate: "220314", whoSent: MailConstants.user2, vmBackgroundColor: MailConstants.orange, vmIconImageName: "flower", soundLength: "00:39"),
    Voicemail(title: "유지나뭐fsd잉", createDate: "220314", whoSent: MailConstants.user2, vmBackgroundColor: MailConstants.orange, vmIconImageName: "flower", soundLength: "00:39"),
    Voicemail(title: "유지나뭐해잉", createDate: "220314", whoSent: MailConstants.user2, vmBackgroundColor: MailConstants.orange, vmIconImageName: "fdsower", soundLength: "00:39"),
    Voicemail(title: "유지나뭐해잉", createDate: "220314", whoSent: MailConstants.user2, vmBackgroundColor: MailConstants.orange, vmIconImageName: "flower", soundLength: "00:39"),
    Voicemail(title: "유지나뭐해잉", createDate: "220314", whoSent: MailConstants.user2, vmBackgroundColor: MailConstants.orange, vmIconImageName: "flower", soundLength: "00:39")

]

struct VoicemailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VoicemailsView()
        }
    }
}
