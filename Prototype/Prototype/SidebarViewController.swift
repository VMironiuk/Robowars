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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstRobotComboBox.selectItem(at: .zero)
        secondRobotComboBox.selectItem(at: .zero)
        gameModeComboBox.selectItem(at: .zero)
    }
}
