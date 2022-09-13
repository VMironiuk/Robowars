//
//  FinishedGamePopupViewController.swift
//  Prototype
//
//  Created by Volodymyr Myroniuk on 13.09.2022.
//

import Cocoa

class FinishedGamePopupViewController: NSViewController {
    
    override var nibName: NSNib.Name? {
        "FinishedGamePopupView"
    }
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "FinishedGamePopupView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
