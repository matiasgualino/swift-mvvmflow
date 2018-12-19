//
//  CongratsStepView.swift
//  FlowMVVM
//
//  Created by Matias Gualino on 11/12/2018.
//  Copyright © 2018 Matias Gualino. All rights reserved.
//

import Foundation
import UIKit

class CongratsStepView : StepBaseView<Steps, FlowInfo> {
 
    override var step: Steps? { get { return Steps.congrats } }
    
    override func setup() {
        super.setup()
        
        self.prepareCongratsLabel()
    }
    
    fileprivate var congratsLabel: UILabel!
    fileprivate func prepareCongratsLabel() {
        let congratsLabel = UILabel()
        congratsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(congratsLabel)
        
        NSLayoutConstraint.activate([
            congratsLabel.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            congratsLabel.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 0.7),
            congratsLabel.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            ])
        
        congratsLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        congratsLabel.textColor = UIColor.green
        congratsLabel.textAlignment = .center
        congratsLabel.text = "Finish flow!"
        
        self.subviews.append(congratsLabel)
        self.congratsLabel = congratsLabel
    }
    
    override func removeFromSuperview() {
        self.congratsLabel?.removeFromSuperview()
    }
}
