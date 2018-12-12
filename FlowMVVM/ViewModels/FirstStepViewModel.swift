//
//  FirstStepViewModel.swift
//  FlowMVVM
//
//  Created by Matias Gualino on 11/12/2018.
//  Copyright © 2018 Matias Gualino. All rights reserved.
//

import Foundation
import RxSwift

class FirstStepViewModel : StepBaseViewModel<FlowInfo>, UITextFieldDelegate {
    
    func continueWith(text: String) {
        self.flowInfo.email = text
        self.nextClicked()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.continueWith(text: textField.text ?? "Empty")
        return true
    }
}
