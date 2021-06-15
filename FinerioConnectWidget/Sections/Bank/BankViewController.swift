//
//  BankViewController.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

internal class BankViewController: BaseViewController {
    internal var bankViewModel: BankViewModel!
    private lazy var titleLabel: UILabel = setupTitleLabel()
    private lazy var collectionViewBanks: UICollectionView = setupCollectionViewBanks()

    override func viewDidLoad() {
        super.viewDidLoad()

        startLoader()
        bankViewModel = viewModel as? BankViewModel
        observerServiceStatus()
        bankViewModel.loadBanks()
    }

    private func configureView() {
        title = bankViewModel.getTitle()

        [titleLabel, collectionViewBanks].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        titleLabel.widthAnchor(equalTo: 200)
        titleLabel.topAnchor(equalTo: view.safeTopAnchor, constant: 25)
        titleLabel.centerXAnchor(equalTo: view.centerXAnchor)

        collectionViewBanks.topAnchor(equalTo: titleLabel.bottomAnchor, constant: 30)
        collectionViewBanks.leadingAnchor(equalTo: view.leadingAnchor, constant: 30)
        collectionViewBanks.trailingAnchor(equalTo: view.trailingAnchor, constant: -30)
        collectionViewBanks.bottomAnchor(equalTo: view.safeBottomAnchor, constant: -30)
    }
}

// MARK: - UI

extension BankViewController {
    private func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = Configuration.shared.texts.banksTitle
        label.font = .fcBoldFont(ofSize: 20)
        label.textColor = Configuration.shared.palette.mainTextColor
        return label
    }

    private func setupCollectionViewBanks() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.register(BankCollectionViewCell.self, forCellWithReuseIdentifier: BankCollectionViewCell.id)
        return collectionView
    }
}

// MARK: - Observers View Model

extension BankViewController {
    private func observerServiceStatus() {
        bankViewModel?.serviceStatusHandler = { [weak self] status in
            guard let `self` = self else { return }
            self.stopLoader()
            switch status {
            case .active: break
            case .success: break
            case .loaded:
                self.configureView()
            case .failure:
                self.app.showAlert(self.bankViewModel.errorMessage, viewController: self)
            case .updated: break
            case .interactive: break
            case .error: break
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension BankViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bankViewModel.banks.count
    }
}

extension BankViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BankCollectionViewCell.id, for: indexPath as IndexPath) as! BankCollectionViewCell
        cell.setup(with: bankViewModel.banks[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        context?.initialize(coordinator: CredentialCoordinator(context: context!, bank: bankViewModel.banks[indexPath.row]))
    }
}

extension BankViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.frame.size.width - 25

        return CGSize(width: collectionWidth / 2, height: 100)
    }
}
