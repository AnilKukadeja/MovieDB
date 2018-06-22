//
//  DBManager.swift
//  MovieDB
//
//  Created by Parth Adroja on 01/05/18.
//  Copyright © 2018 Anil Kukadeja. All rights reserved.
//

import Foundation
import SQLite

struct MoviesTable {
    static let table = Table("movie")
    static let id = Expression<Int>("id")
    static let title = Expression<String>("title")
    static let backdropPath = Expression<String>("backdropPath")
    static let voteAverage = Expression<Double>("voteAverage")
    static let posterPath = Expression<String>("posterPath")
    static let releaseDate = Expression<String>("releaseDate")
    static let overView = Expression<String>("overView")
}

class DBManager {
    
    static let shared = DBManager()
    let db: Connection = {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        
        return try! Connection("\(path)/MovieDB.sqlite")
    }()
    
    func createMovieDBSchema() {
        let _ = try? db.run(MoviesTable.table.create(ifNotExists: true) { movies in
            movies.column(MoviesTable.id, primaryKey: true)
            movies.column(MoviesTable.title)
            movies.column(MoviesTable.backdropPath)
            movies.column(MoviesTable.voteAverage)
            movies.column(MoviesTable.posterPath)
            movies.column(MoviesTable.releaseDate)
            movies.column(MoviesTable.overView)
        })
    }
    
    func insertMoviesToDB(movies: [MovieList]) {
        createMovieDBSchema()
        do {
            try db.transaction {
                for movie in movies {
                    let movieInsert = MoviesTable.table.insert(or: .replace,
                                                                  MoviesTable.id <- movie.id!,
                                                                  MoviesTable.title <- movie.title!,
                                                                  MoviesTable.backdropPath <- movie.backdropPath ?? "N/A",
                                                                  MoviesTable.voteAverage <- movie.voteAverage ?? 0.0,
                                                                  MoviesTable.posterPath <- movie.posterPath ?? "N/A",
                                                                  MoviesTable.overView <- movie.overView ?? "N/A",
                                                                  MoviesTable.releaseDate <- movie.releaseDate ?? "N/A")
                    let _ = try db.run(movieInsert)
                }
            }
        } catch {
            print("Failed Inserting Movies: \(error.localizedDescription)")
        }
    }
    
    func getMoviesFromDB() -> [[String:Any]]? {
        var moviesList = [[String : Any]]()
        do {
            for movies in try db.prepare(MoviesTable.table) {
                var movieObj = [String : Any]()
                movieObj["id"] = movies[MoviesTable.id]
                movieObj["title"] = movies[MoviesTable.title]
                movieObj["backdrop_path"] = movies[MoviesTable.backdropPath]
                movieObj["overview"] = movies[MoviesTable.overView]
                movieObj["vote_average"] = movies[MoviesTable.voteAverage]
                movieObj["release_date"] = movies[MoviesTable.releaseDate]
                movieObj["poster_path"] = movies[MoviesTable.posterPath]
                moviesList.append(movieObj)
            }
            return moviesList
        } catch {
            print("Error getting movies: \(error.localizedDescription)")
        }
        return nil
    }
}
