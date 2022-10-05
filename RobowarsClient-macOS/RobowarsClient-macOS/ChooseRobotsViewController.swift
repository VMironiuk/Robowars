//
//  ChooseRobotsViewController.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 05.10.2022.
//

import Cocoa

final class ChooseRobotsViewController: NSViewController {
    
    override var nibName: NSNib.Name? {
        "ChooseRobotsView"
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "ChooseRobotsView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
