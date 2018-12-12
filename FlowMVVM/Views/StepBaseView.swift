//
//  StepBaseView.swift
//  FlowMVVM
//
//  Created by Matias Gualino on 11/12/2018.
//  Copyright © 2018 Matias Gualino. All rights reserved.
//

import Foundation
import UIKit

class StepBaseView<I> {
    
    var viewModel : StepBaseViewModel<I>! {
        didSet {
            self.setup()
            self.bind()
        }
    }
    
    fileprivate var containerView: UIView
    
    init(containerView: UIView) {
        self.containerView = containerView
    }
    
    func setup() {
        self.prepareView()
        self.preparePrevButton()
        self.prepareContinueButton()
        
        self.view.backgroundColor = UIColor.white
        self.view.alpha = 0
    }
    
    func bind() { }
    
    var view: UIView!
    fileprivate func prepareView() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            ])
        
        self.view = view
    }
    
    var prevButton: UIButton!
    func preparePrevButton() {
        let prevButton = UIButton()
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(prevButton)
        
        NSLayoutConstraint.activate([
            prevButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            prevButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            ])
        
        prevButton.setTitle("BACK", for: .normal)
        prevButton.setTitleColor(UIColor.black, for: .normal)
        prevButton.addTarget(self.viewModel, action: #selector(self.viewModel.prevClicked), for: .touchUpInside)
        
        self.prevButton = prevButton
    }
    
    var continueButton: UIButton!
    func prepareContinueButton() {
        let continueButton = UIButton()
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            continueButton.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            continueButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            continueButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        continueButton.setTitle("NEXT", for: .normal)
        continueButton.setTitleColor(UIColor.white, for: .normal)
        continueButton.backgroundColor = UIColor.blue
        continueButton.addTarget(self, action: #selector(self.nextClicked), for: .touchUpInside)
        
        self.continueButton = continueButton
    }
    
    @objc func nextClicked() {
        self.viewModel.nextClicked()
    }
    
    func animateIn(completion: (() -> Void)? = nil) {
        self.animate(show: true, completion: completion)
    }
    
    func animateOut(completion: (() -> Void)? = nil) {
        self.animate(show: false, completion: completion)
    }
    
    func animate(show: Bool, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = show ? 1 : 0
        }, completion: {
            _ in
            completion?()
        })
    }
}
