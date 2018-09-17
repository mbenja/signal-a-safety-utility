//
//  ViewController.swift
//  Signal
//
//  Created by Benjamin Streit on 7/2/16.
//  Copyright © 2016 Benjamin Streit. All rights reserved.
//

import UIKit
import MessageUI
import ContactsUI
import CoreLocation
import QuartzCore

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate, CNContactPickerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var btnSignal: UIButton!
    @IBOutlet weak var btnRecipients: UIButton!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnChangePasscode: UIButton!
    @IBOutlet weak var lblRecipientInfo: UILabel!
    @IBOutlet weak var lblPasscodeInfo: UILabel!
    @IBOutlet weak var lblSwipeInfo: UILabel!
    @IBOutlet weak var lblMessageInfo: UILabel!
    
    var recipients: [NSString] = [NSString]()
    let locationManager = CLLocationManager()
    var userLocation = ""
    let safetyGradient = UIImage(named: "safety_gradient.png")! as UIImage
    let distressGradient = UIImage(named: "distress_gradient.png")! as UIImage
    var count: UInt32 = 0
    var currentState = ""
    var signalSent = "NO"
    var gpsNotice = "NO"
    var infoUp = "NO"
    var instructionsTimer = NSTimer?()
    var contactStore = CNContactStore()
    
    func swipedRight() {
        let savedButtonTitle = NSUserDefaults.standardUserDefaults()
        currentState = btnSignal.currentTitle!
        if signalSent == "NO" {
            if currentState == "Distress Signal" {
                btnSignal.setTitle("Test Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 0
                    self.lblMessageInfo.alpha = 0
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Test Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(safetyGradient, forState: .Normal)
            } else if currentState == "Test Signal" {
                btnSignal.setTitle("Fire Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 0
                    self.lblMessageInfo.alpha = 0
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Fire Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(distressGradient, forState: .Normal)
            } else if currentState == "Fire Signal" {
                btnSignal.setTitle("Medical Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 0
                    self.lblMessageInfo.alpha = 0
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Medical Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(distressGradient, forState: .Normal)
            } else if currentState == "Medical Signal" {
                btnSignal.setTitle("Crime Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 0
                    self.lblMessageInfo.alpha = 0
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Crime Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(distressGradient, forState: .Normal)
            } else if currentState == "Crime Signal" {
                btnSignal.setTitle("Distress Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 1
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Distress Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(distressGradient, forState: .Normal)
                if infoUp == "YES" {
                    self.btnMessage.alpha = 1
                    self.lblMessageInfo.alpha = 1
                }
            }
        } else {
            if currentState == "Test Signal" {
                btnSignal.setTitle("Fire Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 0
                    self.lblMessageInfo.alpha = 0
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Fire Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(distressGradient, forState: .Normal)
            } else if currentState == "Fire Signal" {
                btnSignal.setTitle("Medical Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 0
                    self.lblMessageInfo.alpha = 0
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Medical Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(distressGradient, forState: .Normal)
            } else if currentState == "Medical Signal" {
                btnSignal.setTitle("Crime Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 0
                    self.lblMessageInfo.alpha = 0
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Crime Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(distressGradient, forState: .Normal)
            } else if currentState == "Crime Signal" {
                btnSignal.setTitle("Distress Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 1
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Distress Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(distressGradient, forState: .Normal)
                if infoUp == "YES" {
                    self.btnMessage.alpha = 1
                    self.lblMessageInfo.alpha = 1
                }
            } else if currentState == "Distress Signal" {
                btnSignal.setTitle("Safety Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 0
                    self.lblMessageInfo.alpha = 0
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                btnSignal.setBackgroundImage(safetyGradient, forState: .Normal)
            } else if currentState == "Safety Signal" {
                btnSignal.setTitle("Test Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 0
                    self.lblMessageInfo.alpha = 0
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Test Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(safetyGradient, forState: .Normal)
            }
        }
    }
    
    func swipedLeft() {
        currentState = btnSignal.currentTitle!
        if signalSent == "NO" {
            if currentState == "Distress Signal" {
                btnSignal.setTitle("Crime Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 0
                    self.lblMessageInfo.alpha = 0
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Crime Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(distressGradient, forState: .Normal)
            } else if currentState == "Crime Signal" {
                btnSignal.setTitle("Medical Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 0
                    self.lblMessageInfo.alpha = 0
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Medical Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(distressGradient, forState: .Normal)
            } else if currentState == "Medical Signal" {
                btnSignal.setTitle("Fire Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 0
                    self.lblMessageInfo.alpha = 0
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Fire Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(distressGradient, forState: .Normal)
            } else if currentState == "Fire Signal" {
                btnSignal.setTitle("Test Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 0
                    self.lblMessageInfo.alpha = 0
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Test Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(safetyGradient, forState: .Normal)
            } else if currentState == "Test Signal" {
                btnSignal.setTitle("Distress Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 1
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Distress Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(distressGradient, forState: .Normal)
                if infoUp == "YES" {
                    self.btnMessage.alpha = 1
                    self.lblMessageInfo.alpha = 1
                }
            }
        } else {
            if currentState == "Distress Signal" {
                btnSignal.setTitle("Crime Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 0
                    self.lblMessageInfo.alpha = 0
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Crime Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(distressGradient, forState: .Normal)
            } else if currentState == "Crime Signal" {
                btnSignal.setTitle("Medical Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 0
                    self.lblMessageInfo.alpha = 0
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Medical Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(distressGradient, forState: .Normal)
            } else if currentState == "Medical Signal" {
                btnSignal.setTitle("Fire Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 0
                    self.lblMessageInfo.alpha = 0
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Fire Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(distressGradient, forState: .Normal)
            } else if currentState == "Fire Signal" {
                btnSignal.setTitle("Test Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 0
                    self.lblMessageInfo.alpha = 0
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Test Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(safetyGradient, forState: .Normal)
            } else if currentState == "Test Signal" {
                btnSignal.setTitle("Safety Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 0
                    self.lblMessageInfo.alpha = 0
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                btnSignal.setBackgroundImage(safetyGradient, forState: .Normal)
            } else if currentState == "Safety Signal" {
                btnSignal.setTitle("Distress Signal", forState: .Normal)
                UIView.animateWithDuration(0.2, animations: {
                    self.btnMessage.alpha = 1
                })
                btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.btnSignal.transform = CGAffineTransformIdentity
                    }, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject("Distress Signal", forKey: "MySavedButtonTitle")
                btnSignal.setBackgroundImage(distressGradient, forState: .Normal)
                if infoUp == "YES" {
                    self.btnMessage.alpha = 1
                    self.lblMessageInfo.alpha = 1
                }
            } else {
                return
            }
        }
    }
    
    // GET RECIPIENT LIST
    func getRecipients() {
        let alertController = UIAlertController(title: "Select contacts", message: "These contacts will receive all signals.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.ButtonRecipients(nil)
        }
        
        alertController.addAction(dismissAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // USER INPUT INCORRECT PASSCODE ON SEND
    func incorrectPassOnSignal() {
        let savedRecipients = NSUserDefaults.standardUserDefaults()
        let savedPass = NSUserDefaults.standardUserDefaults()
        
        var tField: UITextField!
        
        func configurationTextField(textField: UITextField!)
        {
            textField.placeholder = "Your passcode"
            tField = textField
            tField.keyboardType = UIKeyboardType.NumberPad
            tField.secureTextEntry = true
        }
        
        let alert = UIAlertController(title: "Enter passcode to unlock access to safety signal", message: "Incorrect passcode!", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            print("passcode cancelled")
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            if (tField.text == savedPass.stringForKey("MySavedPass")) {
                alert.dismissViewControllerAnimated(true, completion: nil)
                let composeVC = MFMessageComposeViewController()
                composeVC.messageComposeDelegate = self
                composeVC.body = "I am safe." + "\n" + "\n" + self.userLocation + "\n" + "\n" + "Sent via Signal"
                composeVC.recipients = savedRecipients.stringArrayForKey("MySavedRecipients")
                // Present the view controller modally.
                
                self.presentViewController(composeVC, animated: true, completion: nil)
            } else {
                self.incorrectPassOnSignal()
            }
        }))
        self.presentViewController(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    // USER INPUT INCORRECT PASSCODE ON CHANGE
    func incorrectPassOnChange() {
        let savedPass = NSUserDefaults.standardUserDefaults()
        
        var tField: UITextField!
        
        func configurationTextField(textField: UITextField!)
        {
            textField.placeholder = "Your current passcode"
            tField = textField
            tField.keyboardType = UIKeyboardType.NumberPad
            tField.secureTextEntry = true
            tField.textAlignment = NSTextAlignment.Center
        }
        
        let alert = UIAlertController(title: "Enter current passcode", message: "Incorrect passcode!", preferredStyle: UIAlertControllerStyle.Alert)
    
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            if (tField.text == savedPass.stringForKey("MySavedPass")) {
                self.setPass()
            } else {
                alert.dismissViewControllerAnimated(true, completion: nil)
                self.incorrectPassOnChange()
            }
        }))
        self.presentViewController(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    // USER INPUT PASSWORDS THAT DON'T MATCH ON CHANGE
    func PasscodesDoNotMatch() {
        var tField: UITextField!
        var tField2: UITextField!
        
        func configurationTextField(textField: UITextField!)
        {
            textField.placeholder = "Enter passcode"
            tField = textField
            tField.keyboardType = UIKeyboardType.NumberPad
            tField.secureTextEntry = true
            tField.textAlignment = NSTextAlignment.Center
            
        }
        
        func configurationTextField2(textfield: UITextField!)
        {
            textfield.placeholder = "Reenter passcode"
            tField2 = textfield
            tField2.keyboardType = UIKeyboardType.NumberPad
            tField2.secureTextEntry = true
            tField2.textAlignment = NSTextAlignment.Center
        }
        
        
        
        let alert = UIAlertController(title: "Create passcode", message: "Passcodes do not match!", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addTextFieldWithConfigurationHandler(configurationTextField2)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            if (tField.text == "" || tField.text?.characters.count < 4) {
                self.setPass()
            } else if (tField.text != tField2.text) {
                self.PasscodesDoNotMatch()
            } else {
                _ = NSUserDefaults.standardUserDefaults()
                NSUserDefaults.standardUserDefaults().setObject(tField.text, forKey: "MySavedPass")
            }
        }))
        self.presentViewController(alert, animated: true, completion: {
            print("completion block")
        })

    }
    
    // SETTING PASSCODE ON CHANGE
    func setPasscodeForChange() {
        var tField: UITextField!
        var tField2: UITextField!
        
        func configurationTextField(textField: UITextField!)
        {
            textField.placeholder = "Enter passcode"
            tField = textField
            tField.keyboardType = UIKeyboardType.NumberPad
            tField.secureTextEntry = true
            tField.textAlignment = NSTextAlignment.Center
            
        }
        
        func configurationTextField2(textfield: UITextField!)
        {
            textfield.placeholder = "Reenter passcode"
            tField2 = textfield
            tField2.keyboardType = UIKeyboardType.NumberPad
            tField2.secureTextEntry = true
            tField2.textAlignment = NSTextAlignment.Center
        }
        
        
        
        let alert = UIAlertController(title: "Create passcode", message: "This passcode will be requested when signalling for safety. Use at least four characters.", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addTextFieldWithConfigurationHandler(configurationTextField2)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            if (tField.text == "" || tField.text?.characters.count < 4) {
                self.setPass()
            } else if (tField.text != tField2.text) {
                self.PasscodesDoNotMatch()
            } else {
                _ = NSUserDefaults.standardUserDefaults()
                NSUserDefaults.standardUserDefaults().setObject(tField.text, forKey: "MySavedPass")
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:{ (UIAlertAction) in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    // SETTING INITIAL PASSCODE
    func setPass() {
        var tField: UITextField!
        var tField2: UITextField!
        
        func configurationTextField(textField: UITextField!)
        {
            textField.placeholder = "Enter passcode"
            tField = textField
            tField.keyboardType = UIKeyboardType.NumberPad
            tField.secureTextEntry = true
            tField.textAlignment = NSTextAlignment.Center
            
        }
        
        func configurationTextField2(textfield: UITextField!)
        {
            textfield.placeholder = "Reenter passcode"
            tField2 = textfield
            tField2.keyboardType = UIKeyboardType.NumberPad
            tField2.secureTextEntry = true
            tField2.textAlignment = NSTextAlignment.Center
        }
        
        
        
        let alert = UIAlertController(title: "Create passcode", message: "This passcode will be requested when signalling for safety. Use at least four characters.", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addTextFieldWithConfigurationHandler(configurationTextField2)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            if (tField.text == "" || tField.text?.characters.count < 4) {
                self.setPass()
            } else if (tField.text != tField2.text) {
                self.PasscodesDoNotMatch()
            } else {
                _ = NSUserDefaults.standardUserDefaults()
                NSUserDefaults.standardUserDefaults().setObject(tField.text, forKey: "MySavedPass")
                
                let savedRecipients = NSUserDefaults.standardUserDefaults()
                if savedRecipients.stringForKey("MySavedRecipients") == "" {
                    self.getRecipients()
                }
            }
        }))
        self.presentViewController(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
    // UPDATING SIGNAL BUTTON
    func updateSignalButtonName() {
        let savedButtonTitle = NSUserDefaults.standardUserDefaults()
        
        if (btnSignal.currentTitle == "Distress signal sent") {
            btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                self.btnSignal.transform = CGAffineTransformIdentity
                self.btnSignal.setBackgroundImage(self.safetyGradient, forState: .Normal)
                }, completion: nil)
            signalSent = "YES"
            btnSignal.setTitle("Safety Signal", forState: .Normal)
            UIView.animateWithDuration(0.2, animations: {
                self.btnMessage.alpha = 0
            })
        } else {
            btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                self.btnSignal.transform = CGAffineTransformIdentity
                if self.btnSignal.currentTitle == "Test signal sent" {
                    self.btnSignal.setBackgroundImage(self.safetyGradient, forState: .Normal)
                } else {
                    self.btnSignal.setBackgroundImage(self.distressGradient, forState: .Normal)
                }
                }, completion: nil)
            
            signalSent = "NO"
            btnSignal.setTitle(savedButtonTitle.stringForKey("MySavedButtonTitle"), forState: .Normal)
            UIView.animateWithDuration(0.2, animations: {
                if self.btnSignal.currentTitle == "Distress Signal"{
                    self.btnMessage.alpha = 1
                }
            })
        }
    }
    
    // SETTING UP LOCATION MANAGER, REVERSE GEOCODING FROM COORDINATES TO ACHIEVE ACCURATE USER LOCATION WITH APPLICABLE DATA
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationValue : CLLocationCoordinate2D = manager.location!.coordinate
        
        let latitude : CLLocationDegrees = locationValue.latitude
        let longitude : CLLocationDegrees = locationValue.longitude
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                return
            }
            if placemarks!.count > 0 {
                let pmLocation = placemarks![0]
                self.userLocation = pmLocation.subThoroughfare! + " " + pmLocation.thoroughfare! + ", "
                self.userLocation += pmLocation.locality! + ", " + pmLocation.administrativeArea! + ", " + pmLocation.country!
            }
            else {
                return
            }
            })
    }
    
    
    // INITIALIZING MESSAGES OVERLAY FOR FASTER ACCESS UPON REQUEST
    func initializeMessage() {
        _ = MFMessageComposeViewController()
    }
    
    // CALL TO PARSE SELECTED CONTACTS FOR PHONE NUMBERS, ADDING NUMBERS TO ARRAY
    func contactPicker(picker: CNContactPickerViewController,
                       didSelectContacts contacts: [CNContact]) {
        for contact in contacts {
            recipients.append(((contact.phoneNumbers[0].value as! CNPhoneNumber).valueForKey("digits") as? String)!) // FIX THIS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            
            let savedRecipients = NSUserDefaults.standardUserDefaults()
            savedRecipients.setObject(recipients, forKey: "MySavedRecipients")
        }
    }
    
    // CALLING MESSAGES OVERLAY, POPULATING MESSAGE FIELDS AND AWAITING USER INTERACTION, REACTING APPROPRIATELY
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        print("arrived")
        
        switch (result) {
        case MessageComposeResultCancelled:
            controller.dismissViewControllerAnimated(true, completion: nil)
            initializeMessage()
            print("cancelled")
        case MessageComposeResultFailed:
            let failedAlert = UIAlertController(title: "Message failed to send", message: "Check cellular or data settings.", preferredStyle: UIAlertControllerStyle.Alert)
            
            failedAlert.addAction(UIAlertAction(title: "Done", style: .Default, handler: { (action: UIAlertAction!) in
                failedAlert.dismissViewControllerAnimated(true, completion: nil)
            }))
            presentViewController(failedAlert, animated: true, completion: nil)
            print("failed")
        case MessageComposeResultSent:
            controller.dismissViewControllerAnimated(true, completion: nil)
            _ = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: (#selector(ViewController.updateSignalButtonName)), userInfo: nil, repeats: false)
            if (btnSignal.currentTitle == "Distress Signal" || btnSignal.currentTitle == "Crime Signal" || btnSignal.currentTitle == "Medical Signal" || btnSignal.currentTitle == "Fire Signal") {
                btnSignal.setTitle("Distress signal sent", forState: .Normal)
            } else if (btnSignal.currentTitle == "Safety Signal") {
                btnSignal.setTitle("Safety signal sent", forState: .Normal)
            } else if (btnSignal.currentTitle == "Test Signal") {
                btnSignal.setTitle("Test signal sent", forState: .Normal)
            }
            if signalSent == "YES" {
                signalSent = "NO"
            } else {
                signalSent = "YES"
            }
            initializeMessage()
        default:
            break
        }
    }
    
    // CALL FOR CHANGING PASSCODE
    @IBAction func ButtonChangePasscode(sender: AnyObject? = nil) {
        let savedPass = NSUserDefaults.standardUserDefaults()
        
        var tField: UITextField!
        
        func configurationTextField(textField: UITextField!)
        {
            textField.placeholder = "Enter passcode"
            tField = textField
            tField.keyboardType = UIKeyboardType.NumberPad
            tField.secureTextEntry = true
            tField.textAlignment = NSTextAlignment.Center
        }
        
        let alert = UIAlertController(title: "Enter current passcode", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:{ (UIAlertAction)in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            if (tField.text == savedPass.stringForKey("MySavedPass")) {
                self.setPasscodeForChange()
            } else {
                alert.dismissViewControllerAnimated(true, completion: nil)
                self.incorrectPassOnChange()
            }
        }))
        self.presentViewController(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    // CALL FOR INSTRUCTIONS BUTTON ON MAIN VIEW OVERLAY
    @IBAction func ButtonInstructions(sender: AnyObject) {
        infoUp = "YES"
        currentState = btnSignal.currentTitle!
        
        btnRecipients.enabled = false
        btnChangePasscode.enabled = false
        btnMessage.enabled = false
        btnSignal.enabled = false
        
        UIView.animateWithDuration(0.2, animations: {
            self.lblRecipientInfo.alpha = 1
            self.lblPasscodeInfo.alpha = 1
            self.lblSwipeInfo.alpha = 1
            self.btnInfo.alpha = 0
            self.btnDone.alpha = 1
            
            if self.currentState == "Distress Signal" {
                self.lblMessageInfo.alpha = 1
            }
        })
        
    }
    
    // DONE WITH INSTRUCTIONS
    @IBAction func btnDone(sender: AnyObject) {
        infoUp = "NO"
        
        btnRecipients.enabled = true
        btnChangePasscode.enabled = true
        btnMessage.enabled = true
        btnSignal.enabled = true
        
        UIView.animateWithDuration(0.2, animations: {
            self.lblRecipientInfo.alpha = 0
            self.lblPasscodeInfo.alpha = 0
            self.lblSwipeInfo.alpha = 0
            self.lblMessageInfo.alpha = 0
            self.btnInfo.alpha = 1
            self.btnDone.alpha = 0
        })
    }
    
    // CALL FOR MESSAGES BUTTON, ALLOWS ALTERING OF DEFAULT DISTRESS SIGNAL, SAVES INFO ACCORDINGLY
    @IBAction func ButtonMessage(sender: AnyObject) {
        let savedSignal = NSUserDefaults.standardUserDefaults()
        
        let getMessageText = UIAlertController(title: "Enter default message body for distress signal", message: "", preferredStyle: .Alert)
        
        let confirming = UIAlertAction(title: "Confirm", style: .Default) {(_) in
            if let text = getMessageText.textFields![0] as? UITextField {
                NSUserDefaults.standardUserDefaults().setObject(text.text, forKey: "MySavedDistressSignal")
            } else {
                return
            }
        }
        
        let cancelling = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in}
        
        getMessageText.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = savedSignal.stringForKey("MySavedDistressSignal")
        }
        
        getMessageText.addAction(confirming)
        getMessageText.addAction(cancelling)
        
        self.presentViewController(getMessageText, animated: true, completion: nil)
    }
    
    // CALL FOR CONTACTS OVERLAY, SETS UP PARAMETERS TO ONLY ENABLE CONTACTS WITH A PHONE NUMBER AVAILABLE
    @IBAction func ButtonRecipients(sender: AnyObject? = nil) {
        let savedRecipients = NSUserDefaults.standardUserDefaults()
        
        AppDelegate.getAppDelegate().requestForAccess { (accessgranted) -> Void in
            if accessgranted {
                var message : String!
                let addressbookRef = CNContactStore()
                let selectedContacts = CNContactPickerViewController()
                selectedContacts.delegate = self
                
                selectedContacts.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0", argumentArray: nil)
                selectedContacts.predicateForSelectionOfContact = NSPredicate(value: (savedRecipients.stringForKey("MySavedRecipients")?.containsString("name"))!)
                self.presentViewController(selectedContacts, animated: true, completion: nil)
                
                if message != nil {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        AppDelegate.getAppDelegate().showMessage(message)
                    })
                }
                else {
                    return
                }
            }
        }
    }
    
    // CALL TO SEND SIGNAL, PROCEEDS TO THE SEND MESSAGE OVERLAY ACCORDINGLY
    @IBAction func ButtonSignal(sender: AnyObject? = nil) {
        btnSignal.transform = CGAffineTransformMakeScale(0.9, 0.9)
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            self.btnSignal.transform = CGAffineTransformIdentity
            }, completion: nil)
        
        if userLocation == "" {
            userLocation = "Location services are not available."
        }
        
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        let savedRecipients = NSUserDefaults.standardUserDefaults()
        let savedDistressSignal = NSUserDefaults.standardUserDefaults()
        let savedCrimeSignal = NSUserDefaults.standardUserDefaults()
        let savedMedicalSignal = NSUserDefaults.standardUserDefaults()
        let savedFireSignal = NSUserDefaults.standardUserDefaults()
        let savedPass = NSUserDefaults.standardUserDefaults()
        let savedTest = NSUserDefaults.standardUserDefaults()
        
        if (btnSignal.currentTitle == "Distress Signal") {
            // Configure the fields of the interface.
            composeVC.body = savedDistressSignal.stringForKey("MySavedDistressSignal")! + "\n" + "\n" + userLocation + "\n" + "\n" + "Sent via Signal"
            composeVC.recipients = savedRecipients.stringArrayForKey("MySavedRecipients")
            // Present the view controller modally.
            self.presentViewController(composeVC, animated: true, completion: nil)
        } else if (btnSignal.currentTitle == "Crime Signal") {
            // Configure the fields of the interface.
            composeVC.body = savedCrimeSignal.stringForKey("MySavedCrimeSignal")! + "\n" + "\n" + userLocation + "\n" + "\n" + "Sent via Signal"
            composeVC.recipients = savedRecipients.stringArrayForKey("MySavedRecipients")
            // Present the view controller modally.
            self.presentViewController(composeVC, animated: true, completion: nil)
        } else if (btnSignal.currentTitle == "Medical Signal") {
            // Configure the fields of the interface.
            composeVC.body = savedMedicalSignal.stringForKey("MySavedMedicalSignal")! + "\n" + "\n" + userLocation + "\n" + "\n" + "Sent via Signal"
            composeVC.recipients = savedRecipients.stringArrayForKey("MySavedRecipients")
            // Present the view controller modally.
            self.presentViewController(composeVC, animated: true, completion: nil)
        } else if (btnSignal.currentTitle == "Fire Signal") {
            // Configure the fields of the interface.
            composeVC.body = savedFireSignal.stringForKey("MySavedFireSignal")! + "\n" + "\n" + userLocation + "\n" + "\n" + "Sent via Signal"
            composeVC.recipients = savedRecipients.stringArrayForKey("MySavedRecipients")
            // Present the view controller modally.
            self.presentViewController(composeVC, animated: true, completion: nil)
        } else if (btnSignal.currentTitle == "Test Signal") {
            // Configure the fields of the interface.
            composeVC.body = savedFireSignal.stringForKey("MySavedTestSignal")! + "\n" + "\n" + "Sent via Signal"
            composeVC.recipients = savedRecipients.stringArrayForKey("MySavedRecipients")
            // Present the view controller modally.
            self.presentViewController(composeVC, animated: true, completion: nil)
        } else {
            var tField: UITextField!
            
            func configurationTextField(textField: UITextField!)
            {
                textField.placeholder = "Your passcode"
                tField = textField
                tField.keyboardType = UIKeyboardType.NumberPad
                tField.secureTextEntry = true
                tField.textAlignment = NSTextAlignment.Center
            }
            
            let alert = UIAlertController(title: "Enter passcode to unlock access to safety signal", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addTextFieldWithConfigurationHandler(configurationTextField)
            alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
                print("passcode cancelled")
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
                if (tField.text == savedPass.stringForKey("MySavedPass")) {
                    alert.dismissViewControllerAnimated(true, completion: nil)
                    let composeVC = MFMessageComposeViewController()
                    composeVC.messageComposeDelegate = self
                    composeVC.body = "I am safe." + "\n" + "\n" + self.userLocation + "\n" + "\n" + "Sent via Signal"
                    composeVC.recipients = savedRecipients.stringArrayForKey("MySavedRecipients")
                    // Present the view controller modally.
                    
                    self.presentViewController(composeVC, animated: true, completion: nil)
                } else {
                    self.incorrectPassOnSignal()
                }
            }))
            self.presentViewController(alert, animated: true, completion: {
                print("completion block")
            })
        }
    }
    
    // SETTING UP BACKGROUND GRADIENT UPON LOAD, SETTING UP INITIAL RECIPIENT LIST
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let gradient : CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        
        let cor1 = UIColor.init(red: 0, green: 1, blue: 1, alpha: 1)
        let cor2 = UIColor.lightGrayColor().CGColor
        let arrayColors = [cor1, cor2]
        
        gradient.colors = arrayColors as [AnyObject]
        view.layer.insertSublayer(gradient, atIndex: 0)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipedRight))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipedLeft))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        self.btnSignal.clipsToBounds = true
        self.btnSignal.layer.cornerRadius = 60
        
        self.lblRecipientInfo.layer.borderWidth = 0.5
        self.lblRecipientInfo.layer.borderColor = UIColor.whiteColor().CGColor
        self.lblRecipientInfo.layer.cornerRadius = 20
        
        self.lblPasscodeInfo.layer.borderWidth = 0.5
        self.lblPasscodeInfo.layer.borderColor = UIColor.whiteColor().CGColor
        self.lblPasscodeInfo.layer.cornerRadius = 20
        
        self.lblSwipeInfo.layer.borderWidth = 0.5
        self.lblSwipeInfo.layer.borderColor = UIColor.whiteColor().CGColor
        self.lblSwipeInfo.layer.cornerRadius = 20
        
        self.lblMessageInfo.layer.borderWidth = 0.5
        self.lblMessageInfo.layer.borderColor = UIColor.whiteColor().CGColor
        self.lblMessageInfo.layer.cornerRadius = 20
        
        let savedButtonTitle = NSUserDefaults.standardUserDefaults()
        let defaultValueForButtonTitle = ["MySavedButtonTitle": "Distress Signal"]
        savedButtonTitle.registerDefaults(defaultValueForButtonTitle)
        
        if savedButtonTitle.stringForKey("MySavedButtonTitle") == "Test Signal" {
            btnSignal.setTitle(savedButtonTitle.stringForKey("MySavedButtonTitle"), forState: .Normal)
            btnSignal.setBackgroundImage(safetyGradient, forState: .Normal)
            btnMessage.alpha = 0
        } else if savedButtonTitle.stringForKey("MySavedButtonTitle") == "Distress Signal" {
            btnSignal.setTitle(savedButtonTitle.stringForKey("MySavedButtonTitle"), forState: .Normal)
            btnMessage.alpha = 1
        } else {
            btnSignal.setTitle(savedButtonTitle.stringForKey("MySavedButtonTitle"), forState: .Normal)
            btnMessage.alpha = 0
        }
    }
    
    // READING SAVED DEFAULTS, REQUESTING PERMISSIONS, BEGINS GEOCODING IF ALLOWED, ADJUSTS UI STYLING
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        initializeMessage()
        
        let savedFirstTime = NSUserDefaults.standardUserDefaults()
        let defaultValueForFirstTime = ["MySavedFirstTime": "YES"]
        savedFirstTime.registerDefaults(defaultValueForFirstTime)
        
        if savedFirstTime.stringForKey("MySavedFirstTime") == "YES" {
            btnSignal.setTitle("Test Signal", forState: .Normal)
            btnSignal.setBackgroundImage(safetyGradient, forState: .Normal)
            btnMessage.alpha = 0
            NSUserDefaults.standardUserDefaults().setObject("NO", forKey: "MySavedFirstTime")
        }
        
        let savedTestSignal = NSUserDefaults.standardUserDefaults()
        let defaultValueForTestSignal = ["MySavedTestSignal": "This is a test signal sent via the Signal app for iPhone, I have added you to my list of recipients for all distress and safety signals. If this were not a test you would be informed of the type of emergency occuring, as well as my current location, you might also receive a safety signal afterward. Please respond to this message to verify you have received it."]
        savedTestSignal.registerDefaults(defaultValueForTestSignal)
        
        let savedDistressSignal = NSUserDefaults.standardUserDefaults()
        let defaultValueForDistressSignal = ["MySavedDistressSignal": "I need help. This is my current location:"]
        savedDistressSignal.registerDefaults(defaultValueForDistressSignal)
        
        let savedCrimeSignal = NSUserDefaults.standardUserDefaults()
        let defaultValueForCrimeSignal = ["MySavedCrimeSignal": "I need help, call 911, I need the police. This is my current location:"]
        savedCrimeSignal.registerDefaults(defaultValueForCrimeSignal)
        
        let savedMedicalSignal = NSUserDefaults.standardUserDefaults()
        let defaultValueForMedicalSignal = ["MySavedMedicalSignal": "I need help, call 911, I need an ambulance. This is my current location:"]
        savedMedicalSignal.registerDefaults(defaultValueForMedicalSignal)
        
        let savedFireSignal = NSUserDefaults.standardUserDefaults()
        let defaultValueForFireSignal = ["MySavedFireSignal": "I need help, call 911, I need the fire department. This is my current location:"]
        savedFireSignal.registerDefaults(defaultValueForFireSignal)
        
        let savedRecipients = NSUserDefaults.standardUserDefaults()
        let defaultValueForRecipients = ["MySavedRecipients" : ""]
        savedRecipients.registerDefaults(defaultValueForRecipients)
        
        if savedRecipients.stringForKey("MySavedRecipients") == "" {
            self.getRecipients()
        }
        
        let savedPass = NSUserDefaults.standardUserDefaults()
        let defaultValueForPass = ["MySavedPass": ""]
        savedPass.registerDefaults(defaultValueForPass)
        
        if (savedPass.stringForKey("MySavedPass") == "") {
            setPass()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .NotDetermined, .Restricted:
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.requestWhenInUseAuthorization()
            case .AuthorizedAlways, .AuthorizedWhenInUse:
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            case .Denied:
                if gpsNotice == "NO" {
                    gpsNotice = "YES"
                    let alertController = UIAlertController(title: "Notice", message: "Location services are not enabled, please enable them in Settings.", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
                        alertController.dismissViewControllerAnimated(true, completion: nil)
                    }
                    
                    alertController.addAction(dismissAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            }
        } else {
            let alertController = UIAlertController(title: "Notice", message: "Location services are not enabled, please enable them in Settings.", preferredStyle: UIAlertControllerStyle.Alert)
            
            let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
                alertController.dismissViewControllerAnimated(true, completion: nil)
            }
            
            alertController.addAction(dismissAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

