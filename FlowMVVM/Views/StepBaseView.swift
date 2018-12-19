//
//  StepBaseView.swift
//  FlowMVVM
//
//  Created by Matias Gualino on 11/12/2018.
//  Copyright © 2018 Matias Gualino. All rights reserved.
//

import Foundation
import UIKit

class StepBaseView<T: RawRepresentable, I> where T.RawValue == Int {
    
    var step: T? { get { return nil } }

    var viewModel : StepBaseViewModel<I>! {
        didSet {
            self.setup()
            self.bind()
        }
    }
    
    var containerView: UIView
    
    var subviews = [UIView]()
    
    init(containerView: UIView) {
        self.containerView = containerView
    }
    
    func setup() {
        self.preparePrevButton()
        self.prepareContinueButton()
        
        self.containerView.backgroundColor = UIColor.white
    }
    
    func bind() { }
    
    func removeFromSuperview() {
        self.prevButton?.removeFromSuperview()
        self.continueButton?.removeFromSuperview()
    }
    
    var prevButton: UIButton!
    func preparePrevButton() {
        let prevButton = UIButton()
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(prevButton)
        
        NSLayoutConstraint.activate([
            prevButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20),
            prevButton.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 20),
            ])
        
        prevButton.setTitle("BACK", for: .normal)
        prevButton.setTitleColor(UIColor.black, for: .normal)
        prevButton.addTarget(self.viewModel, action: #selector(self.viewModel.prevClicked), for: .touchUpInside)
        
        self.subviews.append(prevButton)
        self.prevButton = prevButton
    }
    
    var continueButton: UIButton!
    func prepareContinueButton() {
        let continueButton = UIButton()
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            continueButton.widthAnchor.constraint(equalTo: self.containerView.widthAnchor),
            continueButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            continueButton.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        continueButton.setTitle("NEXT", for: .normal)
        continueButton.setTitleColor(UIColor.white, for: .normal)
        continueButton.backgroundColor = UIColor.blue
        continueButton.addTarget(self, action: #selector(self.nextClicked), for: .touchUpInside)
        
        self.subviews.append(continueButton)
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
        let alpha = show ? CGFloat(1) : CGFloat(0)
        UIView.animate(withDuration: 0.3, animations: {
            self.subviews.forEach({ $0.alpha = alpha })
        }, completion: {
            _ in
            completion?()
        })
    }
}
