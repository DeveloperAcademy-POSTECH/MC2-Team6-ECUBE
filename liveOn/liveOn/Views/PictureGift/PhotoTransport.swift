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
            
            VStack(spacing: 20) {
                
                // TODO: 스케치 이미지 빼고 제대로 된 일러스트 작업해서 넣기
                Image("TransportSucceed")
                    .frame(width: 240)
                
                VStack {
                    
                    Text("상대방에게 선물이 배송되었어요!")
                        .font(.caption)
                        .foregroundColor(.mainBrown)
                        .padding(.vertical)
                    
                    NavigationLink(destination: GiftBoxView()
                        .environmentObject(User())
                        .environmentObject(ImageViewModel())) {
                            
                            Text("보관함으로 돌아가기")
                                .foregroundColor(.white)
                                .bold()
                                .padding()
                                .frame(width: 300, height: 60, alignment: .center)
                                .background(Color.crimson)
                                .cornerRadius(12)
                        }
                    
                } // VStack
            } // VStack
        } // ZStack
        .navigationTitle("배송완료")
        .navigationBarTitleDisplayMode(.inline)
        .navigationToBack(dismiss)
        .background(.background)
        .ignoresSafeArea()
        
    } // body
}

struct PhotoTransport_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PhotoTransport()
        }
    }
}
