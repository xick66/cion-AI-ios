//
//  RootView.swift
//  cion
//
//  Created by Rahul K M on 05/03/24.
//


//import SwiftUI
//
//struct RootView: View {
//    @State private var showSignInView: Bool = false
//    @State private var showSettingsView: Bool = false
//
//    var body: some View {
//        NavigationView {
//            if !showSignInView {
//                ContentView()
//                    .toolbar { // Move the toolbar inside the ContentView
//                        ToolbarItemGroup(placement: .navigationBarLeading) {
//                            Button(action: {
//                                self.showSettingsView.toggle()
//                            }) {
//                                Image(systemName: "line.3.horizontal")
//                            }
//                        }
//                    }
//            } else {
//                AuthenticationView(showSignInView: $showSignInView)
//            }
//        }
//        .onAppear {
//            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
//            self.showSignInView = authUser == nil
//        }
//        .fullScreenCover(isPresented: $showSignInView) {
//            AuthenticationView(showSignInView: $showSignInView)
//        }
//        .sheet(isPresented: $showSettingsView) {
//            SettingsView(showSignInView: $showSignInView)
//        }
//        .navigationViewStyle(.stack)
//    }
//}

import SwiftUI

struct RootView: View {
    @State private var showSignInView: Bool = false
    @State private var showSettingsView: Bool = false

    var body: some View {
        NavigationView {
            if !showSignInView {
                ContentView()
                    .toolbar { // Move the toolbar inside the ContentView
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            Button(action: {
                                self.showSettingsView.toggle()
                            }) {
                                Image(systemName: "line.3.horizontal")
                            }
                        }
                    }
            } else {
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            AuthenticationView(showSignInView: $showSignInView)
        }
        .sheet(isPresented: $showSettingsView) {
            SettingsView(showSignInView: $showSignInView)
        }
        .navigationViewStyle(.stack)
    }
}



struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

