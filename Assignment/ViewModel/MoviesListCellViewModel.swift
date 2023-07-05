//
//  MoviesListCellViewModel.swift
//  Assignment
//
//  Created by Sudhanshu Dwivedi on 05/07/23.
//

import Foundation

final class MovieListCellViewModel {
    
    var movieData: Movie
    
    init(with movie: Movie){
        self.movieData = movie
    }
    
    var title: String{
        return movieData.title ?? ""
    }
    
    var releaseDate: String{
        return movieData.year ?? ""
    }
    
    var imageURL: String{
        return movieData.poster ?? ""
    }

}
