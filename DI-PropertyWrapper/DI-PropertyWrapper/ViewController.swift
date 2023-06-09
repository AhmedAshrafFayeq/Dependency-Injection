//
//  ViewController.swift
//  DI-PropertyWrapper
//
//  Created by Ahmed Fayek on 07/06/2023.
//

import UIKit
import Swinject

protocol ColorProviding {
    var color: UIColor {get}
}

class ColorProvider: ColorProviding {
    var color: UIColor {
        let colors: [UIColor] = [.systemBlue, .systemMint, . systemGreen]
        return colors.randomElement()!
    }
}

class ViewController: UIViewController {
    
    
    let container: Container = {
        let container = Container()
        container.register(ColorProviding.self) { _ in
            return ColorProvider()
        }
        container.register(SecondViewController.self) { resolver in
            let vc = SecondViewController(provider: resolver.resolve(ColorProviding.self))
            return vc
        }
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .lightGray
        let button = UIButton(frame: CGRect(x: 0, y: 150, width: 200, height: 50))
        button.setTitle("Tap me", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func didTapButton() {
        guard let vc = container.resolve(SecondViewController.self) else {return}
        present(vc, animated: true)
    }

}


// Container:
// 1- Should register Protcol in the Container and return the Class which implements it.
// 2- Should register the VC in the Container and return the resolve of that type of protocol.
