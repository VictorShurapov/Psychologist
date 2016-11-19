//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by Victor Shurapov on 3/25/16.
//  Copyright © 2016 Victor Shurapov. All rights reserved.
//
import UIKit

class DiagnosedHappinessViewController: HappinessViewController, UIPopoverPresentationControllerDelegate {
    
    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness]
        }
    }
    fileprivate let defaults = UserDefaults.standard
    
    
    var diagnosticHistory: [Int] {
        get { return defaults.object(forKey: History.DefaultsKey) as? [Int] ?? []}
        set { defaults.set(newValue, forKey: History.DefaultsKey)
            print("diagnosticHistory \(diagnosticHistory)")
        }
    }
    
    fileprivate struct History {
        static let SegueIdentifier = "Show Diagnostic History"
        static let DefaultsKey = "DiagnosedHappinessViewController.diagnosticHistory"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case History.SegueIdentifier:
                if let tvc = segue.destination as? TextViewController {
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self
                    }
                    tvc.text = "\(diagnosticHistory)"
                }
            default:
                break
            }
            
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
}
