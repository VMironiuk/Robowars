//
//  SplitViewComposer.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 11.11.2022.
//

import Cocoa
import Robowars

struct SplitViewComposer {
    static private let gameModes: [GameMode] = GameMode.allCases
    static private let gameSpeeds: [GameSpeed] = [.slow, .fast, .blazinglyFast]
    static private let gameEngine = GameEngineFactory.defaultGameEngine(with: gameModes.first!)
    
    private init() {}
    
    static func composedSideBar(withDelegate delegate: SidebarViewControllerDelegate) ->  SidebarViewController {
        SidebarViewController(
            chooseRobotsViewController: ChooseRobotsViewController(
                firstRobots: [Randomator(model: "R700")],
                secondRobots: [Randomator(model: "R1000")]),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: gameModes),
            chooseGameSpeedViewController: ChooseGameSpeedViewController(gameSpeeds: gameSpeeds),
            gameEngine: Self.gameEngine,
            delegate: delegate
        )
    }
    
    static func composedMainView() -> MainViewController {
        MainViewController(
            firstBattlefieldViewController: BattlefieldViewController(),
            secondBattlefieldViewController: BattlefieldViewController(),
            finishedGamePopupViewController: FinishedGamePopupViewController()
        )
    }
}
