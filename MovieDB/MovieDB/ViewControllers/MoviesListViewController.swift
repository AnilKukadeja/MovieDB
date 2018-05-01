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
import SVProgressHUD

class MoviesListViewController: UIViewController {
    
    @IBOutlet weak var tableViewMovieList: UITableView!
    
    var currentPage = 1
    var totalPage = 1
    
    var moviesList = [MovieList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movies = DBManager.shared.getMoviesFromDB(), movies.count > 0 {
            let mappedMovies = Mapper<MovieList>().mapArray(JSONArray: movies)
            self.moviesList = mappedMovies
            reloadTableView()
        } else {
            getMovieList(currentPage: currentPage)
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
    
    func getMovieList(currentPage : Int){
        
        // Add URL parameters
        let urlParams = [
            WebServiceAPIConstants.apiKey: "201f3add5604b108ffe6d1d53dd54a87",
            WebServiceAPIConstants.page: currentPage
            ] as [String : Any]
        
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()

        // Fetch Request
        Alamofire.request(WebServiceAPIConstants.nowPlayingMovies, method: .get, parameters: urlParams)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                SVProgressHUD.dismiss()
                if (response.result.error == nil) {
                    if let resultDictonary = response.result.value as? [String:Any] {
                        if let mappedModel = Mapper<ResponseModel>().map(JSON: resultDictonary){
                            if let totalPage = mappedModel.total_pages {
                                self.totalPage = totalPage
                            }
                            if let movies = mappedModel.results, movies.count > 0 {
                                self.moviesList.append(contentsOf: movies)
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
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesListTableViewCell", for: indexPath) as? MoviesListTableViewCell else{
            return UITableViewCell()
        }
        
        cell.labelMovieName.text = moviesList[indexPath.row].title ?? "Default Title"
        cell.labelReleaseDate.text = moviesList[indexPath.row].releaseDate ?? "Default Date"
        
        if let imageUrl = moviesList[indexPath.row].posterPath{
            cell.imgMovieThumbnail.kf.setImage(with: URL(string: WebServiceAPIConstants.imageURL + imageUrl))
        }else{
            cell.imgMovieThumbnail.image = nil
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let movieDetailViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else { return }
        movieDetailViewControllerObj.movieDetails = moviesList[indexPath.row]
        self.navigationController?.pushViewController(movieDetailViewControllerObj, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        if(indexPath.row == (moviesList.count) - 1){
            
            if(currentPage <= totalPage){
                getMovieList(currentPage: currentPage)
                currentPage += 1
            }
        }
        
    }
    
}
