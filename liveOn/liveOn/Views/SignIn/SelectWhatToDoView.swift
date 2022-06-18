//
//  SelectWhatToDoView.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/08.
//

import SwiftUI

struct SelectWhatToDoView: View {
    
    @EnvironmentObject var currentUser: User
    @Environment(\.dismiss) private var dismiss
    @State var showEnterCodeSheet: Bool = false
    @State private var showShareSheet = false
    
    var body: some View {
        OnboardingHeader(title: "상대방 초대하기!", description: "상대가 앱을 설치하고 초대코드를 입력하면 서로를 이어드릴게요.", inputView:
                            AnyView(
                                VStack {
                                    VStack {
                                        Text("\(currentUser.userCode)")
                                            .font(.title)
                                            .fontWeight(.heavy)
                                            .textSelection(.enabled)
                                            .frame(width: 268, height: 170, alignment: .center)
                                            .background(RoundedRectangle(cornerRadius: 20).fill(Color(uiColor: .systemBackground)).shadow(color: .bodyTextColor.opacity(0.3), radius: 6, x: 0, y: 2))
                                            .padding(.top, 40)
                                        Button{
                                            showShareSheet.toggle()
                                        }
                                    label:{
                                        copyButton
                                    }
                                    .sheet(isPresented: $showShareSheet) {
                                        ShareSheet(activityItems: [ MyActivityItemSource(title: "liveOn 초대코드 보내기", text: "똑똑! \(currentUser.nickname)님으로부터 초대장이 왔어요! liveOn앱에서 초대코드를 입력해주세요 :) 초대코드 : [ \(currentUser.userCode) ]")])
                                           }
                                        
                                        
                                    }
                                    Spacer()
                                    // TODO: 액티비티 시트 연결(공유)
//                                    NavigationLink(destination: EnterCodeView().environmentObject(currentUser)) {
//                                        Text("이미 초대코드가 있어요")
//                                            .fontWeight(.bold)
//                                            .padding()
//                                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.bodyTextColor).opacity(0.1))
//                                    }// nav link
                                    Button{
                                        showEnterCodeSheet.toggle()
                                    }
                                label: {
                                    Text("이미 초대코드가 있어요")
                                        .fontWeight(.bold)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.bodyTextColor).opacity(0.1))
                                }
                                        .fullScreenCover(isPresented: $showEnterCodeSheet){
                                            EnterCodeView().environmentObject(currentUser)
                                        }
                                }.frame(maxWidth: .infinity))
                         
        )
        .background(Color.background)
        .navigationToBack(dismiss)
    }
  
      var copyButton: some View {
      
            Text("초대코드 보내기")
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 18)
                .background( RoundedRectangle(cornerRadius: 4)
                    .fill(Color.accentColor)
                )
                .padding(.top, 10)
    }
}

struct SelectWhatToDoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SelectWhatToDoView()
                .environmentObject(User())
        }
    }
}

