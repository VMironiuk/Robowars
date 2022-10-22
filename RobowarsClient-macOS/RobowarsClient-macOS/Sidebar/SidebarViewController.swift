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
    
    private var chooseRobotsView: NSView?
    private var chooseGameModeView: NSView?
    
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
        chooseRobotsView = chooseRobotsViewController.view
        chooseGameModeView = chooseGameModeViewController.view
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
    
    override func viewWillAppear() {
        super.viewWillAppear()
        setupUI()
    }
    
    private func setupUI() {
        guard let chooseRobotsView = chooseRobotsView, let chooseGameModeView = chooseGameModeView else {
            return
        }
        
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
