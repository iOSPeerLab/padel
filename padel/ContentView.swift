//
//  ContentView.swift
//  padel
//
//  Created by Manuel Teixeira on 04/06/2023.
//

import SwiftData
import SwiftUI

@Model
final class Player: Identifiable {
    var name: String
    var game: Game?

    init(name: String) {
        self.name = name
    }
}

@Model
final class Court {
    var name: String
    var address: String

    var game: Game?

    init(name: String, address: String) {
        self.name = name
        self.address = address
    }
}

@Model
final class Game: Identifiable {
    var date: Date
    
    @Relationship(.cascade, inverse: \Player.game)
    var players: [Player] = []
    
    @Relationship(.cascade, inverse: \Court.game)
    var court: Court

    init(date: Date, players: [Player], court: Court) {
        self.date = date
        self.players = players
        self.court = court
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var gameList: [Game]

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
                Button("I'm in") {}
                    .tint(Color.green)
                Button("I'm out") {}
                    .tint(Color.red)
            })
        }
        .navigationTitle("Padel")
        .toolbar {
            ToolbarItem {
                Button {
                    let player = Player(name: "Roberto")
                    let game = Game(
                        date: Date(),
                        players: [player],
                        court: .init(
                            name: "Pavilhão 1",
                            address: "Porto"
                        )
                    )
                    player.game = game
                    modelContext.insert(game)
                } label: {
                    Text("Add")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
