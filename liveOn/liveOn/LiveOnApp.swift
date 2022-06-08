//
//  liveOnApp.swift
//  liveOn
//
//  Created by 이성민 on 2022/06/03.
//

import SwiftUI

@main
struct LiveOnApp: App {
    @StateObject var imageModel = imageViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(imageModel)

        }
    }
}
