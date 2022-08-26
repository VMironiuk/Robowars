//
//  MainViewController.swift
//  Prototype
//
//  Created by Volodymyr Myroniuk on 20.08.2022.
//

import Cocoa

class MainViewController: NSViewController {
    
    @IBOutlet private weak var errorView: NSView!
    @IBOutlet private weak var firstRobotBattlefieldView: NSView!
    @IBOutlet private weak var secondRobotBattlefieldView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorView.wantsLayer = true
        errorView.layer?.backgroundColor = NSColor(named: "ErrorViewColor")?.cgColor
        
        firstRobotBattlefieldView.wantsLayer = true
        firstRobotBattlefieldView.layer?.backgroundColor = NSColor(named: "BattlefieldColor")?.cgColor
        
        secondRobotBattlefieldView.wantsLayer = true
        secondRobotBattlefieldView.layer?.backgroundColor = NSColor(named: "BattlefieldColor")?.cgColor
    }
}
