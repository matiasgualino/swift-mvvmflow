//
//  StepBaseViewModel.swift
//  FlowMVVM
//
//  Created by Matias Gualino on 11/12/2018.
//  Copyright © 2018 Matias Gualino. All rights reserved.
//

import Foundation
import RxSwift

class StepBaseViewModel: NSObject {
    
    var next = PublishSubject<Bool>()
    var prev = PublishSubject<Bool>()
    
    var flowInfo: FlowInfo
    
    init(flowInfo: FlowInfo) {
        self.flowInfo = flowInfo
    }
    
    @objc func nextClicked() {
        self.next.onNext(true)
    }
    
    @objc func prevClicked() {
        self.prev.onNext(true)
    }
}
