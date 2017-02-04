//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by oubaida alquraan on 2/3/17.
//  Copyright © 2017 oubaida alquraan. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var hightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        typeLbl.text = ""
        defenseLbl.text = ""
        attackLbl.text = ""
        hightLbl.text = ""
        weightLbl.text = ""
        pokedexLbl.text = ""
        descriptionLbl.text = ""
        pokedexLbl.text = ""
        nextEvoImg.isHidden = true
        
        
        

        //update local info
        nameLbl.text = pokemon.name
        let strID: String = "\(pokemon.pokedexId)"
        pokedexLbl.text = strID
        let img = UIImage(named: strID)
        mainImg.image = img
        currentEvoImg.image = img

        
        
        pokemon.downloadPokemonDetail {
            //After network call compleate
            self.updateUI()
        }
        
    }
    
    
    
    func updateUI(){
        

        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        hightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
        
        if pokemon.nextEvoId == "" {
            evoLbl.text = "no evolutions"
            nextEvoImg.isHidden = true
        }else{
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvoId)
            
            let str = "Next Evolution: \(pokemon.nextEvoName) - LVL \(pokemon.nextEvoLevel)"
            evoLbl.text = str
        }
        

        
        
    }
    
    

    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
