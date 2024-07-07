//
//  BodySpaceApp.swift
//  BodySpace
//
//  Created by Xiaowen Yuan on 7/6/24.
//

import SwiftUI

@main
struct BodySpaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
