//
//  ContentView.swift
//  padel
//
//  Created by Manuel Teixeira on 04/06/2023.
//

import SwiftUI

struct Player: Identifiable {
    let id = UUID()
    let name: String
}

struct Court {
    let name: String
    let address: String
}

struct Game: Identifiable {
    let id = UUID()
    let date: Date
    let players: [Player]
    let court: Court
}

struct ContentView: View {
    var gameList: [Game]
    var body: some View {
        List {
            ForEach(gameList) { game in
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "tennisball.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                        Text(game.court.name)
                            .font(.caption)
                    }

                    HStack {
                        Text(game.date.formatted(.dateTime.hour().minute()))
                            .font(.headline)

                        Spacer()

                        Text("Slots: \(4 - game.players.count)")
                            .font(.headline)
                    }

                    VStack(alignment: .leading) {
                        ForEach(game.players) { player in
                            Text("\(Image(systemName: "person.fill")) \(player.name)")
                                .font(.caption)
                        }
                    }
                }
                .listRowBackground(game.players.first?.name == "Roberto" ? Color.orange : Color.white)
            }
            .frame(maxWidth: .infinity)
            .swipeActions(edge: .leading, content: {
                Button("I'm in") {
                    
                }
                .tint(Color.green)
                Button("I'm out") {
                    
                }
                .tint(Color.red)
            })
        }
        .navigationTitle("Padel")
    }
}

struct ContentView_Previews: PreviewProvider {
    static let games = [
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

    static var previews: some View {
        NavigationStack {
            ContentView(gameList: games)
        }
    }
}
