//
//  ViewController.swift
//  iOS102-PreWork
//
//  Created by Vijay Vadi on 11/16/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    @IBOutlet weak var morePetsSwitch: UISwitch!
    @IBOutlet weak var morePetsStepper: UIStepper!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var schoolNameTextField: UITextField!
    
    @IBOutlet weak var yearSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var numberOfPetsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func stepperDidChange(_ sender: UIStepper) {
          numberOfPetsLabel.text = "\(Int(sender.value))"
      }

    @IBAction func introduceSelfDidTapped(_ sender: UIButton) {
        if !(firstNameTextField.text == "" || lastNameTextField.text == "" || schoolNameTextField.text == "") {
            saveData()
            
            let hostingController = UIHostingController(rootView: ContentView())

            hostingController.modalPresentationStyle = .fullScreen
            
            self.present(hostingController, animated: true, completion: nil)
        } else {
                    let alertController = UIAlertController(title: "Enter all Fields", message: "Enter a valid input for all required fields", preferredStyle: .alert)
            
                    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)

                    alertController.addAction(action)

                    present(alertController, animated: true, completion: nil)
        }
    }
    
    func saveData() {
        let defaults = UserDefaults.standard
            
        defaults.set(morePetsSwitch.isOn, forKey: "morePets")
        defaults.set(morePetsStepper.value, forKey: "numberOfPets")

        defaults.set(firstNameTextField.text, forKey: "firstName")
        defaults.set(lastNameTextField.text, forKey: "lastName")
        defaults.set(schoolNameTextField.text, forKey: "schoolName")
            
        defaults.set(yearSegmentedControl.selectedSegmentIndex, forKey: "year")
    }

}

