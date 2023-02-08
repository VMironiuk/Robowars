//
//  ChooseRobotsViewControllerProtocol.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 07.02.2023.
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

protocol ChooseRobotsViewControllerProtocol where Self: NSViewController {
    var delegate: ChooseRobotsViewControllerDelegate? { get set }
    var selectedFirstRobot: RobotProtocol { get }
    var selectedSecondRobot: RobotProtocol { get }
    var isFirstRobotsInteractionEnabled: Bool { get set }
    var isSecondRobotsInteractionEnabled: Bool { get set }
}
