//
//  WelcomMatchingView.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/18.
//

import SwiftUI

struct WelcomMatchingView: View {
    @EnvironmentObject var currentUser: User
    var body: some View {
        VStack {
        OnboardingHeader(title: "커플 매칭 완료!", description: "소중한 추억 쌓으러 가볼까요?", inputView: AnyView(VStack {
            Image("successMatching")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width*0.5, alignment: .center)
            Spacer()
            NavigationLink(destination: GiftBoxView()
                .navigationBarHidden(true)
                .environmentObject(currentUser))
                { Text("시작하기")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center).background(RoundedRectangle(cornerRadius: 10).fill(Color.accentColor))
                }.buttonStyle(.plain)
            
        }))
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        
        
    }
}

struct WelcomMatchingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        WelcomMatchingView()
                .environmentObject(User())
        }
    }
}
