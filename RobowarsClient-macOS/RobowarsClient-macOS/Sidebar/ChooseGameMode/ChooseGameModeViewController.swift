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
    
    private let gameModes: [GameMode]
    
    weak var delegate: ChooseGameModeViewControllerDelegate? {
        didSet {
            guard let gameMode = gameModes.first else { return }
            delegate?.chooseGameModeViewController(self, gameModeDidChange: gameMode)
        }
    }
    
    override var nibName: NSNib.Name? {
        "ChooseGameModeView"
    }
    
    init(gameModes: [GameMode]) {
        self.gameModes = gameModes
        super.init(nibName: "ChooseGameModeView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameModeComboBox.usesDataSource = true
        gameModeComboBox.dataSource = self
        gameModeComboBox.delegate = self
    }
}

extension ChooseGameModeViewController: NSComboBoxDataSource {
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        gameModes.count
    }
    
    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        gameModes[index].title
    }
}

extension ChooseGameModeViewController: NSComboBoxDelegate {
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let indexOfSelectedItem = gameModeComboBox.indexOfSelectedItem
        let gameMode = gameModes[indexOfSelectedItem]
        delegate?.chooseGameModeViewController(self, gameModeDidChange: gameMode)
    }
}