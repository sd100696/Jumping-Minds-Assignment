//
//  ServiceManager.swift
//  Assignment
//
//  Created by Sudhanshu Dwivedi on 05/07/23.
//


import Foundation

class NetworkManager { 
    
    static let sharedSession = NetworkManager()
    
    private init (){}
    
    func fetchMovies(query: String, completion: @escaping (_ TotalResult: Int?, [Movie]?, Error?) -> Void) {
        let baseMovieURL = URL(string: Constants.baseAPIURL)
        guard let url = baseMovieURL else {
            completion(0, nil, nil)
            return
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let apiKeyQueryItem = URLQueryItem(name: "apikey", value: Constants.apiKey)
        let searchQueryItem = URLQueryItem(name: "s", value: query)
        components?.queryItems = [apiKeyQueryItem, searchQueryItem]
        
        guard let requestURL = components?.url else { completion(0, nil, nil)
            return
        }
        
        let request = URLRequest(url: requestURL)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("There was an error \(error.localizedDescription)")
                completion (0, nil, error)
                return
            }
            
            guard let data = data else {
                completion(0, nil, nil)
                return
            }
            
            do {
                let movieResults = try JSONDecoder().decode(MovieResult.self, from: data)
                completion(Int(movieResults.totalResults ?? ""), movieResults.results, nil)
            } catch {
                print("There was an error \(error.localizedDescription)")
                completion(0, nil, error)
                return
            }
        }.resume()
    }
    
    func getMovieDetail(with id: String, completion: @escaping (MovieDetail?, Error?) -> Void) {
        let baseMovieURL = URL(string: Constants.baseAPIURL)
        guard let url = baseMovieURL else {
            completion(nil, nil)
            return
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let apiKeyQueryItem = URLQueryItem(name: "apikey", value: Constants.apiKey)
        let idQueryIem = URLQueryItem(name: "i", value: id)
        components?.queryItems = [apiKeyQueryItem, idQueryIem]
        
        guard let requestURL = components?.url else { completion(nil, nil)
            return
        }
        
        let request = URLRequest(url: requestURL)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("There was an error \(error.localizedDescription)")
                completion (nil, nil)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            do {
                let movieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
                completion(movieDetail, nil)
            } catch {
                print("There was an error with searching: \(error.localizedDescription)")
                
                completion(nil, nil)
                return
            }
        }.resume()
    }
}
