//
//  ViewController.swift
//  ThreeButtons
//
//  Created by Igor Shvetsov on 05.07.2023.
//

import UIKit

// TODO: - get rid off magic numbers

class ViewController: UIViewController {
    
    private lazy var button1 = buttonFactory()
    private lazy var button2 = buttonFactory()
    private lazy var button3 = buttonFactory()
    
    private let buttonFactory: () -> UIButton = {
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 20)

        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "arrow.forward.circle")
        
        configuration.imagePlacement = .trailing
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 14, bottom: 14, trailing: 10)
        configuration.imagePadding = 8

        return UIButton(configuration: configuration)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupButtons()
        layoutButtons()
    }
    
    private func setupButtons() {
        button1.setTitle("First button", for: .normal)
        button2.setTitle("Second medium button", for: .normal)
        button3.setTitle("Third", for: .normal)
        
        button1.addTarget(self, action: #selector(animateTapping), for: .touchUpInside)
        button2.addTarget(self, action: #selector(animateTapping), for: .touchUpInside)
        button3.addTarget(self, action: #selector(tapThirdButton), for: .touchUpInside)
    }

    private func layoutButtons() {
        
        [button1, button2, button3].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 20).isActive = true
        button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 20).isActive = true
    }
    
    @objc
    private func animateTapping(_ button: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
            button.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
            
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                button.transform = CGAffineTransform.identity
            }
        }
    }
    
    @objc
    private func tapThirdButton() {
        animateTapping(button3)
        
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        vc.modalPresentationStyle = .pageSheet
        
        present(vc, animated: true)
    }
}

