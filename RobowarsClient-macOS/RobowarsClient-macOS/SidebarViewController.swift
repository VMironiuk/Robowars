//
//  SidebarViewController.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 13.10.2022.
//

import Cocoa
import Robowars

protocol SidebarViewControllerDelegate: AnyObject {
    func sidebarViewController(_ viewController: SidebarViewController, firstRobotDidChange robot: RobotProtocol)
    func sidebarViewController(_ viewController: SidebarViewController, secondRobotDidChange robot: RobotProtocol)
    func sidebarViewController(_ viewController: SidebarViewController, gameModeDidChange robot: GameMode)
}

class SidebarViewController: NSViewController {
    
    private weak var delegate: SidebarViewControllerDelegate?
    
    override var nibName: NSNib.Name? {
        "SidebarView"
    }
    
    convenience init(
        chooseRobotsViewController: ChooseRobotsViewController,
        chooseGameModeViewController: ChooseGameModeViewController,
        delegate: SidebarViewControllerDelegate
    ) {
        self.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        
        addChild(chooseRobotsViewController)
        addChild(chooseGameModeViewController)
        chooseRobotsViewController.delegate = self
        chooseGameModeViewController.delegate = self
    }
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "SidebarView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SidebarViewController: ChooseRobotsViewControllerDelegate {
    func chooseRobotsViewController(
        _ viewController: ChooseRobotsViewController,
        firstRobotDidChange robot: RobotProtocol
    ) {
        delegate?.sidebarViewController(self, firstRobotDidChange: robot)
    }
    
    func chooseRobotsViewController(
        _ viewController: ChooseRobotsViewController,
        secondRobotDidChange robot: RobotProtocol
    ) {
        delegate?.sidebarViewController(self, secondRobotDidChange: robot)
    }
}

extension SidebarViewController: ChooseGameModeViewControllerDelegate {
    func chooseGameModeViewController(
        _ viewController: ChooseGameModeViewController,
        gameModeDidChange gameMode: GameMode
    ) {
        delegate?.sidebarViewController(self, gameModeDidChange: gameMode)
    }
}
