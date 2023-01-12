//
//  SidebarViewController.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 13.10.2022.
//

import Cocoa
import Robowars

class SidebarViewController: NSViewController {
    @IBOutlet private weak var chooseRobotsPlaceholderView: NSView!
    @IBOutlet private weak var chooseGameModePlaceholderView: NSView!
    @IBOutlet private weak var chooseGameSpeedPlaceholderView: NSView!
    
    private let chooseRobotsViewController: ChooseRobotsViewController
    private let chooseGameModeViewController: ChooseGameModeViewController
    private let chooseGameSpeedViewController: ChooseGameSpeedViewController
    
    private let chooseRobotsView: NSView!
    private let chooseGameModeView: NSView!
    private let chooseGameSpeedView: NSView!
    
    private let gameEngine: GameEngineProtocol

    override var nibName: NSNib.Name? {
        "SidebarView"
    }
    
    init(
        chooseRobotsViewController: ChooseRobotsViewController,
        chooseGameModeViewController: ChooseGameModeViewController,
        chooseGameSpeedViewController: ChooseGameSpeedViewController,
        gameEngine: GameEngineProtocol
    ) {
        self.gameEngine = gameEngine
        self.chooseRobotsViewController = chooseRobotsViewController
        self.chooseGameModeViewController = chooseGameModeViewController
        self.chooseGameSpeedViewController = chooseGameSpeedViewController
        
        chooseRobotsView = chooseRobotsViewController.view
        chooseGameModeView = chooseGameModeViewController.view
        chooseGameSpeedView = chooseGameSpeedViewController.view
        
        super.init(nibName: "SidebarView", bundle: nil)
        
        addChild(chooseRobotsViewController)
        addChild(chooseGameModeViewController)
        addChild(chooseGameSpeedViewController)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseRobotsViewController.delegate = self
        chooseGameModeViewController.delegate = self
        chooseGameSpeedViewController.delegate = self
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
    }
}

extension SidebarViewController: ChooseRobotsViewControllerDelegate {
    func chooseRobotsViewController(
        _ viewController: ChooseRobotsViewController,
        firstRobotDidChange robot: RobotProtocol
    ) {
        gameEngine.update(firstRobot: robot)
    }
    
    func chooseRobotsViewController(
        _ viewController: ChooseRobotsViewController,
        secondRobotDidChange robot: RobotProtocol
    ) {
        gameEngine.update(secondRobot: robot)
    }
}

extension SidebarViewController: ChooseGameModeViewControllerDelegate {
    func chooseGameModeViewController(
        _ viewController: ChooseGameModeViewController,
        gameModeDidChange gameMode: GameMode
    ) {
        gameEngine.update(gameMode: gameMode)
    }
}

extension SidebarViewController: ChooseGameSpeedViewControllerDelegate {
    func chooseGameSpeedViewController(
        _ viewController: ChooseGameSpeedViewController,
        gameSpeedDidChange gameSpeed: GameSpeed
    ) {
        gameEngine.update(gameSpeed: gameSpeed)
    }
}
