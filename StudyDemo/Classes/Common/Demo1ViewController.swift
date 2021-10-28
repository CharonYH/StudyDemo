//
//  Demo1ViewController.swift
//  StudyDemo
//
//  Created by Charron on 2021/10/28.
//

import UIKit

class Demo1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initUI()
    }
    //MARK: initUI
    private func initUI() {
        diffDataSource.apply(snapShot)
        
        view.addSubview(collectionView)
        layoutSubViews()
    }
    //MARK: 适配View
    private func layoutSubViews() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(Status_And_Navigation_Height())
            make.left.right.bottom.equalTo(0*RATIO_WIDHT750)
        }
    }
    //MARK: 懒加载
    private lazy var collectionView: UICollectionView = {
        //配置布局样式（5种））
        /*
         plain：和tableView 的plain一样
         grouped：分组 cell与两边没间距 和tableView 的group一样
         insetGrouped：分组 cell与两边有间距
         sidebar: 侧边栏
         sidebarPlain：不透明 选择有圆角
         */
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        //添加左滑手势
        ///UICollectionViewListCell可以像UITableView中一样，添加左右滑动手势，以响应不同的操作需求，但它不是对单个listCell 的操作，而是当成整个列表的-项配置，需要在UICollectionViewLayoutList Conf iguration中配置。配置代码如下:
        listConfiguration.leadingSwipeActionsConfigurationProvider = .some({ indexPath in
            return UISwipeActionsConfiguration(actions: [UIContextualAction(style: .destructive, title: "Delete", handler: { action, view, complete in
                //获取当前section的唯一标示
                let sectionIdentifier = self.snapShot.sectionIdentifiers[indexPath.section]
                //获取所有section的个数
                let numberOfSections = self.snapShot.numberOfSections
                //根据所有section的标示
                let sectionIdentifiers = self.snapShot.sectionIdentifiers
                /*   *  *  */
                //获取当前item的唯一标示
                let itemIdentifier = self.snapShot.itemIdentifiers[indexPath.row]
                //根据所有item的标示
                let itemIdentifiers = self.snapShot.itemIdentifiers
                //获取所有items的个数
                let numberOfItems = self.snapShot.numberOfItems
                //获取当前item在items中的位置
                
                print("sectionIdentifiers = \(sectionIdentifiers)")
                print("sectionIdentifier = \(sectionIdentifier)")
                print("numberOfSections = \(numberOfSections)")
                print("-----------------------")
                print("itemIdentifiers = \(itemIdentifiers)")
                print("itemIdentifier = \(itemIdentifier)")
                print("numberOfItems = \(numberOfItems)")
                print("当前item在items中的位置 = \(self.snapShot.numberOfItems(inSection: sectionIdentifier))")
                var sectionSnapShot = self.diffDataSource.snapshot(for: sectionIdentifier)
                let items = sectionSnapShot.visibleItems
                if items.count > 0 {
                    sectionSnapShot.delete([items[indexPath.row]])
                    self.diffDataSource.apply(sectionSnapShot, to: sectionIdentifier)
                }
            })])
        })
        //布局
        let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        
        return collectionView
    }()
    
    //数据源（cell的数据） 设置数据之前需注册cell
    private lazy var diffDataSource: UICollectionViewDiffableDataSource<String,String> = {
       //cell的样式进行配置（相当于cellRegister）
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell,String> { cell, indexPath, item in
            //对cell进行配置
            var cellConfig = cell.defaultContentConfiguration()
            //设置图片 左侧
            cellConfig.image = UIImage(systemName: "seal.fill")
            //设置图片的额外配置
            /*
             /// The symbol configuration to use.
             public var preferredSymbolConfiguration: UIImage.SymbolConfiguration?

             /// The tintColor to apply to the image view. Nil will use the image view's
             /// normal inherited tintColor.
             public var tintColor: UIColor?

             /// Optional color transformer that is used to resolve the tint color. A nil value means
             /// the `tintColor` is used as-is.
             public var tintColorTransformer: UIConfigurationColorTransformer?

             /// Returns the resolved image tint color for the specified tint color of the view, based on
             /// the `tintColor` and `tintColorTransformer`.
             public func resolvedTintColor(for tintColor: UIColor) -> UIColor

             /// The preferred corner radius (using a continuous corner curve) for the image.
             /// Default is 0. If the image is too small to fit the requested radius, the corner curve
             /// and radius will be adjusted to fit.
             public var cornerRadius: CGFloat

             /// Enforces a maximum size for the image. The default value is CGSize.zero. A zero width or
             /// height means the size is unconstrained on that dimension. If the image exceeds this size
             /// on either dimension, its size will be reduced proportionately (maintaining aspect ratio).
             public var maximumSize: CGSize

             /// The layout size that is reserved for the image, inside which the image will be centered.
             /// The default value is CGSize.zero. The reservedLayoutSize width & height only affect the
             /// space reserved for the image and its positioning; it does not affect the image's size.
             /// A zero width or height means the default behavior is used for that dimension:
             ///     * Symbol images will be centered inside a predefined reservedLayoutSize that is
             ///       scaled with the content size category.
             ///     * Non-symbol images will use a reservedLayoutSize equal to the actual size of the
             ///       displayed image.
             /// This property is used for horizontal alignment of images across adjacent content views
             /// (even when the actual image widths may vary slightly), and/or to ensure the same height
             /// is reserved for different images across different content views (e.g. so the content view
             /// heights are consistent even when the actual image heights may vary slightly). The
             /// reservedLayoutSize.width is ignored by content views at Accessibility Dynamic Type
             /// sizes, and the reservedLayoutSize.height is ignored when using the special Accessibility
             /// Dynamic Type layout where text wraps around the image.
             public var reservedLayoutSize: CGSize

             /// Prevents the image from inverting its colors when the accessibility setting is enabled.
             public var accessibilityIgnoresInvertColors: Bool

             /// A special constant that can be set to the `reservedLayoutSize` width or height. This
             /// forces the system standard value that a symbol image would use for that dimension,
             /// even when the image is not a symbol image.
             public static let standardDimension: CGFloat
             */
            //设置图片的大小、文字
            /*
             scale：图片的大小
             weight：SymbolWeight（目前未知）
             font：UIFont 字体 （目前未知）
             */
            cellConfig.imageProperties.preferredSymbolConfiguration = .init(font: .systemFont(ofSize: 18))
            //设置cell的主标题
            cellConfig.text = item
            //设置cell的副标题
            cellConfig.secondaryText = "Section\(indexPath.section)"
            cellConfig.textProperties.adjustsFontSizeToFitWidth = true
            cellConfig.secondaryTextProperties.numberOfLines = 0

            //设置图片与标题的距离
            cellConfig.imageToTextPadding = 5
            //设置轴的方向：vertical horizontal （以后后面设置cell的内边距）
            cellConfig.axesPreservingSuperviewLayoutMargins = .vertical
            //沿轴方向的内边距 会扩充或压缩cell
            cellConfig.directionalLayoutMargins = .init(top: 11, leading: 16, bottom: 11, trailing: 30)
            var backGroundCellConfig = UIBackgroundConfiguration.listGroupedHeaderFooter()
//            backGroundCellConfig.backgroundColor = .yellow
//            cell.backgroundConfiguration = backGroundCellConfig
//            print("cellConfig = \(cellConfig)")
            cell.contentConfiguration = cellConfig
        }
        //SectionIdentifierType、ItemIdentifierType唯一值确定了数据的唯一性
        let diffDataSource = UICollectionViewDiffableDataSource<String,String>(collectionView: collectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        return diffDataSource
    }()
    /*
     /// Additional properties to configure the image.
     public var imageProperties: UIListContentConfiguration.ImageProperties

     /// The primary text.
     public var text: String?

     /// An attributed variant of the primary text, which supersedes the `text` and some properties of the `textConfiguration` if set.
     public var attributedText: NSAttributedString?

     /// Additional properties to configure the primary text.
     public var textProperties: UIListContentConfiguration.TextProperties

     /// The secondary text.
     public var secondaryText: String?

     /// An attributed variant of the secondary text, which supersedes the `secondaryText` and some properties of the `secondaryTextConfiguration` if set.
     public var secondaryAttributedText: NSAttributedString?

     /// Additional properties to configure the secondary text.
     public var secondaryTextProperties: UIListContentConfiguration.TextProperties

     /// Whether the content view will preserve inherited layout margins from its superview on the horizontal and/or vertical axes.
     public var axesPreservingSuperviewLayoutMargins: UIAxis

     /// The margins for the content to the edges of the content view. (When preserving superview layout margins on one or both axes, these are just minimum margins, as inherited margins may be larger.)
     public var directionalLayoutMargins: NSDirectionalEdgeInsets

     /// When true, the text and secondary text will be positioned side-by-side if there is sufficient space. Otherwise, the text will be stacked in a vertical layout.
     public var prefersSideBySideTextAndSecondaryText: Bool

     /// Padding between the image and text. Only applies when there is both an image and text.
     public var imageToTextPadding: CGFloat

     /// Horizontal (minimum) padding between the text and secondary text. Only applies when there is both text and secondary text, and they are in a side-by-side layout.
     public var textToSecondaryTextHorizontalPadding: CGFloat

     /// Vertical padding between the text and secondary text. Only applies when there is both text and secondary text, and they are in a stacked layout.
     public var textToSecondaryTextVerticalPadding: CGFloat

     */
    //NSDiffableDataSourceSnapshot数据源快照对象 （与diffDataSource对应）
    private lazy var snapShot: NSDiffableDataSourceSnapshot<String,String> = {
        var snapShot = NSDiffableDataSourceSnapshot<String,String>()
        snapShot.appendSections(["Section1","Section2","Section3"])
        snapShot.appendItems(["0", "1", "2"], toSection: "Section1")
        snapShot.appendItems(["3", "4", "5"], toSection: "Section2")
        snapShot.appendItems(["7", "8", "9", "10"], toSection: "Section3")
        return snapShot
    }()
    //之后使用apply更新数据源，无需我们计算发生变化的indexPath，dataSource会自动与snapshot进行比对，计算出差异，即可对UI进行更新，不必手动调用re loadData或reloadSection
}

extension Demo1ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

