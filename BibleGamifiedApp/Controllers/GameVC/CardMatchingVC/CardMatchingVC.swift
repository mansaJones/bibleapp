//
//  ViewController.swift
//  MatchApp
//
//  Created by Nitisha on 12/22/19.
//  Copyright © 2019 Nitisha. All rights reserved.
//

import UIKit

class CardMatchingVC: BaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var btnPausePlay: UIButton!
    @IBOutlet weak var btnMuteUnMute: UIButton!
    @IBOutlet weak var viewProgress: ProgressView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var timerLabel: UILabel!

    var model = CardModel()
    var cardArray = [Card]()
    var firstFlippedCardIndex: IndexPath?
    var isPushToVC = false
    var objGamesDataModel: GamesDataModel?
    var intGameLifeLeft = Utility.shared.intGameLife
    var  arrGames = [AllGames]()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureOnViewDidLoad()
    }

    // MARK: Private Methods
    fileprivate func manageMuteUnmuteBG() {
        if UDSettings.isSoundPlaying {
            self.btnMuteUnMute.setImage(R.image.ic_unMute_btn(), for: .normal)
        } else {
            self.btnMuteUnMute.setImage(R.image.ic_mute(), for: .normal)
        }
    }

    private func configureOnViewDidLoad() {
        arrGames = Utility.shared.arrAllGames

        Utility.shared.totalGameDuration = Float(objGamesDataModel?.timer ?? 0)

        // delegate - for any events that happen in the grid
        collectionView.delegate = self

        // data source - for the data that is going to power the grid
        collectionView.dataSource = self

        let flowLayout = UICollectionViewFlowLayout()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.minimumLineSpacing = Device.current.isXSeriesDevice ? 30 : 15
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flowLayout

        // Call the getCards() method of the CardModel
        cardArray = model.getCards()

        // schedule timer

        // Keep the timer running when scrolling
        RunLoop.main.add(viewProgress.timer!, forMode: .common)

        viewProgress.timerBlock = { (actionType, timer) in
            switch actionType {

            case .timeStart:
                self.timerLabel.text = timer
            case .timeEnd:
                self.intGameLifeLeft = 0
                self.showSucessScreen(isSucesss: true)
            }
        }

        self.manageMuteUnmuteBG()
    }

    func timerInvalid() {
        collectionView.isUserInteractionEnabled = false
        viewProgress.timerInvalid()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isPushToVC = false
        // Or to rotate and lock
        self.view.isUserInteractionEnabled = true
        AppUtility.lockOrientation(.landscapeRight, andRotateTo: .landscapeRight)
        self.manageMuteUnmuteBG()

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewProgress.timer?.invalidate()
        viewProgress.timer = nil
        AppUtility.lockOrientation(.landscapeRight, andRotateTo: .landscapeRight)

    }

    override func viewDidAppear(_ animated: Bool) {

        SoundManager.playSound(.shuffle)
    }

    // MARK: - UICollectionView Protocol methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // IndexPath - describes which cell the collection view is asking for
        // Try to get a cell that it can reuse or create a new one

        // Cast as CardCollectionViewCell -> able to access setCards method
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell

        // Get the card that the collection view is trying to display
        // Row property in the index path - indicates which item it is trying to display
        let card = cardArray[indexPath.row]

        // Set that card for the cell
        cell.setCard(card)

        return cell
    }

    // When the user taps on a cell - capture that information
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // Check if there's any time left
        if viewProgress.counter <= 0 || !viewProgress.timer!.isValid {
            return
        }

        // Get the cell that the user selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell

        // Get the card that the user selected
        let card = cardArray[indexPath.row]

        if card.isFlipped == false && card.isMatched == false {

            // Flip the card
            cell.flip()
            card.isFlipped = true       // Set the status of the card

            // Play the flip sound
            SoundManager.playSound(.flip)

            // Determine if it's the first card or the second card that's flipped over
            if firstFlippedCardIndex == nil {
                // If this is the first card being flipped

                firstFlippedCardIndex = indexPath
            } else {
                // This is the second card being flipped
                collectionView.isUserInteractionEnabled = false
                Utility.delay(1.8) {
                    collectionView.isUserInteractionEnabled = true
                    // Perform the matching logic
                    self.checkforMatches(indexPath)
                }

            }
        }
    } // End of didSelectItemAt func

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = Device.current.isXSeriesDevice ? CGFloat(30) : CGFloat(15)
        let itemWidth =   ((collectionView.bounds.size.width - spacing - spacing)/3)
        return CGSize(width: itemWidth, height: (collectionView.bounds.size.height - 10)/2)
    }

    @IBAction func btnPlayPauseClick(_ sender: UIButton) {
        if viewProgress.counter <= 0 {
            return
        }
        if sender.isSelected {
            collectionView.isUserInteractionEnabled = true
            viewProgress.scheduleTimer()
        } else {
            collectionView.isUserInteractionEnabled = false
            timerInvalid()
        }
        sender.isSelected = !sender.isSelected
    }

    @IBAction func btnMuteClick(_ sender: UIButton) {

        if UDSettings.isSoundPlaying {
            Utility.shared.pauseSound()
        } else {
            Utility.shared.playSound()
        }
        self.manageMuteUnmuteBG()
    }

    // MARK: - Game logic methods

    func checkforMatches(_ secondFlippedCardIndex: IndexPath) {

        self.intGameLifeLeft  =  self.intGameLifeLeft - 1

        // Get the cells for the two cards that were revealed

        // as? - sometimes it cannot find the flipped card index items?
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell

        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell

        // Get the cards for the two cards that were revealed
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]

        // Compare the two cards
        if cardOne.imageName == cardTwo.imageName {

            // It's a match
            // Play the match sound
            SoundManager.playSound(.match)

            // Set the statuses of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true

            // Remove the cards from the grid

            // Optional chaining - if cardonecell is nil, it will not call the remove method
            // cardOneCell?.remove()
            // cardTwoCell?.remove()

            // Check if there are cards left unmatched
            checkGameEnded()
        } else {

            // It's not a match
            // Play the no match sound
            SoundManager.playSound(.nomatch)

            // Set the statuses of the cards
            cardOne.isFlipped = false
            cardTwo.isFlipped = false

            // Flip the cards back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()

            self.showSucessScreen(isSucesss: self.intGameLifeLeft == 0 ? true : false)

        }

        // Tell the collectionview to reload the cell of the first card if it is nil
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }

        // Reset the property that sets the firstFlippedCardIndex
        firstFlippedCardIndex = nil

    } // End of checkForMatches

    /// Show sucess screen while game match object
    func showSucessScreen(isSucesss: Bool, isGameWon: Bool = false ) {
        self.view.isUserInteractionEnabled = false
        Utility.delay(0) {
            if isSucesss {
                if let resultVC = R.storyboard.game.successLevelVC() {
                    resultVC.objGamesDataModel = self.objGamesDataModel
                    resultVC.successRattingCount =   isGameWon ? self.viewProgress.getGameStarCount():  self.intGameLifeLeft == 0 ? 0 : self.viewProgress.getGameStarCount()
                    resultVC.restartGameBlock = { (gameModel) in
                        if let objetc = gameModel {
                            if let randomElement = self.arrGames.randomElement() {
                                if  let index = self.arrGames.firstIndex(of: randomElement) {
                                    self.arrGames.remove(at: index)
                                }
                                Utility.showGames(randomElement: randomElement, VC: self, objGameLevel: objetc)
                            }
                        }

                        /* old code

                        self.view.isUserInteractionEnabled = true
                        self.collectionView.isUserInteractionEnabled = true
                        self.btnPausePlay.isUserInteractionEnabled = true
                        self.viewProgress.totaHeight = 0
                        self.objGamesDataModel = gameModel
                        Utility.shared.totalGameDuration = Float(self.objGamesDataModel?.timer ?? 0)
                        self.viewProgress.progressContant.constant = 0
                        // Call the getCards() method of the CardModel
                        self.firstFlippedCardIndex = nil
                        self.cardArray.removeAll()
                        self.intGameLifeLeft = Utility.shared.intGameLife
                        self.cardArray = self.model.getCards()
                        self.collectionView.reloadData()
                        self.viewProgress.counter = Utility.shared.totalGameDuration
                        self.viewProgress.scheduleTimer()
                         */

                    }
                    self.presentVC(controller: resultVC)
                }
            } else {
                if let resultVC = R.storyboard.game.resultVC() {
                    self.isPushToVC = true
                    resultVC.lifeUsed = self.intGameLifeLeft
                    resultVC.imgSelected = UIImage(named: self.cardArray[self.firstFlippedCardIndex?.row ?? 0].imageName)!
                    self.isPushToVC = true
                    self.timerInvalid()

                    resultVC.playaginBlock = {
                        self.collectionView.isUserInteractionEnabled = true
                        self.btnPausePlay.isUserInteractionEnabled = true
                        self.viewProgress.scheduleTimer()
                    }
                    self.btnPausePlay.isUserInteractionEnabled = false
                    self.collectionView.isUserInteractionEnabled = false
                    self.pushVC(controller: resultVC)
                }
            }
        }

    }
    func checkGameEnded() {

        // Determine if there are any cards unmatched
        var isWon = true

        for card in cardArray {
            if card.isMatched == false {
                isWon = false
                break
            }
        }

        // Message variables
        var title = ""
        var message = ""

        // If not - user has won, stop the timer
        if isWon == true {
            if viewProgress.counter > 0 {
                //                viewProgress.counter = 0
                timerInvalid()
            }
            title = "Congratulations"
            message = "You've Won!"
            showSucessScreen(isSucesss: true, isGameWon: true)
        } else {
            // If there are unmatched cards, check if there is any time left
            if viewProgress.counter > 0 {
                return              // There is still time left
            }
            self.intGameLifeLeft = 0
            self.showSucessScreen(isSucesss: self.intGameLifeLeft == 0 ? true : false)
            title = "Game Over"
            message = "You've Lost :("
        }

        // Show won/lost message
        print("final left timer  = \(self.viewProgress.counter)")

    }

    func showAlert(_ title: String, _ message: String) {

        // Alert message to display
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // Let the user get rid of the message by pressing "Okay"

        // let alertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: {_ -> Void in
            // self.resetApp()

        })

        alert.addAction(alertAction)

        // Present the message
        present(alert, animated: true, completion: nil)
    }

    // TODO: Add "Play Again" and "Exit" alert buttons

    // Reset the app after the user presses "OK"
    func resetApp() {
        UIApplication.shared.windows[0].rootViewController = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateInitialViewController()
    }

} // End of view controller class
