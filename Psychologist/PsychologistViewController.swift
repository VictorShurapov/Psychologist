//
//  ViewController.swift
//  Psychologist
//
//  Created by Victor Shurapov on 3/1/16.
//  Copyright © 2016 Victor Shurapov. All rights reserved.
//

import UIKit

var globalPsychologistViewController = 0

class PsychologistViewController: UIViewController {
    
    // here we are performing a segue manually from code
    // this is only useful if you want to do some decision-making
    //   around the segue process (this example doesn't do that)
    @IBAction func nothing(sender: UIButton) {
        performSegueWithIdentifier("nothing", sender: nil)
        
    }
    
    // prepare for segues
    // the only segue we currently have is to the HappinessViewController
    // to show the Psychologist's diagnosis
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination: UIViewController? = segue.destinationViewController as UIViewController
        // this next if-statement makes sure the segue prepares properly even
        //   if the MVC we're seguing to is wrapped in a UINavigationController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let hvc = destination as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "show sad diagnosis": hvc.happiness = 0
                case "show happy diagnosis": hvc.happiness = 100
                case "nothing": hvc.happiness = 25
                default: hvc.happiness = 50
                }
            }
        }
    }
    
    var instanceCount: ()  = globalPsychologistViewController += 1
    
    func logVCL(msg: String) {
        print(logVCLprefix + "Psychologist \(instanceCount) " + msg)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        logVCL("init(coder)")
    }
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        logVCL("init(nibName, bundle)")
//    }
    
    deinit {
        logVCL("deinit")
    }
    
    override func awakeFromNib() {
        logVCL("awakeFromNib()")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logVCL("viewDidLoad()")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        logVCL("viewWillAppear(animated = \(animated))")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        logVCL("viewDidAppear(animated = \(animated))")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        logVCL("viewWillDisappear(animated = \(animated))")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        logVCL("viewDidDisappear(animated = \(animated))")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logVCL("viewWillLayoutSubviews() bounds.size = \(view.bounds.size)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logVCL("viewDidLayoutSubviews() bounds.size = \(view.bounds.size)")
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        logVCL("viewWillTransitionToSize")
        coordinator.animateAlongsideTransition( {(context: UIViewControllerTransitionCoordinatorContext!) -> Void in self.logVCL("animateAlongsideTransition")}, completion: { context -> Void in self.logVCL("doneAnimatingAlogsideTransition")})
    }
}


