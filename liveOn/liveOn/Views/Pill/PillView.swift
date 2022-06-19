//
//  PillView.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/07.
//

import SwiftUI

struct PillView: View {
    
    // MARK: Property
    @ObservedObject var input =  TextLimiter(limit: 40, placeholder: "짧은 메시지도 남겨볼까요?")
    @State var showAlertforSend: Bool = false
    @State var isitEntered: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack {
                PillBodyView()
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .navigationTitle("약")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button {
            showAlertforSend = true
        } label: {
            Text("선물하기")
                .fontWeight(.bold)
        }
            .disabled(input.inputEntered))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    } // body
}

struct PillBodyView: View {
    @Environment(\.dismiss) var dismiss
    // MARK: Property
    @State private var pillImageCounter: Int = 0
    @State private var pillName: String = ""
    @State private var pillEffect: String = ""
    @State private var isShowingPopover = false
    @State private var whatPill: String = "1"
    
    var popOverTip: some View {
        ZStack(alignment: .bottom) {
            Image(systemName: "arrowtriangle.down.fill")
                .frame(width: 30, height: 30, alignment: .bottom)
                .foregroundColor(Color(hex: "efefef"))
                .offset(y: -1)
                .shadow(color: .gray.opacity(0.4), radius: 3, x: 0, y: 1)
            Text("탭해서 다른 약으로 바꾸기")
                .foregroundColor(.gray)
                .padding(.vertical, 10)
                .padding(.horizontal, 18)
                .background( RoundedRectangle(cornerRadius: 4)
                    .fill(Color(hex: "efefef"))
                )
                .padding(.bottom, 10)
            
        }
        
        .padding(.top, 12)
        
    }
    
    var body: some View {
        VStack {
            // Sample data
            VStack(alignment: .leading, spacing: 12) {
                if isShowingPopover {
                    popOverTip
                        .onTapGesture {
                            withAnimation(.spring()) {
                                isShowingPopover.toggle()
                            }
                        }
                }
            }
            .frame(height: 36)
            .padding(.bottom, 24)
            
            Image("medicine0"+whatPill)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(24)
                .frame(width: 200, height: 200, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 20).fill(.thinMaterial))
                .padding(.bottom, 64)
                .onTapGesture {
                    withAnimation(.spring()) {
                        whatPill = String(Int.random(in: 0 ..< 9))
                    }
                }
            
            VStack(alignment: .center, spacing: 4) {
                TextField("어떤 약인가요?", text: $pillName)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .frame(width: 150, height: 56, alignment: .center)
                
                Divider()
                    .frame(width: 150, height: 2)
                    .padding(.horizontal, 32)
                    .background(pillName.count < 12 ? .gray : .red)
                
                // Message string counter
                Text("(\(pillName.count)/12)")
                    .font(.caption)
                    .foregroundColor(pillName.count < 12 ? .gray : .red)
                    .fontWeight(pillName.count < 12 ? .medium : .bold)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            } // Group
            TextField("약 효과를 적어보세요", text: $pillEffect)
                .foregroundColor(.bodyTextColor)
                .font(.body)
                .multilineTextAlignment(.center)
                .frame(height: 56, alignment: .center)
            
            Divider()
                .frame(height: 2)
                .padding(.horizontal, 32)
                .background(pillEffect.count < 40 ? .gray : .red)
            
            // Message string counter
            Text("(\(pillEffect.count)/40)")
                .font(.caption)
                .foregroundColor(pillEffect.count < 40 ? .gray : .red)
                .fontWeight(pillEffect.count < 40 ? .medium : .bold)
                .frame(maxWidth: .infinity, alignment: .trailing)
            Spacer()
        } // body
        .padding(.top, 48)
        .padding(.horizontal, 16)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.4).delay(0.1)) {
                isShowingPopover.toggle()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .navigationToBack(dismiss)
    } // VStack
    
} // body

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PillView()
        }
    }
}
