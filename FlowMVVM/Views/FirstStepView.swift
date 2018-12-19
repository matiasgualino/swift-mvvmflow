//
//  FirstStepView.swift
//  FlowMVVM
//
//  Created by Matias Gualino on 11/12/2018.
//  Copyright © 2018 Matias Gualino. All rights reserved.
//

import Foundation
import UIKit

class FirstStepView : StepBaseView<Steps, FlowInfo> {
    
    override var step: Steps? { get { return Steps.first } }
    
    override func setup() {
        super.setup()
        
        self.prepareTextField()
    }
    
    fileprivate var textField: UITextField!
    fileprivate func prepareTextField() {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            textField.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 0.7),
            textField.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            ])
        
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.textColor = UIColor.black
        textField.textAlignment = .center
        textField.minimumFontSize = 20
        textField.adjustsFontSizeToFitWidth = true
        textField.attributedPlaceholder = NSAttributedString(string: "email@email.com", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ])
        textField.delegate = self.viewModel as? FirstStepViewModel
        
        self.subviews.append(textField)
        self.textField = textField
    }
    
    override func nextClicked() {
        (self.viewModel as? FirstStepViewModel)?.continueWith(text: self.textField.text ?? "Empty")
    }
    
    override func removeFromSuperview() {
        self.textField?.removeFromSuperview()
    }
}
