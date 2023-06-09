//
//  SecondViewController.swift
//  DI-PropertyWrapper
//
//  Created by Ahmed Fayek on 09/06/2023.
//

import UIKit

class SecondViewController: UIViewController {
    
    let provider: ColorProviding?
    
    init(provider: ColorProviding?) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = provider?.color ?? .black
    }
    
}
