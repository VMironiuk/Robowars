//
//  ChooseGameModeViewController.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 10.10.2022.
//

import Cocoa
import Robowars

protocol ChooseGameModeViewControllerDelegate: AnyObject {
    func chooseGameModeViewController(_ viewController: ChooseGameModeViewController, gameModeDidChange gameMode: GameMode)
}

class ChooseGameModeViewController: NSViewController {
    
    @IBOutlet private(set) weak var gameModeComboBox: NSComboBox!
    
    private var gameModes: [GameMode]
    
    weak var delegate: ChooseGameModeViewControllerDelegate? {
        didSet {
            guard let gameMode = gameModes.first else { return }
            delegate?.chooseGameModeViewController(self, gameModeDidChange: gameMode)
        }
    }
    
    override var nibName: NSNib.Name? {
        "ChooseGameModeView"
    }
    
    convenience init(gameModes: [GameMode]) {
        self.init(nibName: nil, bundle: nil)
        self.gameModes = gameModes
    }
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        gameModes = []
        super.init(nibName: "ChooseGameModeView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
