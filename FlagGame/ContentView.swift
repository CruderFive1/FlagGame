//
//  ContentView.swift
//  FlagGame
//
//  Created by Adrian Senften on 05.12.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var gameOver = false
    @State private var scoreTitel = ""
    
    @State private var userScore = 0
    @State private var gamesPlayed = 1
    
    
    var body: some View {
        ZStack {
//            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) {number in
                        Button {
                            //flag was tapped
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitel, isPresented: $showingScore) {
            Button("Continue", action: gameLenght )
        } message: {
            Text("Your score is \(userScore)")
        }
        
        .alert("Game Over", isPresented: $gameOver) {
                    Button("Restart", action: restartGame)
                } message: {
                    Text("You've completed 8 games. Your final score is \(userScore).")
                }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitel = "Correct"
            userScore += 1
        } else {
            scoreTitel = "Wrong"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
    
    func gameLenght() {
        // control  the length of the game
        if gamesPlayed < 8 {
            gamesPlayed += 1
            print(gamesPlayed)
            askQuestion()
        } else {
            print("Done")
            gameOver = true
        }
    }
    
    func restartGame() {
        // Reset game-related variables and start a new game
        gamesPlayed = 1
        userScore = 0
        askQuestion()
    }
    
}

#Preview {
    ContentView()
}
