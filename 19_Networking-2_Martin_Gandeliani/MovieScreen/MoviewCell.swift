//
//  MoviesManager.swift
//  19_Networking-2_Martin_Gandeliani
//
//  Created by Martin on 28.11.25.
//

import UIKit

class MoviewCell: UITableViewCell {
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let titleLbl = UILabel()
    let yearLbl = UILabel()
    let sourceLbl = UILabel()
    let valueLbl = UILabel()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUi() {
        
        let uiComponents = [posterImageView, titleLbl, yearLbl, sourceLbl, valueLbl]
        uiComponents.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            posterImageView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLbl.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            titleLbl.centerXAnchor.constraint(equalTo: posterImageView.centerXAnchor),
            titleLbl.bottomAnchor.constraint(equalTo: yearLbl.topAnchor, constant: -10),
            
            yearLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 20),
            yearLbl.centerXAnchor.constraint(equalTo: titleLbl.centerXAnchor),
            yearLbl.bottomAnchor.constraint(equalTo: sourceLbl.topAnchor, constant: -10),
            
            sourceLbl.topAnchor.constraint(equalTo: yearLbl.bottomAnchor, constant: 20),
            sourceLbl.centerXAnchor.constraint(equalTo: yearLbl.centerXAnchor),
            sourceLbl.bottomAnchor.constraint(equalTo: valueLbl.topAnchor, constant: -10),
            
            valueLbl.topAnchor.constraint(equalTo: sourceLbl.bottomAnchor, constant: 20),
            valueLbl.centerXAnchor.constraint(equalTo: sourceLbl.centerXAnchor),
            valueLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
    }
    
    func configure(with movie: Movie) {
        titleLbl.text = "Movie title: \(movie.title)"
        yearLbl.text = "Movie year: \(movie.year)"
        
        if let url = URL(string: movie.poster) {
            URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: data)
                    }
                }.resume()
            } else {
                print("სურათი ვერ ჩამოიტვირთა")
                posterImageView.image = nil
            }
        }
    }

