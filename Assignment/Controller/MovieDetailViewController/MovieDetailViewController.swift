//
//  MovieDetailViewController.swift
//  Assignment
//
//  Created by Sudhanshu Dwivedi on 05/07/23.
//


import UIKit

final class MovieDetailViewController: UIViewController {
    
    init(movieId: String) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var imdbRatingLabel: UILabel!

    // MARK: - Properties
    private var movieId = ""
    private var movieDetailVM = MovieDetailViewModel()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVM()
    }
    
    // MARK: - Data
    private func setupVM() {
        movieDetailVM.getMovieDetail(id: self.movieId)
        movieDetailVM.reloadView = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.setupData()
            }
        }
    }
    
    private func setupData(){
        movieImageView.sd_setImage(with: URL(string: movieDetailVM.imageUrl), completed: nil)
        movieTitleLabel.text = movieDetailVM.title
        releaseDateLabel.attributedText = movieDetailVM.releaseDate
        descriptionLabel.attributedText = movieDetailVM.description
        imdbRatingLabel.attributedText = movieDetailVM.rating
        languageLabel.attributedText = movieDetailVM.language
    }
    
    // MARK: Action
    @IBAction func crossButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
