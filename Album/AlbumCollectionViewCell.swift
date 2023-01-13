//
//  AlbumCollectionViewCell.swift
//  Album
//
//  Created by Hüseyin HÖBEK on 11.01.2023.
//

import UIKit
import Kingfisher

class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var viewModel: AlbumViewModel?
    
    
    func configCollectionViewCell(model: PhotoElement) {
        imageView.contentMode = .scaleAspectFill
        
        if let urlString = model.url, let url = URL(string: urlString) {
            print(urlString)
            self.imageView.kf.setImage(with: url)
        }
    }
}
