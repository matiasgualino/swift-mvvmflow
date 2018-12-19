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

class CustomStepManager: StepManager<Steps, FlowInfo> {
    fileprivate var flowInfo = FlowInfo()
    
    override init() {
        super.init()
        
        self.currentStep = Steps.firstStep
    }
    
    override func getView(forStep: Steps) -> StepBaseView<Steps, FlowInfo>? {
        switch(forStep) {
        case .first:
            let firstView = FirstStepView(containerView: self.containerView)
            firstView.viewModel = FirstStepViewModel(flowInfo: self.flowInfo)
            self.currentStep = firstView.step
            return firstView
        case .review:
            let reviewView = ReviewStepView(containerView: self.containerView)
            reviewView.viewModel = ReviewStepViewModel(flowInfo: self.flowInfo)
            self.currentStep = reviewView.step
            return reviewView
        case .congrats:
            let congratsView = CongratsStepView(containerView: self.containerView)
            congratsView.viewModel = CongratsStepViewModel(flowInfo: self.flowInfo)
            self.currentStep = congratsView.step
            return congratsView
        }
    }
}
