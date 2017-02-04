//
//  Pokemon.swift
//  pokedex
//
//  Created by oubaida alquraan on 2/2/17.
//  Copyright © 2017 oubaida alquraan. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name:String!
    private var _pokedexId:Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _pokemonURL: String!
    private var _nextEvoName: String!
    private var _nextEvoId: String!
    private var _nextEvoLevel: String!
    
    
    
    
    
    var nextEvoLevel: String {
        if _nextEvoLevel == nil { _nextEvoLevel = "" }
        return _nextEvoLevel
    }
    
    
    var nextEvoId: String {
        if _nextEvoId == nil { _nextEvoId = "" }
        return _nextEvoId
    }
    
    var nextEvoName: String {
        if _nextEvoName == nil { _nextEvoName = "" }
        return _nextEvoName
    }
    
   
    var description: String {
        if _description == nil { _description = "" }
        return _description
    }
    
    
    var type: String {
        if _type == nil { _type = "" }
        return _type
    }
    
    
    var defense: String {
        if _defense == nil { _defense = "" }
        return _defense
    }
    
    
    var height: String {
        if _height == nil { _height = "" }
        return _height
    }
    
    
    var weight: String {
        if _weight == nil { _weight = "" }
        return _weight
    }
    
    var attack: String {
        if _attack == nil { _attack = "" }
        return _attack
    }
    
    
    var nextEvolutionText: String {
        if _nextEvolutionTxt == nil { _nextEvolutionTxt = "" }
        return _nextEvolutionTxt
    }
    
    
    var name:String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    
    
    init (name: String , pokedexId: Int){
        self._name = name.capitalized
        self._pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    
    
    func downloadPokemonDetail(completed: @escaping DownloadCompleate){
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            print("Request Done : \(response.result.value)")
            
            
            if let dict = response.result.value as? Dictionary <String , Any> {
                
                //get weight
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                
                //get hight
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                
                //get attack
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                
                //get defense
                if let defence = dict["defense"] as? Int {
                    self._defense = "\(defence)"
                }
                
                //just test
                print (self._attack , self._defense , self._height , self._weight)
                
                
                
                //get type
                if let types = dict["types"] as? [Dictionary<String,String>] , types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let newName = types[x]["name"] {
                            self._type! += "/\(newName.capitalized)"
                            }
                        }
                    }
                    
                    
                } else {
                    self._type = ""
                }
                
                
                
                //get description
                if let descArr = dict["descriptions"] as? [Dictionary<String,String>] , descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {
                        
                        let descURL = "\(URL_BASE)\(url)"
                        
                        Alamofire.request(descURL).responseJSON { (response) in
                            if let descDict = response.result.value as? Dictionary <String, Any> {
                                if let description = descDict["description"] as? String {
                                    
                                    let newDesc = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    
                                    
                                    
                                    print(newDesc)
                                    self._description = newDesc
                                    print("self._description : " , newDesc)
                                }
                            }
                            
                            completed()
                        }
                        
                        
                    }
                } else {
                    self._description = "There is no descriptions !"
                }
                
                
                
                
                //get evolutions
                if let evolusions = dict["evolutions"] as? [Dictionary<String,Any>] , evolusions.count > 0 {
                    if let nextEvo = evolusions[0]["to"] as? String {
                        if nextEvo.range(of: "mega") == nil {
                            self._nextEvoName = nextEvo
                            
                            
                            if let uri = evolusions[0]["resource_uri"] as? String {
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                self._nextEvoId = nextEvoId
                                
                                
                                if let lvlExist = evolusions[0]["level"] {
                                    if let level = lvlExist as? Int {
                                        self._nextEvoLevel = "\(level)"
                                    }
                                }else{
                                    self._nextEvoLevel = ""
                                }
                            }
                        }
                    }
                    
                    print(self.nextEvoId , self.nextEvoName , self.nextEvoLevel)
                }
                
                
                
                
            }
            
            
        }
    }
    
    
    
    
}
