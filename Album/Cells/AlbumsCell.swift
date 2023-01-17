//
//  AlbumsCell.swift
//  Album
//
//  Created by Hüseyin HÖBEK on 6.01.2023.
//

import UIKit
import Kingfisher



class AlbumCell: UITableViewCell {
    
    @IBOutlet weak var userIDLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: AlbumViewModel?
    var currentAlbum: AlbumObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel = AlbumViewModel(webService: WebService())
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        fetchAlbumList()
    }
    
    private func fetchAlbumList() {
        
        guard let viewModel = viewModel else {return}
        viewModel.fetchData(completion: { result in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
    
    func configCell(model: AlbumObject) {
        currentAlbum = model
        userIDLabel.text = "User: \(model.album.userID)"
        userIDLabel.backgroundColor = UIColor.gray
        userIDLabel.textColor = UIColor.black
        collectionView.reloadData()
    }
}

extension AlbumCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentAlbum?.photos.count ?? 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AlbumCollectionViewCell
        let photo = currentAlbum?.photos[indexPath.item]
        cell.configCollectionViewCell(model: photo!)
        return cell
    }

}

extension AlbumCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 140)
    }
}
