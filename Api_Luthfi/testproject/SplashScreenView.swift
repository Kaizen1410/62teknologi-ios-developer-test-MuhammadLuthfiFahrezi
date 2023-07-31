//
//  SplashScreenView.swift
//  testproject
//
//  Created by Muhammad Luthfi Fahrezi on 29/07/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.2
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            if isActive {
                ContentView()
            } else {
                VStack {
                    VStack {
                        Image(systemName: "snow")
                            .font(.system(size: 200))
                            .foregroundColor(.yellow)
                        Text("Unknown Apps")
                            .font(.system(size: 25))
                            .bold()
                            .foregroundColor(.white)
                    }
                    .scaleEffect()
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 2.0)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}


struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
