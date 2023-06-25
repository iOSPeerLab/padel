//
//  padelApp.swift
//  padel
//
//  Created by Manuel Teixeira on 04/06/2023.
//

import SwiftUI

@main
struct padelApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
        }
        .modelContainer(for: [Game.self, Player.self, Court.self])
    }
}
