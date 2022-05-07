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
    var pages: [Onboarding.OnboardingPage]!
    
    // Inits
    init(pages: [Onboarding.OnboardingPage]) {
        super.init()
        self.pages = pages
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = FCComponentsStyle.backgroundView.dynamicColor

        pageVC.setViewControllers([self.viewControllerAtIndex(index: 0)],
                                  direction: .forward,
                                  animated: true)
        pageVC.dataSource = self
        pageVC.delegate = self
        
        self.addChild(pageVC)
        self.setLayoutViews()
        self.pageVC.didMove(toParent: self)
        self.changeStyle()
    }
}

// MARK: - Events
extension OnboardingPageVC {
    func viewControllerAtIndex(index: Int) -> OnboardingContentPageVC {
        let onboardingPage = self.pages[index]
        let contentPageVC = OnboardingContentPageVC(onboardingPage: onboardingPage)
        contentPageVC.pageIndex = index
        return contentPageVC
    }
    
    @objc func didSelectContinueButton() {
        guard let currentPage = pageVC.viewControllers?.first as? OnboardingContentPageVC else { return }
        guard let currentIndex = currentPage.pageIndex else { return }
        
        if currentIndex < (pages.count - 1) {
            let nextPage = viewControllerAtIndex(index: currentPage.pageIndex + 1)
            pageControl.currentPage = nextPage.pageIndex
            pageVC.setViewControllers([nextPage], direction: .forward, animated: true)
            updatesButtonTitle(for: nextPage.pageIndex)
        } else {
            UserConfig.hasShownOnboarding = true
            
            let bankCoordinator = BankCoordinator(context: self.context!)
            bankCoordinator.start()
        }
    }
    
    @objc func didSelectExitButton() {
        UserConfig.hasShownOnboarding = true
        
        let bankCoordinator = BankCoordinator(context: self.context!)
        bankCoordinator.start()
    }
}


// MARK: - Layout
extension OnboardingPageVC {
    func setLayoutViews() {
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
            
            pageControl.topAnchor(equalTo: pageView.bottomAnchor)
            pageControl.centerXAnchor(equalTo: self.view.centerXAnchor)
            pageControl.bottomAnchor(equalTo: stackView.topAnchor, constant: -margin * 1.5)
        }
    }
}

// MARK: - UI
extension OnboardingPageVC {
    func setupPageVC() -> UIPageViewController {
        let pageVC = UIPageViewController(transitionStyle: .scroll,
                                          navigationOrientation: .horizontal)
        return pageVC
    }
    
    func setupPageControl() -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.backgroundColor = .clear
        pageControl.currentPage = 0
        pageControl.numberOfPages = pages.count
        pageControl.hidesForSinglePage = true
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }
    
    private func setupButton() -> UIButton {
        let button = UIButton()
        let fontSize: CGFloat = UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 12 : 14
        button.titleLabel?.font = .fcMediumFont(ofSize: fontSize)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.heightAnchor(equalTo: CGFloat(46))
        return button
    }
    
    private func setupContinueButton() -> UIButton {
        let button = setupButton()
        button.setTitle(literal(.onboardingStepNextButton), for: .normal)
        button.addTarget(self, action: #selector(didSelectContinueButton), for: .touchUpInside)
        return button
    }
    
    private func setupExitButton() -> UIButton {
        let button = setupButton()
        button.setTitle(literal(.onboardingStepExitButton), for: .normal)
        button.addTarget(self, action: #selector(didSelectExitButton), for: .touchUpInside)
        return button
    }
    
    private func updatesButtonTitle(for index: Int) {
        if index == (pages.count - 1) {
            continueButton.setTitle(literal(.onboardingStepContinueButton), for: .normal)
        } else {
            continueButton.setTitle(literal(.onboardingStepNextButton), for: .normal)
        }
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
        if (index == pages.count) {
            return nil
        }
        return self.viewControllerAtIndex(index: index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

// MARK: - PageViewController Delegate
extension OnboardingPageVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let contentPageVC = pageViewController.viewControllers?.first as? OnboardingContentPageVC {
            if let index = contentPageVC.pageIndex {
                pageControl.currentPage = index
                updatesButtonTitle(for: index)
            }
        }
    }
}

// MARK: - Style
extension OnboardingPageVC {
    func changeStyle() {
        let palette = Configuration.shared.palette
        pageControl.pageIndicatorTintColor = palette.pageDotInactive.dynamicColor
        pageControl.currentPageIndicatorTintColor = palette.pageDotActive.dynamicColor
        continueButton.backgroundColor = palette.buttonActiveBackground.dynamicColor
        continueButton.setTitleColor(palette.buttonActiveText.dynamicColor, for: .normal)
        exitButton.backgroundColor = palette.buttonPassiveBackground.dynamicColor
        exitButton.setTitleColor(palette.buttonPassiveText.dynamicColor, for: .normal)
    }
}
