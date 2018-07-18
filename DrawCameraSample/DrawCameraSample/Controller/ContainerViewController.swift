//
//  ContainerViewController.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/10.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

protocol ContainerViewType: class {
    
    func reloadData()
    
}

class ContainerViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var presenter: ContainerViewPresentable = ContainerViewPresenter.init(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.sectionHeadersPinToVisibleBounds = true
        //以下の設定をしないとsectionが表示されない +
        //collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableViewが
        //呼ばれない
        flowLayout.headerReferenceSize = CGSize(width: self.view.bounds.width, height: 50)
        //cellの登録
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
        //headerの登録
        let header_nib = UINib(nibName: "CollectionHeader", bundle: nil)
        collectionView.register(header_nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionHeader")

        collectionView.dataSource = self
        
        getPhotos()
    }
    
    override func viewDidLayoutSubviews() {
        print("view did layout subviews")
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        collectionView.cameraRollGrid(numberOfGridPerRow: 4, gridLineSpace: CGFloat(4))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
        super.viewDidAppear(animated)
        getPhotos()
    }
    
    func getPhotos() {
        presenter.updateDatas()
        collectionView.refreshControl?.beginRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ContainerViewController: ContainerViewType {
    
    func reloadData() {
        collectionView.refreshControl?.endRefreshing()
        collectionView.reloadData()
    }
    
}

extension ContainerViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of item sections")
        return presenter.itemSections(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cell for item at")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let data = presenter.cellImage(indexPath.section, indexPath)
        cell.imageView.image = UIImage(data: data)!
        return cell
    }
    
    //セクション数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("sections")
        return presenter.sections
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionHeader", for: indexPath) as? CollectionHeader else {
            fatalError("Could not find proper header")
        }
        
        if kind == UICollectionElementKindSectionHeader {
            header.label.text = presenter.sectionText(indexPath)
            header.setup()
            print("header")
            return header
        }
        
        print("non header")
        return UICollectionReusableView()
    }
}

//extension ContainerViewController: UICollectionViewDelegateFlowLayout {
//  //sectionが表示されてからも呼ばれていなかったので、別の設定をしなければsectionごとにサイズを変更することができない
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        print("cgsize")
//        return CGSize(width: self.view.bounds.width, height: 50)
//    }
//}
