//
//  SplitViewComposer.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 11.11.2022.
//

import Cocoa
import Robowars

struct SplitViewComposer {
    static private let gameModes = GameMode.allCases
    static private let gameSpeeds = GameSpeed.allCases
    static private let gameEngine = GameEngineFactory.defaultGameEngine(with: gameModes.first!)
    static private let robots = [Randomator(model: "R700"), Randomator(model: "R1000")]
    
    private init() {}
    
    static func composedSideBar(withDelegate delegate: SidebarViewControllerDelegate) ->  SidebarViewController {
        SidebarViewController(
            chooseRobotsViewController: ChooseRobotsViewController(firstRobots: robots, secondRobots: robots),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: gameModes),
            chooseGameSpeedViewController: ChooseGameSpeedViewController(gameSpeeds: gameSpeeds),
            gameEngine: gameEngine,
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
