//
//  TextViewController.swift
//  Psychologist
//
//  Created by Victor Shurapov on 3/25/16.
//  Copyright © 2016 Victor Shurapov. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.text = text
            
        }
    }
    
    var text: String = "" {
        didSet {
            textView?.text = text
        }
    }
    
    override var preferredContentSize: CGSize {
        get {
            if textView != nil && presentingViewController != nil {
                return textView.sizeThatFits(presentingViewController!.view.bounds.size)
            } else {
                return super.preferredContentSize
            }
        }
        set { super.preferredContentSize = newValue }
    }
    
}
