//
//  ReelsViewController.swift
//  Codebase
//
//  Created by 정재욱 on 12/7/23.
//

import UIKit

class ReelsViewController: UIViewController {
    //MARK: - Properties
    
    private lazy var reelsCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    } ()
    
    private var nowPage = 0
    
    private let videoURLStrArr = ["dummyVideo", "dummyVideo02"]

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        addViews()
        setAutoLayout()
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions

    
    //MARK: - Helpers
    private func addViews() {
        view.addSubview(reelsCollectionView)
    }

    private func setAutoLayout() {
        reelsCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func setupCollectionView() {
        reelsCollectionView.delegate = self
        reelsCollectionView.dataSource = self
        reelsCollectionView.decelerationRate = .fast
        reelsCollectionView.register(ReelsCollectionViewCell.self, forCellWithReuseIdentifier: ReelsCollectionViewCell.identifier)
        
        startLoop()
    }
    
    private func startLoop() {
        let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            self.moveNextPage()
        }
    }
    
    private func moveNextPage() {
        let itemCount = reelsCollectionView.numberOfItems(inSection: 0)
        
        nowPage += 1
        if(nowPage >= itemCount) {
            nowPage = 0
        }
        
        reelsCollectionView.scrollToItem(at: IndexPath(item: nowPage, section: 0), at: .centeredVertically, animated: true)
    }
}

extension ReelsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReelsCollectionViewCell.identifier, for: indexPath) as? ReelsCollectionViewCell else { return UICollectionViewCell() }
        cell.setupURL(videoURLStrArr.randomElement()!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ReelsCollectionViewCell {
            cell.videoView?.cleanup()
        }
    }
}

extension ReelsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
