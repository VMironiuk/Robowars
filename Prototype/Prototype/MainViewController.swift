//
//  MainViewController.swift
//  Prototype
//
//  Created by Volodymyr Myroniuk on 20.08.2022.
//

import Cocoa

class MainViewController: NSViewController {
    
    @IBOutlet private weak var errorView: NSView!
    @IBOutlet private weak var firstRobotBattlefieldView: BattlefieldView!
    @IBOutlet private weak var secondRobotBattlefieldView: BattlefieldView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorView.wantsLayer = true
        errorView.layer?.backgroundColor = NSColor(named: "ErrorViewColor")?.cgColor
        
        firstRobotBattlefieldView.update(state: firstRobotState())
        secondRobotBattlefieldView.update(state: secondRobotState())
        
        registerNotifications()
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onToggleErrorNotification(_:)),
            name: Constants.Notifications.Name.toggleError,
            object: nil)
    }
    
    @objc private func onToggleErrorNotification(_ notification: Notification) {
        guard let shouldShowError = notification.userInfo?[Constants.Notifications.UserInfo.Key.showError] as? Bool else {
            return
        }
        
        print(shouldShowError)
    }
    
    private func firstRobotState() -> BattlefieldViewState {
        BattlefieldViewState(
            hitShots: [
                CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2), CGPoint(x: 0, y: 3),
                CGPoint(x: 0, y: 5), CGPoint(x: 0, y: 6), CGPoint(x: 0, y: 7), CGPoint(x: 0, y: 9),
                CGPoint(x: 1, y: 9), CGPoint(x: 2, y: 0), CGPoint(x: 3, y: 0), CGPoint(x: 4, y: 0),
                CGPoint(x: 6, y: 0), CGPoint(x: 7, y: 0), CGPoint(x: 9, y: 4), CGPoint(x: 3, y: 6),
                CGPoint(x: 7, y: 7), CGPoint(x: 3, y: 9), CGPoint(x: 4, y: 9)
            ],
            missedShots: [
                CGPoint(x: 9, y: 0), CGPoint(x: 3, y: 1), CGPoint(x: 4, y: 1), CGPoint(x: 5, y: 1),
                CGPoint(x: 6, y: 1), CGPoint(x: 8, y: 1), CGPoint(x: 9, y: 1), CGPoint(x: 2, y: 2),
                CGPoint(x: 2, y: 3), CGPoint(x: 6, y: 2), CGPoint(x: 8, y: 2), CGPoint(x: 9, y: 2),
                CGPoint(x: 2, y: 3), CGPoint(x: 5, y: 3), CGPoint(x: 6, y: 3), CGPoint(x: 2, y: 4),
                CGPoint(x: 3, y: 4), CGPoint(x: 5, y: 4), CGPoint(x: 6, y: 4), CGPoint(x: 7, y: 4),
                CGPoint(x: 1, y: 5), CGPoint(x: 2, y: 5), CGPoint(x: 4, y: 5), CGPoint(x: 6, y: 5),
                CGPoint(x: 7, y: 5), CGPoint(x: 4, y: 6), CGPoint(x: 5, y: 7), CGPoint(x: 8, y: 7),
                CGPoint(x: 0, y: 8), CGPoint(x: 8, y: 8), CGPoint(x: 8, y: 9), CGPoint(x: 9, y: 9),
            ],
            ships: [
                CGPoint(x: 4, y: 3)
            ]
        )
    }
    
    private func secondRobotState() -> BattlefieldViewState {
        BattlefieldViewState(
            hitShots: [
                CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0), CGPoint(x: 2, y: 0), CGPoint(x: 4, y: 0),
                CGPoint(x: 1, y: 3), CGPoint(x: 4, y: 2), CGPoint(x: 4, y: 3), CGPoint(x: 4, y: 4),
                CGPoint(x: 4, y: 5), CGPoint(x: 9, y: 5), CGPoint(x: 0, y: 6), CGPoint(x: 1, y: 6),
                CGPoint(x: 3, y: 7), CGPoint(x: 4, y: 7), CGPoint(x: 7, y: 8), CGPoint(x: 8, y: 8),
                CGPoint(x: 9, y: 8), CGPoint(x: 0, y: 9), CGPoint(x: 1, y: 9), CGPoint(x: 4, y: 9)
            ],
            missedShots: [
                CGPoint(x: 6, y: 0), CGPoint(x: 9, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 4, y: 1),
                CGPoint(x: 4, y: 1), CGPoint(x: 5, y: 1), CGPoint(x: 6, y: 1), CGPoint(x: 7, y: 1),
                CGPoint(x: 8, y: 1), CGPoint(x: 3, y: 2), CGPoint(x: 5, y: 2), CGPoint(x: 6, y: 2),
                CGPoint(x: 7, y: 2), CGPoint(x: 6, y: 3), CGPoint(x: 9, y: 3), CGPoint(x: 0, y: 4),
                CGPoint(x: 6, y: 4), CGPoint(x: 7, y: 4), CGPoint(x: 8, y: 4), CGPoint(x: 6, y: 5),
                CGPoint(x: 7, y: 5), CGPoint(x: 8, y: 5), CGPoint(x: 6, y: 6), CGPoint(x: 7, y: 6),
                CGPoint(x: 8, y: 6), CGPoint(x: 9, y: 6), CGPoint(x: 0, y: 7), CGPoint(x: 5, y: 7),
                CGPoint(x: 4, y: 8), CGPoint(x: 6, y: 8), CGPoint(x: 3, y: 9), CGPoint(x: 5, y: 9),
                CGPoint(x: 9, y: 9)
            ],
            ships: []
        )
    }
}
