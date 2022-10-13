//
//  SidebarViewController.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 13.10.2022.
//

import Cocoa

class SidebarViewController: NSViewController {
    
    override var nibName: NSNib.Name? {
        "SidebarView"
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
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
}
