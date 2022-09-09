//
//  SidebarViewController.swift
//  Prototype
//
//  Created by Volodymyr Myroniuk on 07.09.2022.
//

import Cocoa

class SidebarViewController: NSViewController {
    
    @IBOutlet private weak var firstRobotComboBox: NSComboBox!
    @IBOutlet private weak var secondRobotComboBox: NSComboBox!
    @IBOutlet private weak var gameModeComboBox: NSComboBox!
    @IBOutlet private weak var showErrorCheckBox: NSButton!
    
    private var shouldShowError: Bool = false {
        didSet {
            let userInfo = [Constants.Notifications.UserInfo.Key.showError : shouldShowError]
            NotificationCenter.default.post(name: Constants.Notifications.Name.toggleError, object: nil, userInfo: userInfo)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstRobotComboBox.selectItem(at: .zero)
        secondRobotComboBox.selectItem(at: .zero)
        gameModeComboBox.selectItem(at: .zero)
        shouldShowError = showErrorCheckBox.state == .on
    }
    
    @IBAction func showErrorCheckBoxAction(_ sender: NSButton) {
        shouldShowError = sender.state == .on
    }
}
