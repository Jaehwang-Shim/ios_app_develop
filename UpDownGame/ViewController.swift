//
//  ViewController.swift
//  UpDownGame
//
//  Created by Jaehwang on 6/10/24.
//

import UIKit

class ViewController: UIViewController {

    var randomValue: Int = 0
    var tryCount: Int = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tryCountLabel: UILabel!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var minimumValueLabel: UILabel!
    @IBOutlet weak var maximumValueLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        slider.setThumbImage(#imageLiteral(resourceName: "slider_thumb.png"), for: .normal)
        reset()
    }
    
    @IBAction func sliderValueChanged(_ sender : UISlider) {
        print(sender.value)
        let integerValue: Int = Int(sender.value)
        sliderValueLabel.text = String(integerValue)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) {
            (action) in self.reset()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func touchUpHitButton(_ sender: UIButton) {
        print(slider.value, "Hit")
        let hitValue : Int = Int(slider.value)
        slider.value = Float(hitValue)
        tryCount = tryCount + 1
        tryCountLabel.text = "\(tryCount) / 5"
        if tryCount == 5 {
            if randomValue == hitValue {
                print("You Hit!!")
                showAlert(message: "You Hit!!")
                reset()
            }
            else {
                print("You loseㅜㅜ")
                showAlert(message: "You Loseㅜㅜ")
                reset()
            }
        }
        
        if randomValue == hitValue {
            print("You Hit!!")
            showAlert(message: "You Hit!!")
            reset()
        } else if randomValue != hitValue {
            if hitValue < randomValue {
                slider.minimumValue = Float(hitValue)
                minimumValueLabel.text = "\(hitValue)"
            } else {
                slider.maximumValue = Float(hitValue)
                maximumValueLabel.text = "\(hitValue)"
            }
        }
    }
    
    @IBAction func touchUpResetButton(_ sender: UIButton) {
        reset()
    }
    
    func reset() {
        print("reset!")
        randomValue = Int.random(in: 0...30)
        tryCount = 0
        tryCountLabel.text = "0 / 5"
        slider.minimumValue = 0
        slider.maximumValue = 30
        slider.value = 15
        minimumValueLabel.text = "0"
        maximumValueLabel.text = "30"
        sliderValueLabel.text = "15"
    }
    
}

