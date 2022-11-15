//
//  SplitViewComposer.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 11.11.2022.
//

import Cocoa
import Robowars

struct SplitViewComposer {
    // TODO: do not hardcode game mode here
    static private let gameEngine = GameEngineFactory.defaultGameEngine(with: .classic)
    
    private init() {}
    
    static func composedSideBar() ->  NSViewController {
        SidebarViewController(
            chooseRobotsViewController: ChooseRobotsViewController(robots: [Misfire()]),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: [.classic, .flyweight]),
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
