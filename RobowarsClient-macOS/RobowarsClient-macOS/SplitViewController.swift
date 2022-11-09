//
//  SplitViewController.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 25.10.2022.
//

import Cocoa
import Robowars

class SplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sidebarVC = SidebarViewController(
            chooseRobotsViewController: ChooseRobotsViewController(robots: []),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: []),
            delegate: self
        )
        
        let mainVC = MainViewController(
            firstBattlefieldViewController: BattlefieldViewController(),
            secondBattlefieldViewController: BattlefieldViewController()
        )
        
        addSplitViewItem(NSSplitViewItem(sidebarWithViewController: sidebarVC))
        addSplitViewItem(NSSplitViewItem(viewController: mainVC))
    }
}

extension SplitViewController: SidebarViewControllerDelegate {
    func sidebarViewController(_ viewController: SidebarViewController, firstRobotDidChange robot: RobotProtocol) {
    }
    
    func sidebarViewController(_ viewController: SidebarViewController, secondRobotDidChange robot: RobotProtocol) {
    }
    
    func sidebarViewController(_ viewController: SidebarViewController, gameModeDidChange gameMode: GameMode) {
    }
}
