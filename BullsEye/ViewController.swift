//
//  ViewController.swift
//  BullsEye
//
//  Created by Christopher Franco on 8/22/21.
//

import UIKit

class ViewController: UIViewController {
    
  @IBOutlet var slider: UISlider! //variable "slider" connected to the UI slider
    
  @IBOutlet var targetLabel: UILabel! //variable "targetLable" connected to UI lable showing target
    
  @IBOutlet var scoreLabel: UILabel!
    
  @IBOutlet var roundLabel: UILabel!
    
    

  var currentValue = 0  //var to hold value of silders current pos as a 1-100 number
    
  var targetValue = 0 //var to hold random 1 - 100 goal the user will seek
    
  var score = 0 //point accumulator to hold scores
    
  var round = 0 //accumulator to hold the number of rounds

  override func viewDidLoad() {
    super.viewDidLoad()

    let thumbImageNormal = UIImage(named: "SliderThumb-Normal")! //slider image of bulleye when not pressed
    slider.setThumbImage(thumbImageNormal, for: .normal)

    let thumbImageHighlighted = UIImage( //slider image of bulleye when pressed
      named: "SliderThumb-Highlighted")!
    slider.setThumbImage(thumbImageHighlighted, for: .highlighted)

    let insets = UIEdgeInsets(
      top: 0,
      left: 14,
      bottom: 0,
      right: 14)

    let trackLeftImage = UIImage(named: "SliderTrackLeft")! //left side (green) of slider
    let trackLeftResizable = trackLeftImage.resizableImage(
      withCapInsets: insets)
    slider.setMinimumTrackImage(trackLeftResizable, for: .normal)

    let trackRightImage = UIImage(named: "SliderTrackRight")! //right side (gray) of slider
    let trackRightResizable = trackRightImage.resizableImage(
      withCapInsets: insets)
    slider.setMaximumTrackImage(trackRightResizable, for: .normal)

    startNewGame()
  }

    
  @IBAction func showAlert() {  //displays results once "hit me" button is pressed
    
    let difference = abs(targetValue - currentValue) // determines how close user was to goal
    
    var points = 100 - difference // creates score based on how close user got

    let title: String //Title message for window
    
    if difference == 0 { // Correct guess will give 100 extra points
      title = "Perfect!"
      points += 100
    } else if difference < 5 { // message for within 5
      title = "You almost had it!"
      if difference == 1 { // difference of +- 1 of goal gives 50 extra points
        points += 50
      }
    } else if difference < 10 { //message for within 10
      title = "Pretty good!"
    } else { // everything +10 gets this message
      title = "Not even close..."
    }
    
    score += points //adds points for round to current score
    
    let message = "You scored \(points) points" // tells user score

    let alert = UIAlertController(
      title: title, //displays titles based on closeness of guess
      message: message, //display message based on closeness of guess
      preferredStyle: .alert)

    let action = UIAlertAction(
      title: "OK",
      style: .default) {_ in
      self.startNewRound() //starts new round once alert dismissed
    }

    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
  }

  @IBAction func sliderMoved(_ slider: UISlider) {
    currentValue = lroundf(slider.value) //slider value rounded to nearest whole number
  }

  @IBAction func startNewGame() {
    score = 0 //starts/resets score to 0
    round = 0 //starts/resets round to 0
    startNewRound() //calls function to start new round
    
    let transition = CATransition() //code for crossfade animations
    transition.type = CATransitionType.fade
    transition.duration = 1
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    view.layer.add(transition, forKey: nil)
  }
    
    

  func startNewRound() {
    round += 1 //adds 1 to current rounds counter
    targetValue = Int.random(in: 1...100) //generates target goal for user
    currentValue = 50 //default slider pos
    slider.value = Float(currentValue)
    updateLabels()
  }
    
    

  func updateLabels() {
    targetLabel.text = String(targetValue) //updates target goal for user
    scoreLabel.text = String(score) //updates score totals
    roundLabel.text = String(round) // updates round totals
  }
}
