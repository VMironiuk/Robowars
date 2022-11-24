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
        
        insertSplitViewItem(NSSplitViewItem(viewController: SplitViewComposer.composedMainView()), at: .zero)
        insertSplitViewItem(NSSplitViewItem(sidebarWithViewController: SplitViewComposer.composedSideBar()), at: .zero)
    }
}
