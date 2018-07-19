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
    
    func reloadDataAfterDelete()
    
    func navigateVC(_ entity: PhotoData)
}

class ContainerViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var presenter: ContainerViewPresentable = ContainerViewPresenter.init(self)
    
    //選択セルの情報(indexPath)を保持するための配列
    private var checkArray: NSMutableArray = []
    
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
        //delegate
        collectionView.dataSource = self
        collectionView.delegate = self
        //データ取得
        getPhotos()
        //observer
        NotificationCenter.default.addObserver(self, selector: #selector(cancelButtonTapped), name: NSNotification.Name("reflesh"), object: nil)
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
    
    //選択モードにする
    @objc func rightBarButtonTapped() {
        print("bar button tapped")
        //self.setEditing(true, animated: true)
        collectionView.allowsMultipleSelection = true
        NotificationCenter.default.post(name: NSNotification.Name("editing"), object: nil)
    }

    //選択モードをやめる
    @objc func cancelButtonTapped() {
        resetCollection()
        collectionView.allowsMultipleSelection = false
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "endEditing"), object: nil)
    }
    
    //キャンセルが押されたとき、チェックがついてるセルのチェックを消す
    private func resetCollection() {
        checkArray.removeAllObjects()
        collectionView.reloadData()
    }
    
    @objc func deleteNotification() {
        guard checkArray.count != 0 else {
            return
        }
        let alert = UIAlertController(title: "", message: "選択した写真は削除されます。", preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: "\(checkArray.count)枚の写真を削除", style: .default, handler: { action in
            print("delete push")
            self.deletePhotos()
            self.cancelButtonTapped()
        })
        alert.addAction(delete)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    //選択した写真情報を削除
    private func deletePhotos() {
        var elements: [(section: Int, row: Int)] = []
        checkArray.forEach({ (element) -> Void in
            let indexPath = element as! IndexPath
            elements.append((indexPath.section, indexPath.row))
        })
        presenter.deleteDatas(elements)
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
    
    func reloadDataAfterDelete() {
        getPhotos()
        reloadData()
    }
    
    func navigateVC(_ entity: PhotoData) {
        let vc = PhotoDetailViewController()
        vc.data = entity
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ContainerViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of item sections")
        return presenter.itemSections(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        //reset
        //元々のライフサイクルでcellが使い回されるため、いったんリセットする
        cell.imageView.image = nil
        cell.checkView.image = nil
        
        //set
        let data = presenter.cellImage(indexPath.section, indexPath)
        cell.imageView.image = UIImage(data: data)!
        if checkArray.contains(indexPath) {
            cell.checkView.image = UIImage(named: "check.png")!
        }
        return cell
    }
    
    //セクション数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.sections
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionHeader", for: indexPath) as? CollectionHeader else {
            fatalError("Could not find proper header")
        }
        
        if kind == UICollectionElementKindSectionHeader {
            header.label.text = presenter.sectionText(indexPath)
            header.setup()
            return header
        }
        return UICollectionReusableView()
    }
}

extension ContainerViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.allowsMultipleSelection {
            if checkArray.contains(indexPath) {
                checkArray.remove(indexPath)
            } else {
                checkArray.add(indexPath)
            }
            collectionView.reloadData()
        } else {
            presenter.didSelectRow(in: indexPath.section, at: indexPath)
        }
    }
    
    
}

//extension ContainerViewController: UICollectionViewDelegateFlowLayout {
//  //sectionが表示されてからも呼ばれていなかったので、別の設定をしなければsectionごとにサイズを変更することができない
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        print("cgsize")
//        return CGSize(width: self.view.bounds.width, height: 50)
//    }
//}
