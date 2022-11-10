//
//  MovieDataSource.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 30/10/2022.
//

import RxDataSources

struct MovieSection {
  var title: String
  var items: [Item]
}

extension MovieSection: SectionModelType {
  typealias Item = Movie
    
    var identity: String {
        return title
    }

   init(original: MovieSection, items: [Item]) {
    self = original
    self.items = items
  }
}

struct DataSourceFactory {
    func mak() -> RxCollectionViewSectionedReloadDataSource<MovieSection> {
        let dataSource = RxCollectionViewSectionedReloadDataSource<MovieSection>(
            configureCell: { _, collectionView, indexPath, item in
                let cell = collectionView.dequeue(MovieCollectionCell.self, for: indexPath)
                cell.configure(item)
              return cell
            })
        return dataSource
    }
}
