//
//  SidebarView.swift
//  cion
//
//  Created by Rahul K M on 06/03/24.
//

import SwiftUI

struct SidebarView: View {
    @Binding var showSignInView: Bool

    var body: some View {
        List {
            NavigationLink(destination: SettingsView(showSignInView: $showSignInView)) {
                Label("Settings", systemImage: "gearshape")
            }
        }
        .listStyle(.sidebar)
        .frame(minWidth: 200, maxWidth: .infinity)
    }
}
