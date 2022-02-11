//
//  MainDashboardItem.swift
//  BibleGamifiedApp
//
//  Created by indianic on 23/11/21.
//

import UIKit

struct DataClass {
    let imageName: String

    static let imagesArray: [DataClass] = {
        let image1 = DataClass.init(imageName: "rightImg")
        return [image1]
    }()
}

class DragDropData {
    var rightImage = ""
    var displayImage = ""
    var fileddipslayImage = ""

}

class DragDropModel {

     func getData() -> [DragDropData] {

        // Declare an array to store the numbers that are already generated
        var generatedNumbersArray = [Int]()

        // Declare an array to store the generated cards
        var generatedCardsArray = [DragDropData]()

        // Randomly generate pairs of cards
        while generatedNumbersArray.count < 7 {

            // Get a random number
            let randomNumber = arc4random_uniform(19) + 1      // gives us randoms from 0 to 20

            // Ensure that the random number is unique
            if generatedNumbersArray.contains(Int(randomNumber)) == false {

                // Log the number
                print(randomNumber)

                // Store the number in the generatedNumbersArray
                generatedNumbersArray.append(Int(randomNumber))

                // Create the first card object
                let cardOne = DragDropData()

                cardOne.rightImage = "ic_animal_\(randomNumber)"
                cardOne.displayImage = "ic_animal_\(randomNumber).\(randomNumber)"
                cardOne.fileddipslayImage = "ic_animal_\(randomNumber).\(randomNumber).\(randomNumber)"
                generatedCardsArray.append(cardOne)
            }

        }
        // Randomize the array
        for i in 0...generatedCardsArray.count - 1 {

            // Find a random index
            let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))

            // Swap two cards
            let temporaryStorage = generatedCardsArray[i]
            generatedCardsArray[i] = generatedCardsArray[randomNumber]
            generatedCardsArray[randomNumber] = temporaryStorage

        }
        // Return the array
        return generatedCardsArray
    }

}
