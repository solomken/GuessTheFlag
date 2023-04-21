//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Anastasiia Solomka on 21.04.2023.
//

import SwiftUI

struct FlagImage: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original) //because it's a button Swift can use blue accent color for the image to show that element is clickable. here we block this functionality
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(imageName: "Ukraine")
    }
}
