//
//  BattlefieldViewController.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 03.11.2022.
//

import Cocoa

final class BattlefieldViewController: NSViewController {
    private var battlefieldView: BattlefieldView? {
        view as? BattlefieldView
    }
    
    override var nibName: NSNib.Name? {
        "BattlefieldView"
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "BattlefieldView", bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BattlefieldViewController: BattlefieldViewControllerProtocol {
    func updateBattlefieldSize(_ newBattlefieldSize: CGSize) {
        battlefieldView?.updateBattlefieldSize(newBattlefieldSize)
    }
    
    func updateShips(_ newShips: [CGRect]) {
        battlefieldView?.updateShips(with: newShips.points)
    }
    
    func updateTile(with state: TileState) {
        battlefieldView?.updateTile(with: state)
    }
}
