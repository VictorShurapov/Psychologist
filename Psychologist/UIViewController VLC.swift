//
//  UIViewControllerLC.swift
//  Psychologist
//
//  Created by Victor Shurapov on 5/16/16.
//  Copyright © 2016 Victor Shurapov. All rights reserved.
//

import UIKit

var accumulatingLogVCLprefix = ""
var lastLogVCLPrefixRequest: Date?

extension UIViewController {
    var logVCLprefix: String {
        if let lastRequestDate = lastLogVCLPrefixRequest {
            if lastRequestDate.timeIntervalSinceNow < -2 {
                accumulatingLogVCLprefix += "__"
            }
        }
        lastLogVCLPrefixRequest = Date(timeIntervalSinceNow:  0)
        return accumulatingLogVCLprefix
    }
}
