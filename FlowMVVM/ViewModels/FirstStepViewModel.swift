//
//  FirstStepViewModel.swift
//  FlowMVVM
//
//  Created by Matias Gualino on 11/12/2018.
//  Copyright © 2018 Matias Gualino. All rights reserved.
//

import Foundation
import RxSwift

class FirstStepViewModel : StepBaseViewModel {
    
    func continueWith(text: String) {
        self.flowInfo.email = text
        self.nextClicked()
    }
}

extension FirstStepViewModel: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.continueWith(text: textField.text ?? "Empty")
        return true
    }
    
}
