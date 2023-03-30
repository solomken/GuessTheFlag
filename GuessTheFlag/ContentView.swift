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
//            RadialGradient(stops: [
//                .init(color: .indigo, location: 0.3),
//                .init(color: .mint, location: 0.3)
//            ], center: .top, startRadius: 200, endRadius: 700)
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the flag")
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
            Text("Bro your score is \(score)")
        }
        
        .alert(gameOverTitle, isPresented: $showingGameOver) {
            Button("Start new game", action: gameReset)
        } message: {
            Text("Bro your score is \(score)")
        }
    }
    
    func flagTapped (_ number: Int) {
        questionCounter += 1
        
        scoreTitle = "Wrong! That’s the flag of \(coutries[number])"
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        }
        
        if questionCounter < 8 {
            showingScore = true
        } else {
            if score > 4 {
                gameOverTitle += "Good job bro!"
            } else {
                gameOverTitle += "Will be better next time bro!"
            }
            
            gameOverTitle += "\n\n" + scoreTitle
            showingGameOver = true
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
        askQuestion()
        gameOverTitle = ""
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
