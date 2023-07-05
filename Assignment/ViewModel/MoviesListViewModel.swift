//
//  MoviesListViewModel.swift
//  Assignment
//
//  Created by Sudhanshu Dwivedi on 05/07/23.
//


import Foundation

final class MoviesListViewModel {
    
    var reloadTableView: (() -> Void)?
    var showError: (() -> Void)?
    var totalCount = 0
    private var movieData = [Movie]()
    private var searchQueryItem = ""
    
    public func searchMovies(){
        guard !searchQueryItem.isEmpty, searchQueryItem.count > 2 else {
            self.removeData()
            return
        }
        
        NetworkManager.sharedSession.fetchMovies(query: searchQueryItem) { [weak self] totalResult, result, error in
            guard let self = self else { return }
            if let data = result{
                self.totalCount = totalResult ?? 0
                self.movieData += data
                self.reloadTableView?()
            } else if error != nil{
                self.showError?()
            }
        }
    }
    
    public func getPrefilledMovieList() {
        NetworkManager.sharedSession.fetchMovies(query: "Life") { [weak self] totalResult, result, error in
            guard let self = self else { return }
            if let data = result{
                self.totalCount = totalResult ?? 0
                self.movieData += data
                self.reloadTableView?()
            } else if error != nil{
                self.showError?()
            }
        }
    }
    
    private func removeData() {
        self.movieData.removeAll()
        self.reloadTableView?()
    }
    
    func setQuery(query: String){
        self.searchQueryItem = query
    }
}

// MARK: CellData
extension MoviesListViewModel{
    
    var numberOfItem: Int{
        return self.movieData.count
    }
    
    func cellViewModel(indexPath: IndexPath) -> MovieListCellViewModel?{
        if indexPath.item >= 0 && indexPath.item < movieData.count{
            let data = movieData[indexPath.row]
            return MovieListCellViewModel(with: data)
        }else{
            return nil
        }
    }
    
    func getMovieId(indexPath: IndexPath) -> String{
        if indexPath.item >= 0 && indexPath.item < movieData.count{
            let data = movieData[indexPath.row]
            return data.imdbID ?? ""
        } else{
            return ""
        }
    }
}


