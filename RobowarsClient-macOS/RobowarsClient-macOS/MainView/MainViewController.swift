//
//  MainViewController.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 28.10.2022.
//

import Cocoa
import Robowars

final class MainViewController: NSViewController {
    @IBOutlet private weak var firstBattlefieldPlaceholderView: NSView!
    @IBOutlet private weak var secondBattlefieldPlaceholderView: NSView!
    @IBOutlet private weak var firstRobotNameLabel: NSTextField!
    @IBOutlet private weak var secondRobotNameLabel: NSTextField!
    @IBOutlet private weak var firstRobotMessageLabel: NSTextField!
    @IBOutlet private weak var secondRobotMessageLabel: NSTextField!
    
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
        
        setupBattlefieldViews()
    }
    
    private func setupBattlefieldViews() {
        let firstBattlefieldView = firstBattlefieldViewController.view
        let secondBattlefieldView = secondBattlefieldViewController.view
        
        firstBattlefieldPlaceholderView.addSubview(firstBattlefieldView)
        secondBattlefieldPlaceholderView.addSubview(secondBattlefieldView)
        
        firstBattlefieldView.translatesAutoresizingMaskIntoConstraints = false
        secondBattlefieldView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstBattlefieldView.topAnchor.constraint(equalTo: firstBattlefieldPlaceholderView.topAnchor),
            firstBattlefieldView.bottomAnchor.constraint(equalTo: firstBattlefieldPlaceholderView.bottomAnchor),
            firstBattlefieldView.leadingAnchor.constraint(equalTo: firstBattlefieldPlaceholderView.leadingAnchor),
            firstBattlefieldView.trailingAnchor.constraint(equalTo: firstBattlefieldPlaceholderView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            secondBattlefieldView.topAnchor.constraint(equalTo: secondBattlefieldPlaceholderView.topAnchor),
            secondBattlefieldView.bottomAnchor.constraint(equalTo: secondBattlefieldPlaceholderView.bottomAnchor),
            secondBattlefieldView.leadingAnchor.constraint(equalTo: secondBattlefieldPlaceholderView.leadingAnchor),
            secondBattlefieldView.trailingAnchor.constraint(equalTo: secondBattlefieldPlaceholderView.trailingAnchor)
        ])
    }
}

extension MainViewController: GameEngineDelegate {
    func gameEngine(
        _ gameEngine: GameEngineProtocol,
        didChangeFirstRobot robot: RobotProtocol,
        withShips ships: [CGRect]
    ) {
        firstRobotNameLabel.stringValue = robot.name
        firstBattlefieldViewController.updateShips(ships)
    }
    
    func gameEngine(
        _ gameEngine: GameEngineProtocol,
        didChangeSecondRobot robot: RobotProtocol,
        withShips ships: [CGRect]
    ) {
        secondRobotNameLabel.stringValue = robot.name
        secondBattlefieldViewController.updateShips(ships)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobotDidShootWithResult result: ShootResult) {
        firstBattlefieldViewController.updateTile(with: result.toTileState)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobotDidShootWithResult result: ShootResult) {
        secondBattlefieldViewController.updateTile(with: result.toTileState)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobotDidWinWithMessage message: String) {
        firstRobotMessageLabel.stringValue = message
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobotDidWinWithMessage message: String) {
        secondRobotMessageLabel.stringValue = message
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobotDidLoseWithMessage message: String) {
        firstRobotMessageLabel.stringValue = message
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobotDidLoseWithMessage message: String) {
        secondRobotMessageLabel.stringValue = message
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, didChangeGameModeWithBattleFieldSize battlefieldSize: CGSize) {
        firstBattlefieldViewController.updateBattlefieldSize(battlefieldSize)
        secondBattlefieldViewController.updateBattlefieldSize(battlefieldSize)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, didFailWithError error: Error?) {
    }
}

private extension ShootResult {
    var toTileState: TileState {
        switch self {
        case .miss(let coordinate):
            return .miss(coordinate)
        case .hit(let coordinate):
            return .hit(coordinate)
        case .kill(let coordinate):
            return .kill(coordinate)
        }
    }
}
