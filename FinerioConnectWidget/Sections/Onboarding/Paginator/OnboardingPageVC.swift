//
//  OnboardingPageVC.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 02/05/22.
//  Copyright © 2022 Finerio Connect. All rights reserved.
//

import UIKit

class OnboardingPageVC: BaseViewController {
    // Components
    private lazy var continueButton: UIButton = setupContinueButton()
    private lazy var exitButton: UIButton = setupExitButton()
    private lazy var pageControl: UIPageControl = setupPageControl()
    private lazy var pageVC: UIPageViewController = setupPageVC()
    
    // Vars
    var onboardingModel: [OnboardingModel.Page]!
    
    // Inits
    init(onboardingModel: [OnboardingModel.Page]) {
        super.init()
        self.onboardingModel = onboardingModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        pageVC.setViewControllers([self.viewControllerAtIndex(index: 0)],
                                  direction: .forward,
                                  animated: true)
        pageVC.dataSource = self
        pageVC.delegate = self
        
        self.addChild(pageVC)
        
        let margin: CGFloat = 20
        let stackView = UIStackView(arrangedSubviews: [exitButton, continueButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        self.view.addSubview(stackView)
        stackView.bottomAnchor(equalTo: self.view.safeBottomAnchor, constant: -margin * 4)
        stackView.leadingAnchor(equalTo: self.view.leadingAnchor, constant: margin)
        stackView.trailingAnchor(equalTo: self.view.trailingAnchor, constant: -margin)
        
        if let pageView = self.pageVC.view {
            self.view.addSubview(pageView)
            self.view.addSubview(pageControl)
            
            pageView.topAnchor(equalTo: self.view.topAnchor)
            pageView.leadingAnchor(equalTo: self.view.leadingAnchor)
            pageView.trailingAnchor(equalTo: self.view.trailingAnchor)
            pageView.bottomAnchor(equalTo: pageControl.topAnchor)
            
            pageControl.topAnchor(equalTo: pageView.bottomAnchor)
            pageControl.centerXAnchor(equalTo: self.view.centerXAnchor)
            pageControl.bottomAnchor(equalTo: stackView.topAnchor, constant: -margin)
        }
        
        
        self.pageVC.didMove(toParent: self)
    }
}

// MARK: - Events
extension OnboardingPageVC {
    func viewControllerAtIndex(index: Int) -> OnboardingContentPageVC {
        
        let onboardingPage = self.onboardingModel[index]
        let contentPageVC = OnboardingContentPageVC(onboardingPage: onboardingPage)
        contentPageVC.pageIndex = index
        return contentPageVC
        
//        if (onboardingModel.count == 0) || (index >= onboardingModel.count) {
//            return OnboardingContentPageVC()
//        }
//        let vc = OnboardingContentPageVC()
//        vc.pageIndex = index
//        return vc
    }
}

// MARK: - UI
extension OnboardingPageVC {
    func setupPageVC() -> UIPageViewController {
        let pageVC = UIPageViewController(transitionStyle: .scroll,
                                          navigationOrientation: .horizontal)
        pageVC.view.backgroundColor = .purple
        return pageVC
    }
    
    func setupPageControl() -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .green
        pageControl.backgroundColor = .clear
        pageControl.currentPage = 0
        pageControl.numberOfPages = onboardingModel.count
        pageControl.hidesForSinglePage = true
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }
    
    private func setupButton() -> UIButton {
        let button = UIButton()
        let fontSize: CGFloat = UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 12 : 14
        button.titleLabel?.font = .fcMediumFont(ofSize: fontSize)
        #warning("TEST COLOR")
        button.backgroundColor = .red
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.heightAnchor(equalTo: CGFloat(46))
        return button
    }
    
    private func setupContinueButton() -> UIButton {
        let button = setupButton()
        button.setTitle(literal(.onboardingStepContinueButton), for: .normal)
//        button.addTarget(self, action: #selector(didSelectContinueButton), for: .touchUpInside)
        return button
    }
    
    private func setupExitButton() -> UIButton {
        let button = setupButton()
        button.setTitle(literal(.onboardingStepExitButton), for: .normal)
//        button.addTarget(self, action: #selector(didSelectExitButton), for: .touchUpInside)
        return button
    }
}

// MARK: - PageViewController Data Source
extension OnboardingPageVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? OnboardingContentPageVC else { return nil }
        var index = vc.pageIndex as Int
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        index -= 1
        return self.viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? OnboardingContentPageVC else { return nil }
        var index = vc.pageIndex as Int
        if (index == NSNotFound) {
            return nil
        }
        index += 1
        if (index == onboardingModel.count) {
            return nil
        }
        return self.viewControllerAtIndex(index: index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return onboardingModel.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

// MARK: - PageViewController Delegate
extension OnboardingPageVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let contentPageVC = pageViewController.viewControllers?.first as? OnboardingContentPageVC {
            pageControl.currentPage = contentPageVC.pageIndex
        }
    }
}
