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
        let movieImageUrl = WebServiceAPIConstants.imageURL + movie.backdropPath!
        imgMoviePoster.kf.setImage(with: URL(string: movieImageUrl))
        let smallPosterUrl = WebServiceAPIConstants.imageURL + movie.posterPath!
        imgMovieSmallPoster.kf.setImage(with: URL(string: smallPosterUrl))
        labelMovieName.text = movie.title ?? "N/A"
        labelMovieOverView.text = movie.overView ?? "N/A"
        labelMovieReleaseDates.text = movie.releaseDate
        labelMovieAverageVotes.text = "\(String(describing: movie.voteAverage ?? 0))"
    }
}
