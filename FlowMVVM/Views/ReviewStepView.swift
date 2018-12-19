//
//  ReviewStepView.swift
//  FlowMVVM
//
//  Created by Matias Gualino on 11/12/2018.
//  Copyright © 2018 Matias Gualino. All rights reserved.
//

import Foundation
import UIKit

class ReviewStepView: StepBaseView<Steps, FlowInfo> {
    
    override var step: Steps? { get { return Steps.review } }
    
    override func setup() {
        super.setup()
        
        self.prepareReviewLabel()
    }
    
    fileprivate var reviewLabel: UILabel!
    fileprivate func prepareReviewLabel() {
        let reviewLabel = UILabel()
        reviewLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(reviewLabel)
        
        NSLayoutConstraint.activate([
            reviewLabel.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            reviewLabel.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 0.7),
            reviewLabel.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            ])
        
        reviewLabel.font = UIFont.systemFont(ofSize: 18)
        reviewLabel.textColor = UIColor.red
        reviewLabel.textAlignment = .center
        reviewLabel.numberOfLines = 0
        reviewLabel.text = "FLOW DATA: \n \(self.viewModel.flowInfo.email ?? "Cannot load")"
        
        self.subviews.append(reviewLabel)
        self.reviewLabel = reviewLabel
    }
    
    override func removeFromSuperview() {
        self.reviewLabel?.removeFromSuperview()
    }
}
