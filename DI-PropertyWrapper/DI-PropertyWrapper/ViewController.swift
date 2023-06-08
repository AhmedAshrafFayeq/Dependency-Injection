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
