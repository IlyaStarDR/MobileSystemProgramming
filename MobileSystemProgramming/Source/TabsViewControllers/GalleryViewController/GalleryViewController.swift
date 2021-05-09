//
//  GalleryViewController.swift
//  MobileSystemProgramming
//
//  Created by Illia Starodubtcev on 09.05.2021.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<GallerySection, UIImage>!
    
    lazy var layout = createLayout()
    var images: [UIImage] = []

    var imagePicker: ImagePicker!
    
    enum GallerySection {
        case mainSection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        galleryCollectionView.setCollectionViewLayout(layout, animated: false)
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        apply()
    }
    
    func createSnapshot() -> NSDiffableDataSourceSnapshot<GallerySection, UIImage > {
        var newSnapshot = NSDiffableDataSourceSnapshot<GallerySection, UIImage>()
        newSnapshot.appendSections([.mainSection])
                
        newSnapshot.appendItems(images)
        return newSnapshot
    }
    
    func apply() {
        let cellRegistration = UICollectionView.CellRegistration<GalleryCollectionViewCell, UIImage> { (cell, indexPath, item) in
            cell.imageView.image = item
        }
        dataSource = UICollectionViewDiffableDataSource<GallerySection, UIImage>(collectionView: galleryCollectionView) { collectionView, indexPath, identifier in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        let snapshot = createSnapshot()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        imagePicker.present()
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let item2x2 = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3),
                                                   heightDimension: .fractionalHeight(1.0)))
            
            let item1x1 = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0)))
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1/4)),
                subitem: item1x1, count: 3)
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                   heightDimension: .fractionalHeight(1.0)),
                
                subitem: item1x1, count: 2)
            
            let horizontalBigGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(0.5)),
                
                subitems: [verticalGroup, item2x2])
            
            let nestedGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(4/3)),
                
                subitems: [horizontalGroup, horizontalBigGroup, horizontalGroup])
            
            
            let section = NSCollectionLayoutSection(group: nestedGroup)
            return section
            
        }
        return layout
    }
    
}

extension GalleryViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        guard let image = image else {
            return
        }
        images.append(image)
        apply()
    }
}
