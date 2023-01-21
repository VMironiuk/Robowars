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
    
    private let firstRobots: [RobotProtocol]
    private let secondRobots: [RobotProtocol]
    
    var selectedFirstRobot: RobotProtocol {
        firstRobots[firstRobotComboBox.indexOfSelectedItem]
    }
    
    var selectedSecondRobot: RobotProtocol {
        secondRobots[secondRobotComboBox.indexOfSelectedItem]
    }
    
    weak var delegate: ChooseRobotsViewControllerDelegate? {
        didSet {
            guard let firstRobot = firstRobots.first, let secondRobot = secondRobots.first else { return }
            delegate?.chooseRobotsViewController(self, firstRobotDidChange: firstRobot)
            delegate?.chooseRobotsViewController(self, secondRobotDidChange: secondRobot)
        }
    }

    override var nibName: NSNib.Name? {
        "ChooseRobotsView"
    }
    
    init(firstRobots: [RobotProtocol], secondRobots: [RobotProtocol]) {
        self.firstRobots = firstRobots
        self.secondRobots = secondRobots
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
        
        guard !firstRobots.isEmpty, !secondRobots.isEmpty else { return }
        firstRobotComboBox.selectItem(at: .zero)
        secondRobotComboBox.selectItem(at: .zero)
    }
}

extension ChooseRobotsViewController: NSComboBoxDataSource {
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        if comboBox === firstRobotComboBox {
            return firstRobots.count
        } else if  comboBox === secondRobotComboBox {
            return secondRobots.count
        }
        return .zero
    }
    
    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        if comboBox === firstRobotComboBox {
            return firstRobots[index].name
        } else if  comboBox === secondRobotComboBox {
            return secondRobots[index].name
        }
        return nil
    }
}

extension ChooseRobotsViewController: NSComboBoxDelegate {
    func comboBoxSelectionDidChange(_ notification: Notification) {
        if notification.object as? NSComboBox === firstRobotComboBox {
            let indexOfSelectedItem = firstRobotComboBox.indexOfSelectedItem
            let selectedRobot = firstRobots[indexOfSelectedItem]
            delegate?.chooseRobotsViewController(self, firstRobotDidChange: selectedRobot)
        } else if notification.object as? NSComboBox === secondRobotComboBox {
            let indexOfSelectedItem = secondRobotComboBox.indexOfSelectedItem
            let selectedRobot = secondRobots[indexOfSelectedItem]
            delegate?.chooseRobotsViewController(self, secondRobotDidChange: selectedRobot)
        } else {
            fatalError()
        }
    }
}
