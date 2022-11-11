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
            // TODO: do not hardcode game mode here
            gameEngine: GameEngineFactory.defaultGameEngine(with: .classic)
        )
    }
    
    static func composedMainView() -> NSViewController {
        MainViewController(
            firstBattlefieldViewController: BattlefieldViewController(),
            secondBattlefieldViewController: BattlefieldViewController()
        )
    }
}
