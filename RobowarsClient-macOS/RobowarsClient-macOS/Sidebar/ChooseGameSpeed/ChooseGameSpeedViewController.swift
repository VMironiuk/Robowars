//
//  ChooseGameSpeedViewController.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 10.01.2023.
//

import Cocoa
import Robowars

class ChooseGameSpeedViewController: NSViewController, ChooseGameSpeedViewControllerProtocol {

    @IBOutlet private weak var gameSpeedComboBox: NSComboBox!
    
    private let gameSpeeds: [GameSpeed]
    
    weak var delegate: ChooseGameSpeedViewControllerDelegate? {
        didSet {
            guard let gameSpeed = gameSpeeds.first else { return }
            delegate?.chooseGameSpeedViewController(self, gameSpeedDidChange: gameSpeed)
        }
    }
    
    var isGameSpeedInteractionEnabled: Bool {
        didSet {
            gameSpeedComboBox.isEnabled = isGameSpeedInteractionEnabled
        }
    }
    
    override var nibName: NSNib.Name? {
        "ChooseGameSpeedView"
    }
    
    init(gameSpeeds: [GameSpeed]) {
        self.gameSpeeds = gameSpeeds
        isGameSpeedInteractionEnabled = false
        super.init(nibName: "ChooseGameSpeedView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameSpeedComboBox.usesDataSource = true
        gameSpeedComboBox.dataSource = self
        gameSpeedComboBox.delegate = self
        
        guard !gameSpeeds.isEmpty else { return }
        gameSpeedComboBox.selectItem(at: .zero)
    }
}

extension ChooseGameSpeedViewController: NSComboBoxDataSource {
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        gameSpeeds.count
    }
    
    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        gameSpeeds[index].rawValue
    }
}

extension ChooseGameSpeedViewController: NSComboBoxDelegate {
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let indexOfSelectedItem = gameSpeedComboBox.indexOfSelectedItem
        let gameSpeed = gameSpeeds[indexOfSelectedItem]
        delegate?.chooseGameSpeedViewController(self, gameSpeedDidChange: gameSpeed)
    }
}
