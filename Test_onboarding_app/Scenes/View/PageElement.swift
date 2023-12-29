//
//  PageElement.swift
//  Test_onboarding_app
//
//  Created by Maksim Matveichuk on 29.12.23.
//

import Foundation
import UIKit

final class PageElement: UIView {
    
    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 18)
        view.textAlignment = .center
        return view
    }()
    
    private lazy var button: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = .orange
        view.setTitleColor(.white, for: .normal)
        view.setTitle("next".uppercased(), for: .normal)
        return view
    }()
    
    var buttonAction: (Bool) -> Void = {_ in }
    
    private var isFinal: Bool = false {
        didSet {
            if isFinal {
                button.backgroundColor = .red
                button.setTitleColor(.white, for: .normal)
                button.setTitle("close".uppercased(), for: .normal)
            } else {
                button.backgroundColor = .orange
                button.setTitleColor(.white, for: .normal)
                button.setTitle("next".uppercased(), for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addContent(content: OnboardingContent, isFinal: Bool) {
        self.isFinal = isFinal
        label.text = content.info
        image.image = UIImage(named: content.image)
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.7
        layer.masksToBounds = false
        
        addSubview(image)
        addSubview(button)
        addSubview(label)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor,constant: 15),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1/1),
            image.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    @objc
    private func buttonPressed(_ sender: UIButton) {
        buttonAction(isFinal)
    }
    
}
