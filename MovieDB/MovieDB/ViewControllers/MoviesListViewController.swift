//
//  ViewController.swift
//  MovieDB
//
//  Created by Anil Kukadeja on 30/04/18.
//  Copyright © 2018 Anil Kukadeja. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher

class MoviesListViewController: UIViewController {
    
    @IBOutlet weak var tableViewMovieList: UITableView!
    var moviesList: [MovieList]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movies = DBManager.shared.getMoviesFromDB(), movies.count > 0 {
            let mappedMovies = Mapper<MovieList>().mapArray(JSONArray: movies)
            self.moviesList = mappedMovies
            reloadTableView()
        } else {
            getMovieList()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }

}

// MARK: Custom Methods

extension MoviesListViewController{
    
    func reloadTableView(){
        tableViewMovieList.reloadData()
    }
}

// MARK: Webservice Call Methods

extension MoviesListViewController{
    
    func getMovieList(){
        
            // Add URL parameters
            let urlParams = [
                WebServiceAPIConstants.apiKey:"201f3add5604b108ffe6d1d53dd54a87",
                WebServiceAPIConstants.page:"1",
                ]
            
            // Fetch Request
            Alamofire.request(WebServiceAPIConstants.nowPlayingMovies, method: .get, parameters: urlParams)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    if (response.result.error == nil) {
                        if let resultDictonary = response.result.value as? [String:Any] {
                            if let mappedModel = Mapper<ResponseModel>().map(JSON: resultDictonary){
                                if let movies = mappedModel.results, movies.count > 0 {
                                    self.moviesList = movies
                                    DBManager.shared.insertMoviesToDB(movies: movies)
                                }
                                
                                self.reloadTableView()
                            }
                        }
                    }
                    else {
                    }
            }
    }
    
}

// MARK: UITableViewDataSource & Delegate Methods Methods

extension MoviesListViewController : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesListTableViewCell", for: indexPath) as? MoviesListTableViewCell else{
            return UITableViewCell()
        }
        
        if let movieList = moviesList {
            cell.labelMovieName.text = movieList[indexPath.row].title ?? "Default Title"
            cell.labelReleaseDate.text = movieList[indexPath.row].releaseDate ?? "Default Date"
            let imageUrl = WebServiceAPIConstants.imageURL + movieList[indexPath.row].posterPath!
            cell.imgMovieThumbnail.kf.setImage(with: URL(string: imageUrl)!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let movieDetailViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else { return }
        movieDetailViewControllerObj.movieDetails = moviesList?[indexPath.row]
        self.navigationController?.pushViewController(movieDetailViewControllerObj, animated: true)
    }
    
}
