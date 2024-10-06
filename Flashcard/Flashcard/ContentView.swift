//
//  ContentView.swift
//  Flashcard
//
//  Created by Tamara Russell on 10/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var cards: [Card] = Card.mockedCards
    var body: some View {
    

            // Card deck
            ZStack {
                ForEach(0..<cards.count, id: \.self) { index in
                    CardView(card: cards[index], onSwipedLeft: { // <-- Add swiped left property
                        cards.remove(at: index) // <-- Remove the card from the cards array
                    }, onSwipedRight: { // <-- Add swiped right property
                        cards.remove(at: index) // <-- Remove the card from the cards array
                    })
                        .rotationEffect(.degrees(Double(cards.count - 1 - index) * -5))
                }
            }
            .animation(.bouncy, value: cards)
        }
}

#Preview {
    ContentView()
}
