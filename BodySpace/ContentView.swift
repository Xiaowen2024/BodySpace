//
//  ContentView.swift
//  BodySpace
//
//  Created by Xiaowen Yuan on 7/6/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        NavigationStack{
            
            
            NavigationLink(destination: ScreeningView()) {
                Text("Analyze")
                    .padding()
                    .frame(width: 120, height: 40)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .padding()
            }
         
            NavigationLink(destination: ScreeningView()) {
                Text("Exercise")
                    .padding()
                    .frame(width: 120, height: 40)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .padding()
                   
            }
            //        VStack {
            //            Model3D(named: "Scene", bundle: realityKitContentBundle)
            //                .padding(.bottom, 50)
            //
            //
            //            Toggle("Pose Screen", isOn: $showImmersiveSpace)
            //                .toggleStyle(.button)
            //                .padding(.top, 50)
            //        }
            //        .padding()
            //        .onChange(of: showImmersiveSpace) { _, newValue in
            //            Task {
            //                if newValue {
            //                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
            //                    case .opened:
            //                        immersiveSpaceIsShown = true
            //                    case .error, .userCancelled:
            //                        fallthrough
            //                    @unknown default:
            //                        immersiveSpaceIsShown = false
            //                        showImmersiveSpace = false
            //                    }
            //                } else if immersiveSpaceIsShown {
            //                    await dismissImmersiveSpace()
            //                    immersiveSpaceIsShown = false
            //                }
            //            }
            //        }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
