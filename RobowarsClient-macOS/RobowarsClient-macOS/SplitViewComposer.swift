//
//  SplitViewComposer.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 11.11.2022.
//

import Cocoa
import Robowars

struct SplitViewComposer {
    private init() {}
    
    static func composedSideBar() ->  NSViewController {
        SidebarViewController(
            chooseRobotsViewController: ChooseRobotsViewController(robots: []),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: []),
            gameEngine: Self.gameEngine()
        )
    }
    
    static func composedMainView() -> NSViewController {
        let mainVC = MainViewController(
            firstBattlefieldViewController: BattlefieldViewController(),
            secondBattlefieldViewController: BattlefieldViewController()
        )
        Self.gameEngine().delegate = mainVC
        
        return mainVC
    }
    
    private static func gameEngine() -> GameEngineProtocol {
        // TODO: do not hardcode game mode here
        GameEngineFactory.defaultGameEngine(with: .classic)
    }
}
