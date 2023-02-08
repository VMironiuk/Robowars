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
    @IBOutlet private weak var errorView: NSView!
    @IBOutlet private weak var errorViewTopConstraint: NSLayoutConstraint!
    
    private let firstBattlefieldViewController: BattlefieldViewControllerProtocol
    private let secondBattlefieldViewController: BattlefieldViewControllerProtocol
    private let finishedGamePopupViewController: FinishedGamePopupViewControllerProtocol
    
    private var isErrorViewHidden: Bool = true {
        didSet {
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 0.2
                errorViewTopConstraint.animator().constant = isErrorViewHidden ? -50 : .zero
            }
        }
    }

    override var nibName: NSNib.Name? {
        "MainView"
    }
    
    init(
        firstBattlefieldViewController: BattlefieldViewControllerProtocol,
        secondBattlefieldViewController: BattlefieldViewControllerProtocol,
        finishedGamePopupViewController: FinishedGamePopupViewControllerProtocol
    ) {
        self.firstBattlefieldViewController = firstBattlefieldViewController
        self.secondBattlefieldViewController = secondBattlefieldViewController
        self.finishedGamePopupViewController = finishedGamePopupViewController
        
        super.init(nibName: "MainView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupErrorView()
        setupBattlefieldViews()
        
        firstRobotMessageLabel.stringValue = ""
        secondRobotMessageLabel.stringValue = ""
    }
    
    private func setupBattlefieldViews() {
        setupBattlefieldView(firstBattlefieldViewController.view, in: firstBattlefieldPlaceholderView)
        setupBattlefieldView(secondBattlefieldViewController.view, in: secondBattlefieldPlaceholderView)
    }
    
    private func setupBattlefieldView(_ battlefieldView: NSView, in placeholderView: NSView) {
        placeholderView.addSubview(battlefieldView)
        
        battlefieldView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            battlefieldView.topAnchor.constraint(equalTo: placeholderView.topAnchor),
            battlefieldView.bottomAnchor.constraint(equalTo: placeholderView.bottomAnchor),
            battlefieldView.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor),
            battlefieldView.trailingAnchor.constraint(equalTo: placeholderView.trailingAnchor)
        ])
    }
    
    private func setupErrorView() {
        errorView.wantsLayer = true
        errorView.layer?.backgroundColor = NSColor(named: "ErrorViewColor")?.cgColor
    }
        
    @IBAction private func closeErrorViewButtonAction(_ sender: NSButton) {
        isErrorViewHidden = true
    }
}

extension MainViewController: SidebarViewControllerDelegate {
    func sidebarViewController(
        _ sidebarViewController: SidebarViewController,
        didChangeFirstRobot robot: RobotProtocol,
        withShips ships: [CGRect]
    ) {
        isErrorViewHidden = true
        firstRobotNameLabel.stringValue = robot.name
        firstBattlefieldViewController.updateShips(ships)
    }
    
    func sidebarViewController(
        _ sidebarViewController: SidebarViewController,
        didChangeSecondRobot robot: RobotProtocol,
        withShips ships: [CGRect]
    ) {
        isErrorViewHidden = true
        secondRobotNameLabel.stringValue = robot.name
        secondBattlefieldViewController.updateShips(ships)
    }
    
    func sidebarViewController(
        _ sidebarViewController: SidebarViewController,
        firstRobot robot: RobotProtocol,
        didShootWithResult result: ShootResult
    ) {
        isErrorViewHidden = true
        secondBattlefieldViewController.updateTile(with: result.toTileState)
    }
    
    func sidebarViewController(
        _ sidebarViewController: SidebarViewController,
        secondRobot robot: RobotProtocol,
        didShootWithResult result: ShootResult
    ) {
        isErrorViewHidden = true
        firstBattlefieldViewController.updateTile(with: result.toTileState)
    }
    
    func sidebarViewController(
        _ sidebarViewController: SidebarViewController,
        firstRobot robot: RobotProtocol,
        didWinWithMessage message: String
    ) {
        isErrorViewHidden = true
        firstRobotMessageLabel.stringValue = message
        finishedGamePopupViewController.show(in: self, with: robot.name)
    }
    
    func sidebarViewController(
        _ sidebarViewController: SidebarViewController,
        secondRobot robot: RobotProtocol,
        didWinWithMessage message: String
    ) {
        isErrorViewHidden = true
        secondRobotMessageLabel.stringValue = message
        finishedGamePopupViewController.show(in: self, with: robot.name)
    }
    
    func sidebarViewController(
        _ sidebarViewController: SidebarViewController,
        firstRobot robot: RobotProtocol,
        didLoseWithMessage message: String
    ) {
        isErrorViewHidden = true
        firstRobotMessageLabel.stringValue = message
    }
    
    func sidebarViewController(
        _ sidebarViewController: SidebarViewController,
        secondRobot robot: RobotProtocol,
        didLoseWithMessage message: String
    ) {
        isErrorViewHidden = true
        secondRobotMessageLabel.stringValue = message
    }
    
    func sidebarViewController(_ sidebarViewController: SidebarViewController, didChangeGameModeWithBattleFieldSize battlefieldSize: CGSize) {
        isErrorViewHidden = true
        firstBattlefieldViewController.updateBattlefieldSize(battlefieldSize)
        secondBattlefieldViewController.updateBattlefieldSize(battlefieldSize)
    }
    
    func sidebarViewController(_ sidebarViewController: SidebarViewController, didFailWithError error: Error?) {
        isErrorViewHidden = false
    }
    
    func sidebarViewControllerDidSelectNewBattle(_ sidebarViewController: SidebarViewController) {
        isErrorViewHidden = true
        firstRobotMessageLabel.stringValue = ""
        secondRobotMessageLabel.stringValue = ""
        finishedGamePopupViewController.hide()
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
