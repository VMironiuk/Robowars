//
//  SplitViewController.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 25.10.2022.
//

import Cocoa

class SplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSplitViewItem(NSSplitViewItem(sidebarWithViewController: SplitViewComposer.composedSideBar()))
        addSplitViewItem(NSSplitViewItem(viewController: SplitViewComposer.composedMainView()))
    }
}
