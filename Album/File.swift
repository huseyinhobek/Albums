//
//  File.swift
//  Album
//
//  Created by Hüseyin HÖBEK on 10.01.2023.
//

import Foundation

//func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumCell
//    let album = albumList[indexPath.row]
//    cell.albumTitleLabel.text = album.album.title
//    cell.albumCollectionView.dataSource = self
//    cell.albumCollectionView.delegate = self
//    cell.albumCollectionView.reloadData()
//    return cell
//}
//
//extension AlbumViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return albumList[section].photos.count
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
//        let photo = albumList[indexPath.section].photos[indexPath.row]
//        cell.imageView.kf.setImage(with: URL(string: photo.url))
//        return cell
//    }
//}

