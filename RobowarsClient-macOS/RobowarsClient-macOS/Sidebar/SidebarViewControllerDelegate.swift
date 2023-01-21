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
    func sidebarViewController(_ sidebarViewController: SidebarViewController, firstRobotDidShootWithResult result: ShootResult)
    func sidebarViewController(_ sidebarViewController: SidebarViewController, secondRobotDidShootWithResult result: ShootResult)
    func sidebarViewController(_ sidebarViewController: SidebarViewController, firstRobotDidWinWithMessage message: String)
    func sidebarViewController(_ sidebarViewController: SidebarViewController, secondRobotDidWinWithMessage message: String)
    func sidebarViewController(_ sidebarViewController: SidebarViewController, firstRobotDidLoseWithMessage message: String)
    func sidebarViewController(_ sidebarViewController: SidebarViewController, secondRobotDidLoseWithMessage message: String)
    func sidebarViewController(_ sidebarViewController: SidebarViewController, didChangeGameModeWithBattleFieldSize battlefieldSize: CGSize)
    func sidebarViewController(_ sidebarViewController: SidebarViewController, didFailWithError error: Error?)
    func sidebarViewControllerDidSelectNewBattle(_ sidebarViewController: SidebarViewController)
}
