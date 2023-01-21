//
//  SidebarViewController.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 13.10.2022.
//

import Cocoa
import Robowars

private enum SideBarState {
    case newBattleState
    case battleInProgressState
    case battleFinishedState
    case errorState
}

class SidebarViewController: NSViewController {
    @IBOutlet private weak var chooseRobotsPlaceholderView: NSView!
    @IBOutlet private weak var chooseGameModePlaceholderView: NSView!
    @IBOutlet private weak var chooseGameSpeedPlaceholderView: NSView!
    @IBOutlet private weak var startButton: NSButton!
    @IBOutlet private weak var newBattleButton: NSButton!
    
    private let chooseRobotsViewController: ChooseRobotsViewController
    private let chooseGameModeViewController: ChooseGameModeViewController
    private let chooseGameSpeedViewController: ChooseGameSpeedViewController
    
    private let chooseRobotsView: NSView!
    private let chooseGameModeView: NSView!
    private let chooseGameSpeedView: NSView!
    
    private let gameEngine: GameEngineProtocol
    
    private weak var delegate: SidebarViewControllerDelegate?
    
    private var state: SideBarState = .newBattleState {
        didSet {
            switch state {
            case .newBattleState:
                chooseRobotsViewController.firstRobotComboBox.isEnabled = true
                chooseRobotsViewController.secondRobotComboBox.isEnabled = true
                chooseGameModeViewController.gameModeComboBox.isEnabled = true
                chooseGameSpeedViewController.gameSpeedComboBox.isEnabled = true
                startButton.isEnabled = true
                newBattleButton.isEnabled = false
                
            case .battleInProgressState:
                chooseRobotsViewController.firstRobotComboBox.isEnabled = false
                chooseRobotsViewController.secondRobotComboBox.isEnabled = false
                chooseGameModeViewController.gameModeComboBox.isEnabled = false
                chooseGameSpeedViewController.gameSpeedComboBox.isEnabled = false
                startButton.isEnabled = false
                newBattleButton.isEnabled = false
                
            case .battleFinishedState:
                chooseRobotsViewController.firstRobotComboBox.isEnabled = false
                chooseRobotsViewController.secondRobotComboBox.isEnabled = false
                chooseGameModeViewController.gameModeComboBox.isEnabled = false
                chooseGameSpeedViewController.gameSpeedComboBox.isEnabled = false
                startButton.isEnabled = false
                newBattleButton.isEnabled = true
                
            case .errorState:
                chooseRobotsViewController.firstRobotComboBox.isEnabled = true
                chooseRobotsViewController.secondRobotComboBox.isEnabled = true
                chooseGameModeViewController.gameModeComboBox.isEnabled = true
                chooseGameSpeedViewController.gameSpeedComboBox.isEnabled = true
                startButton.isEnabled = false
                newBattleButton.isEnabled = false

            }
        }
    }

    override var nibName: NSNib.Name? {
        "SidebarView"
    }
    
    init(
        chooseRobotsViewController: ChooseRobotsViewController,
        chooseGameModeViewController: ChooseGameModeViewController,
        chooseGameSpeedViewController: ChooseGameSpeedViewController,
        gameEngine: GameEngineProtocol,
        delegate: SidebarViewControllerDelegate
    ) {
        self.gameEngine = gameEngine
        self.chooseRobotsViewController = chooseRobotsViewController
        self.chooseGameModeViewController = chooseGameModeViewController
        self.chooseGameSpeedViewController = chooseGameSpeedViewController
        self.delegate = delegate
        
        chooseRobotsView = chooseRobotsViewController.view
        chooseGameModeView = chooseGameModeViewController.view
        chooseGameSpeedView = chooseGameSpeedViewController.view
        
        super.init(nibName: "SidebarView", bundle: nil)
        
        addChild(chooseRobotsViewController)
        addChild(chooseGameModeViewController)
        addChild(chooseGameSpeedViewController)
        
        gameEngine.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseRobotsViewController.delegate = self
        chooseGameModeViewController.delegate = self
        chooseGameSpeedViewController.delegate = self
        
        state = .newBattleState
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        setupUI()
    }
    
