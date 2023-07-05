//
//  MovieDetailViewModel.swift
//  Assignment
//
//  Created by Sudhanshu Dwivedi on 05/07/23.
//

import Foundation
final class MovieDetailViewModel{
    
    var reloadView: (() -> Void)?
    var showError: (() -> Void)?
    private var data: MovieDetail?
    
    func getMovieDetail(id: String){
        NetworkManager.sharedSession.getMovieDetail(with: id) { [weak self] result, error in
            guard let self = self else { return }
            if let data = result{
                self.data = data
                self.reloadView?()
            } else if error != nil{
                self.showError?()
            }
        }
    }
    
    var title: String {
        return data?.title ?? ""
    }
    
    var imageUrl: String {
        return data?.poster ?? ""
    }
    
    var releaseDate: NSAttributedString {
        let date = data?.released ?? ""
        let attributedString = NSMutableAttributedString(string: "Release date: \(date)")
        attributedString.addBoldText("Release date:", fontSize: 14)
        attributedString.addRegularText(date, fontSize: 14)
        return attributedString
    }

    var description: NSAttributedString {
        let plot = data?.plot ?? ""
        let attributedString = NSMutableAttributedString(string: "Plot: \(plot)")
        attributedString.addBoldText("Plot:", fontSize: 14)
        attributedString.addRegularText(plot, fontSize: 14)
        return attributedString
    }

    var language: NSAttributedString {
        let lang = data?.language ?? ""
        let attributedString = NSMutableAttributedString(string: "Language: \(lang)")
        attributedString.addBoldText("Language:", fontSize: 14)
        attributedString.addRegularText(lang, fontSize: 14)
        return attributedString
    }

    var rating: NSAttributedString {
        let rating = data?.imdbRating ?? ""
        let attributedString = NSMutableAttributedString(string: "Rating: \(rating)")
        attributedString.addBoldText("Rating:", fontSize: 14)
        attributedString.addRegularText(rating, fontSize: 14)
        return attributedString
    }
}

