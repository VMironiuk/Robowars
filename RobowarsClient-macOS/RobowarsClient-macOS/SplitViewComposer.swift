//
//  SplitViewComposer.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 11.11.2022.
//

import Cocoa
import Robowars

struct SplitViewComposer {
    static private let gameModes: [GameMode] = [.classic, .flyweight]
    static private let gameSpeeds: [GameSpeed] = [.slow, .fast, .blazinglyFast]
    static private let gameEngine = GameEngineFactory.defaultGameEngine(with: gameModes.first!)
    
    private init() {}
    
    static func composedSideBar() ->  NSViewController {
        SidebarViewController(
            chooseRobotsViewController: ChooseRobotsViewController(firstRobots: [Misfire()], secondRobots: [Misfire()]),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: gameModes),
            chooseGameSpeedViewController: ChooseGameSpeedViewController(gameSpeeds: gameSpeeds),
            gameEngine: Self.gameEngine
        )
    }
    
    static func composedMainView() -> NSViewController {
        let mainVC = MainViewController(
            firstBattlefieldViewController: BattlefieldViewController(),
            secondBattlefieldViewController: BattlefieldViewController()
        )
        Self.gameEngine.delegate = mainVC
        
        return mainVC
    }
}
