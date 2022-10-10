//
//  ChooseGameModeViewController.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 10.10.2022.
//

import Cocoa

class ChooseGameModeViewController: NSViewController {
    
    override var nibName: NSNib.Name? {
        "ChooseGameModeView"
    }
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "ChooseGameModeView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
