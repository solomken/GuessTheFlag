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
    
    @State private var questionCounter = 1 //make the game show only 8 questions
    @State private var showingResults = false
    
    @State private var coutries = allCountries.shuffled()
    static let allCountries = ["Estonia", "Poland", "UK", "US", "Monaco", "Spain", "Germany", "France", "Ireland", "Italy", "Ukraine"]
    
    @State private var correctAnswer = Int.random(in: 0...2) //3 flags so correct answer is one of them 3
    
    @State private var score = 0

    @State private var selectedFlag = -1
    
    struct FlagImage: View {
        let imageName: String
        
        var body: some View {
            Image(imageName)
                .renderingMode(.original) //because it's a button Swift can use blue accent color for the image to show that element is clickable. here we block this functionality
                .clipShape(Capsule())
                .shadow(radius: 5)
        }
    }
    
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
                            FlagImage(imageName: coutries[number])
                                .rotation3DEffect(.degrees(selectedFlag == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                                .opacity(selectedFlag == -1 || selectedFlag == number ? 1 : 0.25)
                                .saturation(selectedFlag == -1 || selectedFlag == number ? 1 : 0.25)
                                .animation(.default, value: selectedFlag)
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
        
        .alert("Game over!", isPresented: $showingResults) {
            Button("Start new game", action: newGame)
        } message: {
            Text("Bro your final score was \(score)")
        }
    }
    
    func flagTapped (_ number: Int) {
        
        selectedFlag = number
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            let needThe = ["UK", "US"]
            let theirAnswer = coutries[number]
            
            if needThe.contains(theirAnswer) {
                scoreTitle = "Wrong! That’s the flag of the \(theirAnswer)"
            } else {
                scoreTitle = "Wrong! That’s the flag of \(theirAnswer)"
            }
            
            if score > 0 {
                score -= 1
            }
        }
        
        if questionCounter == 8 {
            showingResults = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        coutries.remove(at: correctAnswer) //we removing here countries which was correct guessed by user so countries will not be repeated while 1 game session
        coutries = coutries.shuffled()
        correctAnswer = Int.random(in: 0...2)
        questionCounter += 1
        selectedFlag = -1
    }
    
    func newGame() {
        score = 0
        questionCounter = 0
        coutries = Self.allCountries //here we are resetting array of the countries before asking new question
        selectedFlag = -1
        askQuestion()
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
