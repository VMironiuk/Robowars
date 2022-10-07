//
//  ChooseRobotsViewController.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 05.10.2022.
//

import Cocoa
import Robowars

protocol ChooseRobotsViewControllerDelegate: AnyObject {
    func chooseRobotsViewController(
        _ viewController: ChooseRobotsViewController,
        firstRobotDidChangeWith robot: RobotProtocol)
    func chooseRobotsViewController(
        _ viewController: ChooseRobotsViewController,
        secondRobotDidChangeWith robot: RobotProtocol)
}

final class ChooseRobotsViewController: NSViewController {
    
    private var robots: [RobotProtocol]
    
    weak var delegate: ChooseRobotsViewControllerDelegate? {
        didSet {
            guard let robot = robots.first else { return }
            delegate?.chooseRobotsViewController(self, firstRobotDidChangeWith: robot)
            delegate?.chooseRobotsViewController(self, secondRobotDidChangeWith: robot)
        }
    }

    override var nibName: NSNib.Name? {
        "ChooseRobotsView"
    }
    
    convenience init(robots: [RobotProtocol]) {
        self.init(nibName: nil, bundle: nil)
        self.robots = robots
    }

    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        self.robots = []
        super.init(nibName: "ChooseRobotsView", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
