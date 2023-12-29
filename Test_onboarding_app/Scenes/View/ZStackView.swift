//
//  ZStackView.swift
//  Test_onboarding_app
//
//  Created by Maksim Matveichuk on 29.12.23.
//

import Foundation
import UIKit

final class ZStackView: UIView {
    
    private var content = [OnboardingContent]() {
        didSet{
            setupData()
        }
    }
    
    private var acviews = [PageElement]()
    private var views = [PageElementConstraints]()
    private var activeView: Int = 0
    private var duration = 0.2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSwipes()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addContent(content: [OnboardingContent]) {
        self.content = content
    }
    
    private func setupData() {
        
        for (index, element) in content.enumerated() {
            let view = PageElement()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addContent(content: element, isFinal: index == content.count - 1)
            view.buttonAction = { isFinal in
                if !isFinal {
                    self.nextPage()
                } else {
                    self.isHidden = true
                }
            }
            insertSubview(view, at: 0)
            if index == 0 {
                setupMainView(view)
            } else {
                let previousView = views[index - 1].view
                let width = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: previousView, attribute: .width, multiplier: 0.9, constant: 0)
                width.isActive = true
                let height = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: previousView, attribute: .height, multiplier: 0.9, constant: 0)
                height.isActive = true
                let centerX = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                centerX.isActive = true
                let centerY = NSLayoutConstraint()
                let bottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: previousView, attribute: .bottom, multiplier: 1, constant: 10)
                bottom.isActive = true
                let pageElementConstranints = PageElementConstraints(view: view, widthAnchor: width, heightAnchor: height, centerY: centerY, centerX: centerX, bottom: bottom)
                views.append(pageElementConstranints)
            }
        }
    }
    private func setupMainView(_ view: UIView) {
        let width = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.9, constant: 0)
        width.isActive = true
        let height = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.6, constant: 0)
        height.isActive = true
        let centerX = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        centerX.isActive = true
        let centerY = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 0.8, constant: 0)
        centerY.isActive = true
        let bottom = NSLayoutConstraint()
        let pageElementConstranints = PageElementConstraints(view: view, widthAnchor: width, heightAnchor: height, centerY: centerY, centerX: centerX, bottom: bottom)
        views.append(pageElementConstranints)
    }
    private func nextPage() {
        if activeView != views.count - 1 {
            animateActiveView(multiplier: -1)
            activeView += 1
            recalculateConstraints()
            UIView.animate(withDuration: duration) {
                self.layoutIfNeeded()
            }
        }
    }
    private func previousePage() {
        if activeView > 0 {
            activeView -= 1
            animateActiveView(multiplier: 1)
            recalculateConstraints()
            UIView.animate(withDuration: duration) {
                self.layoutIfNeeded()
            }
        }
    }
    
    private func animateActiveView(multiplier: CGFloat) {
        views[activeView].centerX.isActive = false
        views[activeView].bottom.isActive = false
        views[activeView].view.removeConstraint(views[activeView].centerX)
        let newX = NSLayoutConstraint(item: views[activeView].view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: multiplier, constant: 0)
        newX.isActive = true
        views[activeView].centerX = newX
    }
    
    private func recalculateConstraints() {
        for (index, element) in views.enumerated() {
           
            if index == activeView {
                element.bottom.isActive = false
                element.centerY.isActive = false
                element.widthAnchor.isActive = false
                element.heightAnchor.isActive = false
                element.view.removeConstraints([element.centerY, element.widthAnchor, element.heightAnchor])
                let centerY = NSLayoutConstraint(item: element.view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 0.8, constant: 0)
                centerY.isActive = true
                views[index].centerY = centerY
                let width = NSLayoutConstraint(item: element.view, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.9, constant: 0)
                width.isActive = true
                views[index].widthAnchor = width
                let height = NSLayoutConstraint(item: element.view, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.6, constant: 0)
                height.isActive = true
                views[index].heightAnchor = height
                let bottom = NSLayoutConstraint()
                views[index].bottom = bottom
            }
            if index > activeView {
                let previousView = views[index - 1].view
                element.bottom.isActive = false
                element.centerY.isActive = false
                element.widthAnchor.isActive = false
                element.heightAnchor.isActive = false
                element.view.removeConstraints([element.centerY, element.widthAnchor, element.heightAnchor, element.bottom])
                let width = NSLayoutConstraint(item: element.view, attribute: .width, relatedBy: .equal, toItem: previousView, attribute: .width, multiplier: 0.9, constant: 0)
                width.isActive = true
                views[index].widthAnchor = width
                let height = NSLayoutConstraint(item: element.view, attribute: .height, relatedBy: .equal, toItem: previousView, attribute: .height, multiplier: 0.9, constant: 0)
                height.isActive = true
                views[index].heightAnchor = height
                let centerY = NSLayoutConstraint()
                views[index].centerY = centerY
                let bottom = NSLayoutConstraint(item: element.view, attribute: .bottom, relatedBy: .equal, toItem: previousView, attribute: .bottom, multiplier: 1, constant: 10)
                bottom.isActive = true
                views[index].bottom = bottom
            }
        }
    }
    private func setupSwipes() {
        let LeftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        LeftSwipeGesture.direction = .left
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        rightSwipeGesture.direction = .right
        addGestureRecognizer(LeftSwipeGesture)
        addGestureRecognizer(rightSwipeGesture)
    }

    @objc
    private func swipeAction(_ swipe: UISwipeGestureRecognizer) {
        switch swipe.direction {
        case .left:
            nextPage()
        case .right:
            previousePage()
        default:
            break
        }
    }
}
