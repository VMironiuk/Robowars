//
//  ChooseRobotsViewController.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 05.10.2022.
//

import Cocoa
import Robowars

protocol ChooseRobotsViewControllerDelegate: AnyObject {}

final class ChooseRobotsViewController: NSViewController {
    
    weak var delegate: ChooseRobotsViewControllerDelegate?
    
    override var nibName: NSNib.Name? {
        "ChooseRobotsView"
    }
    
    convenience init(robots: [RobotProtocol]) {
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
