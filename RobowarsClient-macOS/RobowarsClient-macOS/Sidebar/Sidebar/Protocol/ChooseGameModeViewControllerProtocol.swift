//
//  ChooseGameModeViewControllerProtocol.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 08.02.2023.
//

import Cocoa
import Robowars

protocol ChooseGameModeViewControllerDelegate: AnyObject {
    func chooseGameModeViewController(_ viewController: ChooseGameModeViewController, gameModeDidChange gameMode: GameMode)
}

protocol ChooseGameModeViewControllerProtocol where Self: NSViewController {
    var delegate: ChooseGameModeViewControllerDelegate? { get set }
    var selectedGameMode: GameMode { get }
    var isGameModeInteractionEnabled: Bool { get set }
}