    private func setupUI() {
        setup(chooseRobotsView, inside: chooseRobotsPlaceholderView)
        setup(chooseGameModeView, inside: chooseGameModePlaceholderView)
        setup(chooseGameSpeedView, inside: chooseGameSpeedPlaceholderView)
    }
    
    private func setup(_ subview: NSView, inside placeholderView: NSView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        placeholderView.addSubview(subview)
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: placeholderView.topAnchor),
            subview.bottomAnchor.constraint(equalTo: placeholderView.bottomAnchor),
            subview.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: placeholderView.trailingAnchor)
        ])
    }
    
    @IBAction func startButtonAction(_ sender: NSButton) {
        gameEngine.start()
        state = .battleInProgressState
    }
    
    @IBAction func newBattleButtonAction(_ sender: NSButton) {
        gameEngine.update(gameMode: chooseGameModeViewController.selectedGameMode)
        gameEngine.update(firstRobot: chooseRobotsViewController.selectedFirstRobot)
        gameEngine.update(secondRobot: chooseRobotsViewController.selectedSecondRobot)
        delegate?.sidebarViewControllerDidSelectNewBattle(self)
        state = .newBattleState
    }
}

extension SidebarViewController: ChooseRobotsViewControllerDelegate {
    func chooseRobotsViewController(
        _ viewController: ChooseRobotsViewController,
        firstRobotDidChange robot: RobotProtocol
    ) {
        state = .newBattleState
        gameEngine.update(firstRobot: robot)
    }
    
    func chooseRobotsViewController(
        _ viewController: ChooseRobotsViewController,
        secondRobotDidChange robot: RobotProtocol
    ) {
        state = .newBattleState
        gameEngine.update(secondRobot: robot)
    }
}

extension SidebarViewController: ChooseGameModeViewControllerDelegate {
    func chooseGameModeViewController(
        _ viewController: ChooseGameModeViewController,
        gameModeDidChange gameMode: GameMode
    ) {
        state = .newBattleState
        gameEngine.update(gameMode: gameMode)
    }
}

extension SidebarViewController: ChooseGameSpeedViewControllerDelegate {
    func chooseGameSpeedViewController(
        _ viewController: ChooseGameSpeedViewController,
        gameSpeedDidChange gameSpeed: GameSpeed
    ) {
        state = .newBattleState
        gameEngine.update(gameSpeed: gameSpeed)
    }
}

extension SidebarViewController: GameEngineDelegate {
    func gameEngine(_ gameEngine: GameEngineProtocol, didChangeFirstRobot robot: RobotProtocol, withShips ships: [CGRect]) {
        delegate?.sidebarViewController(self, didChangeFirstRobot: robot, withShips: ships)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, didChangeSecondRobot robot: RobotProtocol, withShips ships: [CGRect]) {
        delegate?.sidebarViewController(self, didChangeSecondRobot: robot, withShips: ships)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobotDidShootWithResult result: ShootResult) {
        delegate?.sidebarViewController(self, firstRobotDidShootWithResult: result)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobotDidShootWithResult result: ShootResult) {
        delegate?.sidebarViewController(self, secondRobotDidShootWithResult: result)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobotDidWinWithMessage message: String) {
        state = .battleFinishedState
        delegate?.sidebarViewController(self, firstRobotDidWinWithMessage: message)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobotDidWinWithMessage message: String) {
        state = .battleFinishedState
        delegate?.sidebarViewController(self, secondRobotDidWinWithMessage: message)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobotDidLoseWithMessage message: String) {
        delegate?.sidebarViewController(self, firstRobotDidLoseWithMessage: message)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobotDidLoseWithMessage message: String) {
        delegate?.sidebarViewController(self, secondRobotDidLoseWithMessage: message)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, didChangeGameModeWithBattleFieldSize battlefieldSize: CGSize) {
        delegate?.sidebarViewController(self, didChangeGameModeWithBattleFieldSize: battlefieldSize)
    }
    
    func gameEngine(_ gameEngine: Robowars.GameEngineProtocol, didFailWithError error: Error?) {
        state = .errorState
        delegate?.sidebarViewController(self, didFailWithError: error)
    }
}
