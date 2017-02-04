//
//  PokeCell.swift
//  pokedex
//
//  Created by oubaida alquraan on 2/2/17.
//  Copyright © 2017 oubaida alquraan. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    
    var _pokemon: Pokemon!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    
    func configureCell(_ pokemon: Pokemon){
        
        self._pokemon = pokemon
        
        nameLbl.text = self._pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self._pokemon.pokedexId)")
    }
    
    
}
