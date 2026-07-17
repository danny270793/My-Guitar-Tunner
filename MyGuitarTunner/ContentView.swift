//
//  ContentView.swift
//  MyGuitarTunner
//
//  Created by Danny Vaca on 16/7/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HomeView()
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        NavigationLink {
                            AboutView()
                        } label: {
                            Image(systemName: "info.circle")
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
