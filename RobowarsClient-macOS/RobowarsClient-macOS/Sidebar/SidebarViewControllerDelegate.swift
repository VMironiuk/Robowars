//
//  SidebarViewControllerDelegate.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 20.01.2023.
//

import Foundation
import Robowars

protocol SidebarViewControllerDelegate: AnyObject {
    func sidebarViewController(_ sidebarViewController: SidebarViewController, didChangeFirstRobot robot: RobotProtocol, withShips ships: [CGRect])
    func sidebarViewController(_ sidebarViewController: SidebarViewController, didChangeSecondRobot robot: RobotProtocol, withShips ships: [CGRect])
    func sidebarViewController(_ sidebarViewController: SidebarViewController, firstRobot robot: RobotProtocol, didShootWithResult result: ShootResult)
    func sidebarViewController(_ sidebarViewController: SidebarViewController, secondRobot robot: RobotProtocol, didShootWithResult result: ShootResult)
    func sidebarViewController(_ sidebarViewController: SidebarViewController, firstRobot robot: RobotProtocol, didWinWithMessage message: String)
    func sidebarViewController(_ sidebarViewController: SidebarViewController, secondRobot robot: RobotProtocol, didWinWithMessage message: String)
    func sidebarViewController(_ sidebarViewController: SidebarViewController, firstRobot robot: RobotProtocol, didLoseWithMessage message: String)
    func sidebarViewController(_ sidebarViewController: SidebarViewController, secondRobot robot: RobotProtocol, didLoseWithMessage message: String)
    func sidebarViewController(_ sidebarViewController: SidebarViewController, didChangeGameModeWithBattleFieldSize battlefieldSize: CGSize)
    func sidebarViewController(_ sidebarViewController: SidebarViewController, didFailWithError error: Error?)
    func sidebarViewControllerDidSelectNewBattle(_ sidebarViewController: SidebarViewController)
}
