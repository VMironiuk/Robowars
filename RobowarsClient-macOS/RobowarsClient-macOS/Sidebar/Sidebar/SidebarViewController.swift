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
    
    private let chooseRobotsViewController: ChooseRobotsViewControllerProtocol
    private let chooseGameModeViewController: ChooseGameModeViewControllerProtocol
    private let chooseGameSpeedViewController: ChooseGameSpeedViewControllerProtocol
    
    private let chooseRobotsView: NSView!
    private let chooseGameModeView: NSView!
    private let chooseGameSpeedView: NSView!
    
    private let gameEngine: GameEngineProtocol
    
    private weak var delegate: SidebarViewControllerDelegate?
    
    private var state: SideBarState = .newBattleState {
        didSet {
            switch state {
            case .newBattleState:
                chooseRobotsViewController.isFirstRobotsInteractionEnabled = true
                chooseRobotsViewController.isSecondRobotsInteractionEnabled = true
                chooseGameModeViewController.isGameModeInteractionEnabled = true
                chooseGameSpeedViewController.isGameSpeedInteractionEnabled = true
                startButton.isEnabled = true
                newBattleButton.isEnabled = false
                
            case .battleInProgressState:
                chooseRobotsViewController.isFirstRobotsInteractionEnabled = false
                chooseRobotsViewController.isSecondRobotsInteractionEnabled = false
                chooseGameModeViewController.isGameModeInteractionEnabled = false
                chooseGameSpeedViewController.isGameSpeedInteractionEnabled = false
                startButton.isEnabled = false
                newBattleButton.isEnabled = false
                
            case .battleFinishedState:
                chooseRobotsViewController.isFirstRobotsInteractionEnabled = false
                chooseRobotsViewController.isSecondRobotsInteractionEnabled = false
                chooseGameModeViewController.isGameModeInteractionEnabled = false
                chooseGameSpeedViewController.isGameSpeedInteractionEnabled = false
                startButton.isEnabled = false
                newBattleButton.isEnabled = true
                
            case .errorState:
                chooseRobotsViewController.isFirstRobotsInteractionEnabled = true
                chooseRobotsViewController.isSecondRobotsInteractionEnabled = true
                chooseGameModeViewController.isGameModeInteractionEnabled = true
                chooseGameSpeedViewController.isGameSpeedInteractionEnabled = true
                startButton.isEnabled = false
                newBattleButton.isEnabled = false
            }
        }
    }

    override var nibName: NSNib.Name? {
        "SidebarView"
    }
    
    init(
        chooseRobotsViewController: ChooseRobotsViewControllerProtocol,
        chooseGameModeViewController: ChooseGameModeViewControllerProtocol,
        chooseGameSpeedViewController: ChooseGameSpeedViewControllerProtocol,
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
        
        state = .newBattleState
        
        chooseGameSpeedViewController.delegate = self
        chooseRobotsViewController.delegate = self
        chooseGameModeViewController.delegate = self
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
        state = .battleInProgressState
        gameEngine.start()
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
    
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobot robot: RobotProtocol, didShootWithResult result: ShootResult) {
        delegate?.sidebarViewController(self, firstRobot: robot, didShootWithResult: result)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobot robot: RobotProtocol, didShootWithResult result: ShootResult) {
        delegate?.sidebarViewController(self, secondRobot: robot, didShootWithResult: result)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobot robot: RobotProtocol, didWinWithMessage message: String) {
        state = .battleFinishedState
        delegate?.sidebarViewController(self, firstRobot: robot, didWinWithMessage: message)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobot robot: RobotProtocol, didWinWithMessage message: String) {
        state = .battleFinishedState
        delegate?.sidebarViewController(self, secondRobot: robot, didWinWithMessage: message)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobot robot: RobotProtocol, didLoseWithMessage message: String) {
        delegate?.sidebarViewController(self, firstRobot: robot, didLoseWithMessage: message)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobot robot: RobotProtocol, didLoseWithMessage message: String) {
        delegate?.sidebarViewController(self, secondRobot: robot, didLoseWithMessage: message)
    }
    
    func gameEngine(_ gameEngine: GameEngineProtocol, didChangeGameModeWithBattleFieldSize battlefieldSize: CGSize) {
        delegate?.sidebarViewController(self, didChangeGameModeWithBattleFieldSize: battlefieldSize)
    }
    
    func gameEngine(_ gameEngine: Robowars.GameEngineProtocol, didFailWithError error: Error?) {
        state = .errorState
        delegate?.sidebarViewController(self, didFailWithError: error)
    }
}
