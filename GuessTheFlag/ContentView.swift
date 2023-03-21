//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Anastasiia Solomka on 08.03.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false //alert showing
    @State private var scoreTitle = "" //title on the alert - correct or wrong
    
    @State private var showingGameOver = false
    @State private var gameOverTitle = ""
    
    @State private var coutries = ["Estonia", "Poland", "UK", "US", "Monaco", "Spain", "Germany", "France", "Ireland", "Italy", "Ukraine"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2) //3 flags so correct answer is one of them 3
    
    @State private var score = 0
    @State private var questionCounter = 0 //make the game show only 8 questions
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .indigo, location: 0.3),
                .init(color: .gray, location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack (spacing: 30) {
                    VStack {
                        Text("Tap the flag of") //tap a flag of random country
                            .foregroundColor(.white)
                            .font(.subheadline.weight(.heavy))
                        Text(coutries[correctAnswer]) //country of correct answer
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            
                            if questionCounter == 8 {
                                //flagTapped(number)
                                if score >= 4 {
                                    gameOverTitle = "Good job!"
                                } else {
                                    gameOverTitle = "Will be better next time bro!"
                                }
                                showingGameOver = true
                            }
                        } label: {
                            Image(coutries[number])
                                .renderingMode(.original) //because it's a button Swift can use blue accent color for the image to show that element is clickable. here we block this functionality
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .padding(.vertical, 20)
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.weight(.bold))
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        
        .alert(gameOverTitle, isPresented: $showingGameOver) {
            Button("Start new game", action: gameReset)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped (_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            questionCounter += 1
        } else {
            scoreTitle = "Wrong! That’s the flag of \(coutries[number])"
            questionCounter += 1
        }
        if questionCounter < 8 {
            showingScore = true
        }
    }
    
    func askQuestion() {
        if questionCounter < 8 {
            coutries = coutries.shuffled()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    func gameReset() {
        score = 0
        questionCounter = 0
        coutries = coutries.shuffled()
        correctAnswer = Int.random(in: 0...2)
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
