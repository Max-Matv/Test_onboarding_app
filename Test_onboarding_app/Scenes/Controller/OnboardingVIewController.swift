//
//  OnboardingVIewController.swift
//  Test_onboarding_app
//
//  Created by Maksim Matveichuk on 29.12.23.
//

import UIKit

final class OnboardingVIewController: UIViewController {
    
    private lazy var zStackView: ZStackView = {
        let view = ZStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var button: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 10
        view.setTitleColor(.white, for: .normal)
        view.setTitle("Press".uppercased(), for: .normal)
        return view
    }()
    
    let cont: [OnboardingContent] = [
        OnboardingContent(image: "Image1", info: "Some info"),
        OnboardingContent(image: "Image2", info: "some very useful info"),
        OnboardingContent(image: "Image3", info: "very very useful info")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(zStackView)
        zStackView.addContent(content: cont)
        NSLayoutConstraint.activate([
            zStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            zStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            zStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            zStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        zStackView.isHidden = true
        setupButton()
    }
    
    private func setupButton() {
        view.insertSubview(button, at: 0)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(greaterThanOrEqualToConstant: 33),
            button.widthAnchor.constraint(greaterThanOrEqualToConstant: 66)
        ])
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc
    private func buttonPressed(_ sender: UIButton) {
        zStackView.isHidden = false
        
    }
}

