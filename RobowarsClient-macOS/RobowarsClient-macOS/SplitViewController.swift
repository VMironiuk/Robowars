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
        
        let mainView = SplitViewComposer.composedMainView()
        let sideBar = SplitViewComposer.composedSideBar(withDelegate: mainView)
        
        insertSplitViewItem(NSSplitViewItem(viewController: mainView), at: .zero)
        insertSplitViewItem(NSSplitViewItem(sidebarWithViewController: sideBar), at: .zero)
    }
}
