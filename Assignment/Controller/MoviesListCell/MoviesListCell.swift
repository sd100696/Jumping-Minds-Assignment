//
//  MoviesListCell.swift
//  Assignment
//
//  Created by Sudhanshu Dwivedi on 05/07/23.
//


import UIKit
import SDWebImage

final class MoviesListCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    
    // MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
    }
    
    //MARK: Setup
    private func setupUI() {
        movieImageView.layer.cornerRadius = 10
        movieImageView.clipsToBounds = true
    }
    
    // MARK: - Data
    func configData(data: MovieListCellViewModel){
        movieTitleLabel.text = data.title
        movieReleaseDateLabel.text = data.releaseDate
        movieImageView.sd_setImage(with: URL(string: data.imageURL), completed: nil)
    }
}
