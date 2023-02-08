//
//  ChooseGameSpeedViewControllerProtocol.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 08.02.2023.
//

import Cocoa
import Robowars

protocol ChooseGameSpeedViewControllerDelegate: AnyObject {
    func chooseGameSpeedViewController(
        _ viewController: ChooseGameSpeedViewController,
        gameSpeedDidChange gameSpeed: GameSpeed)
}

protocol ChooseGameSpeedViewControllerProtocol where Self: NSViewController {
    var delegate: ChooseGameSpeedViewControllerDelegate? { get set }
    var isGameSpeedInteractionEnabled: Bool { get set }
}
