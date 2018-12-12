//
//  StepManager.swift
//  FlowMVVM
//
//  Created by Matias Gualino on 11/12/2018.
//  Copyright © 2018 Matias Gualino. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol StepManagerProtocol {
    func start(containerView: UIView)
}

class StepManager<T: RawRepresentable, I> where T.RawValue == Int {
    
    var currentStep: T!
    var containerView: UIView!
    var currentView: StepBaseView<I>! {
        didSet {
            oldValue?.animateOut()
            self.currentView?.animateIn()
        }
    }
    
    fileprivate var bag = DisposeBag()
    
    var flowAbort = PublishSubject<Bool>()
    var flowFinished = PublishSubject<Bool>()
    
    func onNext() {
        guard let nextStep = T(rawValue: self.currentStep.rawValue + 1) else {
            self.flowFinished.onNext(true)
            return
        }
        
        self.setView(forStep: nextStep)
    }
    
    func onPrev() {
        guard let prevStep = T(rawValue: self.currentStep.rawValue - 1) else {
            self.flowAbort.onNext(true)
            return
        }
        
        self.setView(forStep: prevStep)
    }
    
    fileprivate func setView(forStep: T) {
        guard let view = self.getView(forStep: forStep) else {
            self.flowAbort.onNext(true)
            return
        }
        
        self.addObservers(viewModel: view.viewModel)
        
        self.currentStep = forStep
        self.currentView = view
    }
    
    func getView(forStep: T) -> StepBaseView<I>? {
        return nil
    }
    
    fileprivate func addObservers(viewModel: StepBaseViewModel<I>) {
        viewModel.next
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                [unowned self] _ in
                self.onNext()
            }).disposed(by: self.bag)
        
        viewModel.prev
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                [unowned self] _ in
                self.onPrev()
            }).disposed(by: self.bag)
    }
}

extension StepManager: StepManagerProtocol {
    func start(containerView: UIView) {
        self.containerView = containerView
        
        self.setView(forStep: self.currentStep)
    }
}
