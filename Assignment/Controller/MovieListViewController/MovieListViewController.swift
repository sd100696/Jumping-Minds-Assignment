//
//  ViewController.swift
//  Assignment
//
//  Created by Sudhanshu Dwivedi on 05/07/23.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private var moviesVM = MoviesListViewModel()
    private var pageNo = 1
    private var searchQuery = ""
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupVM()
    }
    
    private func setupTableView(){
        tableView.register(UINib(nibName: "MoviesListCell", bundle: nil), forCellReuseIdentifier: "MoviesListCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Data
    private func setupVM(){
        moviesVM.reloadTableView = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        moviesVM.getPrefilledMovieList()
    }
}

// MARK: Searchbar Delegate
extension MovieListViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        moviesVM.setQuery(query: searchText)
        moviesVM.searchMovies()
    }
}

//MARK: TableView Delegates & DataSource
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesVM.numberOfItem
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesListCell", for: indexPath) as? MoviesListCell else{
            return UITableViewCell()
        }
        if let data = moviesVM.cellViewModel(indexPath: indexPath){
            cell.configData(data: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = moviesVM.getMovieId(indexPath: indexPath)
        if !id.isEmpty{
            let vc = MovieDetailViewController(movieId: id)
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
