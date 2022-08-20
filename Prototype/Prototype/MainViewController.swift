//
//  MainViewController.swift
//  Prototype
//
//  Created by Volodymyr Myroniuk on 20.08.2022.
//

import Cocoa

class MainViewController: NSViewController {
    
    @IBOutlet private weak var errorView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorView.wantsLayer = true
        errorView.layer?.backgroundColor = NSColor(named: "ErrorViewColor")?.cgColor
    }
}
