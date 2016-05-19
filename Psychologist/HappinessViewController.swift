//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Victor Shurapov on 2/6/16.
//  Copyright © 2016 Victor Shurapov. All rights reserved.
//

import UIKit

var globalHappinessInstanceCount = 0

class HappinessViewController: UIViewController, FaceViewDataSource {
    
    var instanceCount: () = globalPsychologistViewController += 1

    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }
    
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended:
            fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
                updateUI()
            }
        default :
            break
        }
        
    }
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(faceView.scale(_:))))
        }
    }
    
    var happiness: Int = 88 { // 0 = very sad, 100 = ecstatic
        didSet {
            happiness = min(max(happiness, 0), 100)
            print("happiness = \(happiness)")
            updateUI()
        }
    }
    private func updateUI() {
        // we have to be careful here
        // we can't just unwrap the implicitly unwrapped optional faceView
        // that's because outlets are not set during segue preparation
        faceView?.setNeedsDisplay()
        title = "\(happiness)"
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }
    
    func logVCL(msg: String) {
        print(logVCLprefix + "Happiness \(instanceCount) " + msg)
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
        coordinator.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.logVCL("animatingAlongsideTransition")
            }, completion: { context -> Void in
                self.logVCL("doneAnimatingAlongsideTransition")
        })
    }

}
