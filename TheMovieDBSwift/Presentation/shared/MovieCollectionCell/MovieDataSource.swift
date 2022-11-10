//
//  MovieDataSource.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 30/10/2022.
//

import RxDataSources
import CloudKit

struct MovieSection<Element> {
  var title: String
  var items: [Element]
}

extension MovieSection: SectionModelType {
  typealias Item = Element
    
    var identity: String {
        return title
    }

   init(original: MovieSection, items: [Item]) {
    self = original
    self.items = items
  }
}

struct DataSourceFactory {
//    func make<Element>() -> RxCollectionViewSectionedReloadDataSource<MovieSection<Element>> {
//        let dataSource = RxCollectionViewSectionedReloadDataSource<MovieSection<Element>>(
//            configureCell: { _, collectionView, indexPath, item in
//                let cell = collectionView.dequeue(MovieCollectionCell.self, for: indexPath)
//                cell.configure(item)
//              return cell
//            })
//        return dataSource
//    }
}
