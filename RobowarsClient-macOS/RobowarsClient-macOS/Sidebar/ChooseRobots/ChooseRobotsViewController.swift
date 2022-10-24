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
        firstRobotDidChange robot: RobotProtocol)
    func chooseRobotsViewController(
        _ viewController: ChooseRobotsViewController,
        secondRobotDidChange robot: RobotProtocol)
}

final class ChooseRobotsViewController: NSViewController {
    @IBOutlet private(set) weak var firstRobotComboBox: NSComboBox!
    @IBOutlet private(set) weak var secondRobotComboBox: NSComboBox!
    
    private let robots: [RobotProtocol]
    
    weak var delegate: ChooseRobotsViewControllerDelegate? {
        didSet {
            guard let robot = robots.first else { return }
            delegate?.chooseRobotsViewController(self, firstRobotDidChange: robot)
            delegate?.chooseRobotsViewController(self, secondRobotDidChange: robot)
        }
    }

    override var nibName: NSNib.Name? {
        "ChooseRobotsView"
    }
    
    init(robots: [RobotProtocol]) {
        self.robots = robots
        super.init(nibName: "ChooseRobotsView", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstRobotComboBox.usesDataSource = true
        firstRobotComboBox.dataSource = self
        firstRobotComboBox.delegate = self
        
        secondRobotComboBox.usesDataSource = true
        secondRobotComboBox.dataSource = self
        secondRobotComboBox.delegate = self
    }
}

extension ChooseRobotsViewController: NSComboBoxDataSource {
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        robots.count
    }
    
    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        robots[index].name
    }
}

extension ChooseRobotsViewController: NSComboBoxDelegate {
    func comboBoxSelectionDidChange(_ notification: Notification) {
        if notification.object as? NSComboBox === firstRobotComboBox {
            let indexOfSelectedItem = firstRobotComboBox.indexOfSelectedItem
            let selectedRobot = robots[indexOfSelectedItem]
            delegate?.chooseRobotsViewController(self, firstRobotDidChange: selectedRobot)
        } else if notification.object as? NSComboBox === secondRobotComboBox {
            let indexOfSelectedItem = secondRobotComboBox.indexOfSelectedItem
            let selectedRobot = robots[indexOfSelectedItem]
            delegate?.chooseRobotsViewController(self, secondRobotDidChange: selectedRobot)
        } else {
            fatalError()
        }
    }
}
