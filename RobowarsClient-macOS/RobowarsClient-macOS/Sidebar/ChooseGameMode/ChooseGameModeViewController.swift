//
//  ChooseGameModeViewController.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 10.10.2022.
//

import Cocoa
import Robowars

class ChooseGameModeViewController: NSViewController, ChooseGameModeViewControllerProtocol {
    
    @IBOutlet private(set) weak var gameModeComboBox: NSComboBox!
    
    private let gameModes: [GameMode]
    
    var selectedGameMode: GameMode {
        gameModes[gameModeComboBox.indexOfSelectedItem]
    }
    
    var isGameModeInteractionEnabled: Bool {
        didSet {
            gameModeComboBox.isEnabled = isGameModeInteractionEnabled
        }
    }
    
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
        isGameModeInteractionEnabled = false
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
        
        guard !gameModes.isEmpty else { return }
        gameModeComboBox.selectItem(at: .zero)
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
