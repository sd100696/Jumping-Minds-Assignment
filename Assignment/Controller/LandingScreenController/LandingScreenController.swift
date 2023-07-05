//
//  LandingScreenController.swift
//  Assignment
//
//  Created by Sudhanshu Dwivedi on 05/07/23.
//

import UIKit

struct Slide {
    let imageName: String
    let title: String
    let description: String
}

final class LandingScreenController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - Properties
    let slides: [Slide] = [
        Slide(imageName: "slide1", title: "Welcome to MyApp", description: "Track your subscriber growth"),
        Slide(imageName: "slide2", title: "Get Started", description: "Pick the right content channels"),
        Slide(imageName: "slide3", title: "Enjoy", description: "Celebrate your key milestones")
    ]
    
    private var currentIndex: Int = 0
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateSlideContent()
    }
    
    // MARK: - Setup
    private func setupUI() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        nextButton.layer.cornerRadius = 8
        nextButton.layer.masksToBounds = true
    }
    
    // MARK: - Data
    private func updateSlideContent() {
        let slide = slides[currentIndex]
        imageView.image = UIImage(named: slide.imageName)
        titleLabel.text = slide.title
        descriptionLabel.text = slide.description
    }
    
    // MARK: - Action
    @IBAction func nextButtonAction(_ sender: Any) {
        if currentIndex < slides.count - 1 {
            currentIndex += 1
            updateSlideContent()
        } else {
            let vc = MovieListViewController()
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
}
