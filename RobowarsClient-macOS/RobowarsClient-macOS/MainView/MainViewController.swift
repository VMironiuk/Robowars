//
//  MainViewController.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 28.10.2022.
//

import Cocoa
import Robowars

final class MainViewController: NSViewController {
    private let firstBattlefieldViewController: BattlefieldViewControllerProtocol
    private let secondBattlefieldViewController: BattlefieldViewControllerProtocol

    override var nibName: NSNib.Name? {
        "MainView"
    }
    
    init(
        firstBattlefieldViewController: BattlefieldViewControllerProtocol,
        secondBattlefieldViewController: BattlefieldViewControllerProtocol
    ) {
        self.firstBattlefieldViewController = firstBattlefieldViewController
        self.secondBattlefieldViewController = secondBattlefieldViewController
        
        super.init(nibName: "MainView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MainViewController: GameEngineDelegate {
    func gameEngine(_ gameEngine: GameEngineProtocol, didChangeFirstRobotWithShips ships: [CGRect]) {
        firstBattlefieldViewController.updateShips(ships)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, didChangeSecondRobotWithShips ships: [CGRect]) {
        secondBattlefieldViewController.updateShips(ships)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobotDidShootWithResult result: ShootResult) {
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobotDidShootWithResult result: ShootResult) {
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobotDidWinWithMessage message: String) {
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobotDidWinWithMessage message: String) {
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobotDidLoseWithMessage message: String) {
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobotDidLoseWithMessage message: String) {
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, didChangeGameModeWithBattleField battlefield: CGRect) {
        firstBattlefieldViewController.updateBattlefield(battlefield)
        secondBattlefieldViewController.updateBattlefield(battlefield)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, didFailWithError error: Error?) {
    }
}
