//
//  padelApp.swift
//  padel
//
//  Created by Manuel Teixeira on 04/06/2023.
//

import SwiftUI

@main
struct padelApp: App {
    let games = [
        Game(
            date: Date(),
            players: [.init(name: "Roberto"), .init(name: "Alfredo")],
            court: .init(
                name: "Pavilhão 1",
                address: "Porto"
            )
        ),
        Game(
            date: Date(),
            players: [.init(name: "Ramiro")],
            court: .init(
                name: "Pavilhão 1",
                address: "Porto"
            )
        ),
        Game(
            date: Date(),
            players: [],
            court: .init(
                name: "Pavilhão 1",
                address: "Porto"
            )
        )
    ]
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView(gameList: games)
            }
        }
    }
}
