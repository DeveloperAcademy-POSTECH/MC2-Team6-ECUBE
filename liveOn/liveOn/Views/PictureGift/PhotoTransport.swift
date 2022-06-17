//
//  PhotoTransport.swift
//  liveOn
//
//  Created by Jisu Jang on 2022/06/17.
//

import SwiftUI

struct PhotoTransport: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.background)
                .ignoresSafeArea()
            VStack(spacing: 20) {
            Image("TransportSucceed")
                
                Text("상대방에게 선물이 배송되었어요!")
                    .foregroundColor(.mainBrown)
                
                NavigationLink(destination: GiftBoxView()
                    .environmentObject(User())
                    .environmentObject(ImageViewModel())) {
                    Text("보관함으로 돌아가기")
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .frame(width: 300, height: 50, alignment: .center)
                        .background(Color.crimson)
                        .cornerRadius(12)
                }
            }
        }
        .navigationTitle("배송완료")
        .navigationBarTitleDisplayMode(.inline)
        .navigationToBack(dismiss)
    }
}

struct PhotoTransport_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        PhotoTransport()
        }
    }
}