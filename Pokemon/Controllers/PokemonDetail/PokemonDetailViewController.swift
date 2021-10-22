//
//  PokemonDetailViewController.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 13.10.2021.
//

import UIKit
import RxSwift
import RxCocoa

class PokemonDetailViewController: BaseViewController<PokemonDetailViewModel> {
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    
        collectionViewLayout.minimumInteritemSpacing = 30
        collectionViewLayout.minimumLineSpacing = 30
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(PokemonSpritesCollectionViewCell.self, forCellWithReuseIdentifier: PokemonSpritesCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)

        return collectionView
    }()
    
    
    var sprites: Sprites?
    var spriteUrls = [String]()
    let disposeBag = DisposeBag()
    
    override func prepareViewControllerConfigurations() {
        super.prepareViewControllerConfigurations()
        
        viewModel.delegate = self
        bindStatus()
        configureCollectionView()
        fetchSprites()
    }
    
    private func fetchSprites() {
        viewModel.fetchSprites()
    }

    private func configureCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12)
        ])
        
        collectionView.reloadData()
    }
}

extension PokemonDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonSpritesCollectionViewCell.identifier, for: indexPath) as? PokemonSpritesCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: self.spriteUrls[indexPath.row])
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.spriteUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.5, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as? HeaderCollectionReusableView else { return UICollectionReusableView() }
        header.prepareReuseableView(with: sprites)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 210)
    }
}

extension PokemonDetailViewController: StatusProtocol {
    func bindStatus() {
        viewModel.pageLoadingStatus
            .subscribe(onNext: { [weak self] pageLoadingStatus in
                guard let self = self else { return }
                switch pageLoadingStatus {
                case .loading:
                    DispatchQueue.main.async {
                        self.collectionView.isHidden = true
                        self.lottieView.play()
                    }
                case .success:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.collectionView.isHidden = false
                        self.lottieView.stop()
                        self.collectionView.reloadData()
                    }
                case let .error(error):
                    print("error: \(error)")
                }
            })
            .disposed(by: disposeBag)
    }
}

extension PokemonDetailViewController: PokemonDetailViewModelOutputDelegate {
    func pokemonUrls(urls: [String]) {
        self.spriteUrls = urls
        self.collectionView.reloadData()
    }
}
