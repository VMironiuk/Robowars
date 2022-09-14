//
//  FinishedGamePopupViewController.swift
//  Prototype
//
//  Created by Volodymyr Myroniuk on 13.09.2022.
//

import Cocoa

class FinishedGamePopupViewController: NSViewController {
    
    @IBOutlet private weak var backgroundView: NSView!
    @IBOutlet private weak var popupView: NSView!
        
    override var nibName: NSNib.Name? {
        "FinishedGamePopupView"
    }
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "FinishedGamePopupView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundView()
        setupPopupView()
    }
    
    func show(in parentViewController: NSViewController) {
        parentViewController.addChild(self)
        parentViewController.view.addSubview(self.view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: parentViewController.view.leadingAnchor),
            view.topAnchor.constraint(equalTo: parentViewController.view.topAnchor),
            view.trailingAnchor.constraint(equalTo: parentViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: parentViewController.view.bottomAnchor)
        ])
    }
    
    func hide() {
        removeFromParent()
        view.removeFromSuperview()
    }
    
    private func setupBackgroundView() {
        backgroundView.wantsLayer = true
        backgroundView.layer?.backgroundColor = .black
        backgroundView.alphaValue = 0.5
    }
    
    private func setupPopupView() {
        popupView.wantsLayer = true
        popupView.layer?.backgroundColor = .white
        popupView.layer?.cornerRadius = 10
    }
    
    @IBAction func closeButtonAction(_ sender: NSButton) {
        hide()
    }
}
