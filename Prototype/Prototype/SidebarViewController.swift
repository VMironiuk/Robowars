//
//  SidebarViewController.swift
//  Prototype
//
//  Created by Volodymyr Myroniuk on 07.09.2022.
//

import Cocoa

enum GameStage: Int {
    case started
    case inProgress
    case finished
}

class SidebarViewController: NSViewController {
    
    @IBOutlet private weak var firstRobotComboBox: NSComboBox!
    @IBOutlet private weak var secondRobotComboBox: NSComboBox!
    @IBOutlet private weak var gameModeComboBox: NSComboBox!
    @IBOutlet private weak var showErrorCheckBox: NSButton!
    @IBOutlet private weak var gameStageComboBox: NSComboBox!
    
    private var shouldShowError: Bool = false {
        didSet {
            let userInfo = [Constants.Notifications.UserInfo.Key.showError : shouldShowError]
            NotificationCenter.default.post(name: Constants.Notifications.Name.toggleError, object: nil, userInfo: userInfo)
        }
    }
    
    private var selectedGameStage: GameStage = .started {
        didSet {
            let userInfo = [Constants.Notifications.UserInfo.Key.gameStateDidChange : selectedGameStage]
            NotificationCenter.default.post(
                name: Constants.Notifications.Name.gameStateDidChange,
                object: nil,
                userInfo: userInfo)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstRobotComboBox.selectItem(at: .zero)
        secondRobotComboBox.selectItem(at: .zero)
        gameModeComboBox.selectItem(at: .zero)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        shouldShowError = showErrorCheckBox.state == .on
        
        gameStageComboBox.selectItem(at: .zero)
        if let gameStage = GameStage(rawValue: gameStageComboBox.indexOfSelectedItem) {
            selectedGameStage = gameStage
        }
    }
    
    @IBAction func showErrorCheckBoxAction(_ sender: NSButton) {
        shouldShowError = sender.state == .on
    }
    
    @IBAction func gameStageComboBoxAction(_ sender: NSComboBox) {
        if let gameStage = GameStage(rawValue: sender.indexOfSelectedItem) {
            selectedGameStage = gameStage
        }
    }
}
