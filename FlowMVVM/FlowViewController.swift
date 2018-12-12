//
//  FlowViewController.swift
//  FlowMVVM
//
//  Created by Matias Gualino on 11/12/2018.
//  Copyright © 2018 Matias Gualino. All rights reserved.
//

import Foundation
import UIKit

class FlowViewController: UIViewController {
    
    var stepManagerProtocol: StepManagerProtocol
    
    init(stepManagerProtocol: StepManagerProtocol) {
        self.stepManagerProtocol = stepManagerProtocol
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.stepManagerProtocol.start(containerView: self.view)
    }
}
