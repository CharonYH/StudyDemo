//
//  OutlineViewController.swift
//  StudyDemo
//
//  Created by Charron on 2021/10/26.
//

import UIKit

class OutlineViewController: UIViewController {

    enum Section {
        case main
    }
    //MARK: 初始化
    var outlineCollectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource<Section, OutlineItem>! = nil
    class OutlineItem: Hashable {

        var title: String = ""
        let subItems:[OutlineItem]
        let outlineViewController: UIViewController.Type?
        
        init(title: String,
             viewController: UIViewController.Type? = nil,
             subItems:[OutlineItem]) {
            self.title = title
            self.subItems = subItems
            self.outlineViewController = viewController
        }
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        static func == (lhs: OutlineViewController.OutlineItem, rhs: OutlineViewController.OutlineItem) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        private let identifier = UUID()
    }
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Modern Collection Views"
//        initUI()
    }
    //MARK: initUI
//    private func initUI() {
//        view.addSubview(colllectionView)
//        layoutSubViews()
//    }
    //MARK: 适配View
//    private func layoutSubViews() {
//        colllectionView.snp.makeConstraints { make in
//            make.top.bottom.left.right.equalTo(0)
//        }
//    }
    //MARK: 懒加载
//    private lazy var colllectionView: UICollectionView = {
//        let colllectionView = UICollectionView(frame: .zero,collectionViewLayout: generateLayout())
////        colllectionView.delegate = self
//        return colllectionView
//    }()
//    private lazy var menuItems: [OutlineItem] = {
////        return 
//    }()
}

//extension OutlineViewController {
//    private func configDataSource() {
//
//        /// 配置cell （苹果帮我们解耦）
//        let containerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell,OutlineItem> { cell, indhexPath, item in
//            var contentConfiguration = cell.defaultContentConfiguration()
//            contentConfiguration.text = item.title
//            contentConfiguration.textProperties.font = .preferredFont(forTextStyle: .headline)
//            cell.contentConfiguration = contentConfiguration
//
//            let disclousureOption = UICellAccessory.OutlineDisclosureOptions(style: .header)
//            cell.accessories = [.outlineDisclosure(options: disclousureOption)]
//            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
//        }
//
//        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell,OutlineItem> { cell, indhexPath, item in
//            var contentConfiguration = cell.defaultContentConfiguration()
//            contentConfiguration.text = item.title
//            cell.contentConfiguration = contentConfiguration
//            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
//        }
//
//        dataSource = UICollectionViewDiffableDataSource<Section,OutlineItem>(collectionView: outlineCollectionView, cellProvider: { collectionView, indexPath, item in
//            if item.subItems.isEmpty {
//                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
//            }else {
//                return collectionView.dequeueConfiguredReusableCell(using: containerCellRegistration, for: indexPath, item: item)
//            }
//        })
//
//        // load our initial data
////        let snapshot =
//    }
//    private func generateLayout() -> UICollectionViewCompositionalLayout {
//        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .sidebar)
//        let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
//        return layout
//    }
//
//    private func initalSnapshot() -> NSDiffableDataSourceSectionSnapshot<OutlineItem>{
//        var snapshot = NSDiffableDataSourceSectionSnapshot<OutlineItem>()
//       func addItems(_ menuItems: [OutlineItem],to parent: OutlineItem?) {
//            snapshot.append(menuItems, to: parent)
//        for menuItem in menuItems where !menuItem.subItems.isEmpty {
//            addItems(menuItem.subItems, to: menuItem)
//            }
//        }
//        addItems(menuItems, to: nil)
//        return snapshot
//    }
//}

//extension OutlineViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
//}
