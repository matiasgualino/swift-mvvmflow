//
//  ViewController.swift
//  FlowMVVM
//
//  Created by Matias Gualino on 11/12/2018.
//  Copyright © 2018 Matias Gualino. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    fileprivate var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareStartFlowButton()
    }
    
    fileprivate var startButtonFlow: UIButton!
    fileprivate func prepareStartFlowButton() {
        let startButtonFlow = UIButton()
        startButtonFlow.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(startButtonFlow)
        
        NSLayoutConstraint.activate([
            startButtonFlow.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            startButtonFlow.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            startButtonFlow.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            startButtonFlow.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        startButtonFlow.setTitle("START FLOW", for: .normal)
        startButtonFlow.setTitleColor(UIColor.white, for: .normal)
        startButtonFlow.backgroundColor = UIColor.blue
        startButtonFlow.addTarget(self, action: #selector(self.startFlow), for: .touchUpInside)
    }
    
    @objc fileprivate func startFlow() {
        let stepManager = CustomStepManager()
        stepManager.flowAbort
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                [unowned self] _ in
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: self.bag)
        
        stepManager.flowFinished
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                [unowned self] _ in
                self.navigationController?.popViewController(animated: true)
        }).disposed(by: self.bag)
        
        let flowViewController = FlowViewController(stepManagerProtocol: stepManager)
        self.navigationController?.pushViewController(flowViewController, animated: true)
    }

}
