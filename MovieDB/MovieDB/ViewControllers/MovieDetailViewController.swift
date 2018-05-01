//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by Parth Adroja on 30/04/18.
//  Copyright © 2018 Anil Kukadeja. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var imgMovieSmallPoster: UIImageView!
    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var labelMovieName: UILabel!
    @IBOutlet weak var labelMovieOverView: UILabel!
    @IBOutlet weak var labelMovieReleaseDates: UILabel!
    @IBOutlet weak var labelMovieAverageVotes: UILabel!
    
    var movieDetails: MovieList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    func configureView() {
        
        self.navigationController?.isNavigationBarHidden = true
        
        if let movieDetails = movieDetails {
            configureMovieDetails(movie: movieDetails)
        }
    }
    
    func configureMovieDetails(movie: MovieList) {
        
        if let movieImageUrl = movie.backdropPath{
                imgMoviePoster.kf.setImage(with: URL(string: WebServiceAPIConstants.imageURL + movieImageUrl))
        }
        
        if let smallPosterUrl = movie.posterPath{
                imgMovieSmallPoster.kf.setImage(with: URL(string: WebServiceAPIConstants.imageURL + smallPosterUrl))
        }
        
        labelMovieName.text = movie.title ?? "N/A"
        labelMovieOverView.text = movie.overView ?? "N/A"
        labelMovieReleaseDates.text = movie.releaseDate ?? "N/A"
        labelMovieAverageVotes.text = "\(String(describing: movie.voteAverage ?? 0))"
    }
}
