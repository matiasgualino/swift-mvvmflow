//
//  CustomStepManager.swift
//  FlowMVVM
//
//  Created by Matias Gualino on 12/12/18.
//  Copyright © 2018 Matias Gualino. All rights reserved.
//

import Foundation

enum Steps : Int {
    case first, review, congrats
    
    static var firstStep = Steps.first
}

class CustomStepManager: StepManager<Steps> {
    fileprivate var flowInfo = FlowInfo()
    
    override init() {
        super.init()
        
        self.currentStep = Steps.firstStep
    }
    
    override func getViewAndViewModel(forStep: Steps) -> (StepBaseView, StepBaseViewModel)? {
        switch(forStep) {
        case .first:
            return (FirstStepView(containerView: self.containerView), FirstStepViewModel(flowInfo: self.flowInfo))
        case .review:
            return (ReviewStepView(containerView: self.containerView), ReviewStepViewModel(flowInfo: self.flowInfo))
        case .congrats:
            return (CongratsStepView(containerView: self.containerView), CongratsStepViewModel(flowInfo: self.flowInfo))
        }
    }
}
