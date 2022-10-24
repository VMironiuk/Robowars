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
    func sidebarViewController(_ viewController: SidebarViewController, gameModeDidChange gameMode: GameMode)
}

class SidebarViewController: NSViewController {
    
    @IBOutlet private weak var chooseRobotsPlaceholderView: NSView!
    @IBOutlet private weak var chooseGameModePlaceholderView: NSView!
    
    private let chooseRobotsView: NSView!
    private let chooseGameModeView: NSView!
    
    private weak var delegate: SidebarViewControllerDelegate!
    
    override var nibName: NSNib.Name? {
        "SidebarView"
    }
    
    init(
        chooseRobotsViewController: ChooseRobotsViewController,
        chooseGameModeViewController: ChooseGameModeViewController,
        delegate: SidebarViewControllerDelegate
    ) {
        self.delegate = delegate
        chooseRobotsView = chooseRobotsViewController.view
        chooseGameModeView = chooseGameModeViewController.view
        
        super.init(nibName: "SidebarView", bundle: nil)
        
        addChild(chooseRobotsViewController)
        addChild(chooseGameModeViewController)

        chooseRobotsViewController.delegate = self
        chooseGameModeViewController.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        setupUI()
    }
    
    private func setupUI() {
        chooseRobotsView.translatesAutoresizingMaskIntoConstraints = false
        chooseRobotsPlaceholderView.addSubview(chooseRobotsView)
        NSLayoutConstraint.activate([
            chooseRobotsView.topAnchor.constraint(equalTo: chooseRobotsPlaceholderView.topAnchor),
            chooseRobotsView.bottomAnchor.constraint(equalTo: chooseRobotsPlaceholderView.bottomAnchor),
            chooseRobotsView.leadingAnchor.constraint(equalTo: chooseRobotsPlaceholderView.leadingAnchor),
            chooseRobotsView.trailingAnchor.constraint(equalTo: chooseRobotsPlaceholderView.trailingAnchor)
        ])
        
        chooseGameModeView.translatesAutoresizingMaskIntoConstraints = false
        chooseGameModePlaceholderView.addSubview(chooseGameModeView)
        NSLayoutConstraint.activate([
            chooseGameModeView.topAnchor.constraint(equalTo: chooseGameModePlaceholderView.topAnchor),
            chooseGameModeView.bottomAnchor.constraint(equalTo: chooseGameModePlaceholderView.bottomAnchor),
            chooseGameModeView.leadingAnchor.constraint(equalTo: chooseGameModePlaceholderView.leadingAnchor),
            chooseGameModeView.trailingAnchor.constraint(equalTo: chooseGameModePlaceholderView.trailingAnchor)
        ])
    }
}

extension SidebarViewController: ChooseRobotsViewControllerDelegate {
    func chooseRobotsViewController(
        _ viewController: ChooseRobotsViewController,
        firstRobotDidChange robot: RobotProtocol
    ) {
        delegate.sidebarViewController(self, firstRobotDidChange: robot)
    }
    
    func chooseRobotsViewController(
        _ viewController: ChooseRobotsViewController,
        secondRobotDidChange robot: RobotProtocol
    ) {
        delegate.sidebarViewController(self, secondRobotDidChange: robot)
    }
}

extension SidebarViewController: ChooseGameModeViewControllerDelegate {
    func chooseGameModeViewController(
        _ viewController: ChooseGameModeViewController,
        gameModeDidChange gameMode: GameMode
    ) {
        delegate.sidebarViewController(self, gameModeDidChange: gameMode)
    }
}
