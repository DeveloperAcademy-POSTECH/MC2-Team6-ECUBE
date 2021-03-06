//
//  liveOnApp.swift
//  liveOn
//
//  Created by 이성민 on 2022/06/03.
//

import SwiftUI

@main
struct LiveOnApp: App {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var imageModel = ImageViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(imageModel)
                .environmentObject(LetterStore())
                .preferredColorScheme(.light)
                .environment(\.colorScheme, .light)
        }
    }
}
