//
//  ContentView.swift
//  padel
//
//  Created by Manuel Teixeira on 04/06/2023.
//

import SwiftUI
import SwiftData

@Model
final class Player: Identifiable {
    @Attribute(.unique) let id = UUID()
    var name: String

    var game: Game

    init(name: String) {
        self.name = name
    }
}

@Model
final class Court {
    var name: String
    var address: String

    var game: Game

    init(name: String, address: String) {
        self.name = name
        self.address = address
    }
}

@Model
final class Game: Identifiable {
    @Attribute(.unique) let id = UUID()
    var date: Date
    @Relationship(.cascade, inverse: \Player.game)
    var players: [Player]
    @Relationship(.cascade, inverse: \Court.game)
    var court: Court

    init(date: Date, player: [Player], court: Court) {
        self.date = date
        self.players = players
        self.court = court
    }
}

struct ContentView: View {
    @Query var gameList: [Game]
    @Environment(\.modelContext) private var modelContext

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
        .toolbar {
            ToolbarItem {
                Button {
                    let item = Game(
                        date: Date(),
                        player: [
                            .init(name: "Roberto"),
                            .init(name: "Joaquim")
                        ],
                        court: .init(
                            name: "Pavilhão 1",
                            address: "Porto"
                        )
                    )
                    modelContext.insert(item)
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
