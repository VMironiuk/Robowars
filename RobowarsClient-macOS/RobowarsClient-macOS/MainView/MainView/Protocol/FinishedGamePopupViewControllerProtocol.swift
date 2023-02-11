//
//  FinishedGamePopupViewControllerProtocol.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 07.02.2023.
//

import Cocoa

protocol FinishedGamePopupViewControllerProtocol where Self: NSViewController {
    func show(in parentViewController: NSViewController, with winnerName: String)
    func hide()
}
