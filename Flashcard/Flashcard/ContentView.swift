//
//  ContentView.swift
//  Flashcard
//
//  Created by Tamara Russell on 10/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var cards: [Card] = Card.mockedCards
    @State private var cardsToPractice: [Card] = [] // <-- Store cards removed from cards array
    @State private var cardsMemorized: [Card] = [] // <--
    @State private var deckId: Int = 0
    @State private var createCardViewPresented = false
    var body: some View {
    

            // Card deck
            ZStack {
                // Reset buttons
                VStack { // <-- VStack to show buttons arranged vertically behind the cards
                   Button("Reset") { // <-- Reset button with title and action
                       cards = cardsToPractice + cardsMemorized // <-- Reset the cards array with cardsToPractice and cardsMemorized
                       cardsToPractice = [] // <-- set both cardsToPractice and cardsMemorized to empty after reset
                       cardsMemorized = [] // <--
                       deckId += 1 // <-- Increment the deck id
                   }
                   .disabled(cardsToPractice.isEmpty && cardsMemorized.isEmpty)

                   Button("More Practice") { // <-- More Practice button with title and action
                       cards = cardsToPractice // <-- Reset the cards array with cardsToPractice
                       cardsToPractice = [] // <-- Set cardsToPractice to empty after reset
                       deckId += 1 // <-- Increment the deck id
                   }
                   .disabled(cardsToPractice.isEmpty)
               }
                ForEach(0..<cards.count, id: \.self) { index in
                    CardView(card: cards[index], onSwipedLeft: { // <-- Add swiped left property
                        let removedCard = cards.remove(at: index) // <-- Get the removed card
                         cardsToPractice.append(removedCard) // <-- Add removed card to cards to practice array
                    }, onSwipedRight: { // <-- Add swiped right property
                        let removedCard = cards.remove(at: index) // <-- Get the removed card
                        cardsMemorized.append(removedCard) // <-- Add removed card to memorized cards array
                    })
                        .rotationEffect(.degrees(Double(cards.count - 1 - index) * -5))
                }
            }
            .animation(.bouncy, value: cards)
            .id(deckId) // <-- Add an id modifier to the main card deck ZStack
            .sheet(isPresented: $createCardViewPresented, content: {
                Text("Create cards here...")
            }
                   )
            .frame(maxWidth: .infinity, maxHeight: .infinity) // <-- Force the ZStack frame to expand as much as possible (the whole screen in this case)
            .overlay(alignment: .topTrailing) { // <-- Add an overlay modifier with top trailing alignment for its contents
                Button("Add Flashcard", systemImage: "plus") {  // <-- Add a button to add a flashcard
                    createCardViewPresented.toggle() // <-- Toggle the createCardViewPresented value to trigger the sheet to show
                }
            }
        }
}

#Preview {
    ContentView()
}
