//
//  GiftBoxView.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/04.
//

import SwiftUI

struct GiftBoxView: View {
    @StateObject var storedLetter = LetterStore()
    @StateObject var storedEvent = EventStore()
    
    @EnvironmentObject var imageModel: ImageViewModel
    @EnvironmentObject var currnetUser: User
    
//    @State var gotoMain: Bool = false
    @State var toCreateView: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 0) {
                header
                    .frame(height: proxy.size.height*0.2)
                voicemailAndLetter
                    .frame(height: proxy.size.height*0.25)
                medicineAndFlower
                    .frame(height: proxy.size.height*0.25)
                albumAndCalendar
                    .frame(height: proxy.size.height*0.3)
                Spacer()
            }
            .background(Color.background)
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
    
    // MARK: 상단 헤더 영역
    var header: some View {
        HStack(alignment: .center, spacing: 0) {
            coupleInfo
            Spacer()
            NavigationLink(destination: CreateGiftListView(gotoMain: $toCreateView).environmentObject(storedLetter), isActive: $toCreateView) {
                Image(systemName: "gift")
                    .font(.title2)
                    .foregroundColor(.bodyTextColor)
                    .frame(width: 48, height: 48, alignment: .bottom)
                    .padding(.vertical)
                    .onTapGesture {
                        toCreateView = true
                    }
            }
            .background(.yellow)
            .buttonStyle(.plain)
        }
        .padding(16)
    }
    
    // MARK: 이름+사귄 디데이 계산 정보
    // TODO: 유저 네임, 사귄날 데이터로 디데이 계산
    var coupleInfo: some View {
        NavigationLink(destination: CoupleInformation()) {
            HStack(alignment: .center, spacing: 12) {
                Text("\(currnetUser.nickname)")
                Image("heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                Text("유진")
                HStack(alignment: .center, spacing: 1) {
                    
                    Text("+ \(countDays(from: currnetUser.firstDay ?? Date()))")
                        .fontWeight(.semibold)
                }
                .foregroundColor(Color("Orange"))
                
            }
            .setHandWritten()
            .font(.subheadline)
            .foregroundColor(Color.bodyTextColor)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke())
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 10).fill(.thinMaterial).shadow(color: Color(uiColor: .systemGray4), radius: 5, x: 1, y: 2))
            .padding(.vertical)
            .offset(y: 10)
        }
        
    }
    
    // MARK: 카세트랑 쪽지
    var voicemailAndLetter: some View {
        HStack {
            NavigationLink(destination: VoicemailsView()) {
                Image("cassettes")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .rotationEffect(.degrees(-5.0))
                    .padding()
            }
            Spacer()
            NavigationLink(destination: LetterListView().environmentObject(storedLetter)) {
                Image("letters")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(0.8)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: 약이랑 꽃
    var medicineAndFlower: some View {
        HStack(alignment: .top) {
            NavigationLink(destination: PillListView()) {
                Image("medicines")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: UIScreen.main.bounds.height * 0.13)
                    .padding(.top, 30)
            }
            Spacer()
            NavigationLink(destination: FlowerListView()) {
                Image("flowers")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: UIScreen.main.bounds.height * 0.4)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: 앨범과 캘린더
    var albumAndCalendar: some View {
        HStack(alignment: .bottom, spacing: 0) {
            NavigationLink(destination: PhotoCardsView()) {
                Image("album")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            NavigationLink(destination: CalendarMain().environmentObject(storedEvent)) {
                Image("calendar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: UIScreen.main.bounds.width*0.5, alignment: .bottomTrailing)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

// struct GiftBoxView_Previews: PreviewProvider {
//    static var previews: some View {
//        GiftBoxView()
//            .environmentObject(imageViewModel())
//            .environmentObject(User())
//    }
// }

func countDays(from date: Date) -> Int {
    let calendar = Calendar.current
    return calendar.dateComponents([.day], from: date, to: Date()).day! + 1
}
