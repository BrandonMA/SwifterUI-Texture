//
//  GlobalVariables.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 23/07/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit

typealias LocalizedDictionary = [String : String]

struct LocalizedString {
    
    // MARK: - Static Methods
    
    static let shared = LocalizedString()
    
    // MARK: - Instance Properties
    
    // availableLanguages: Global Dictionary that keeps track of the available languages inside the library
    let availableLanguages = ["en", "es"]
    
    // MARK: - Instance Methods
    
    // getBestMatchedLanguage: Return the best match for the languages availables
    func getBestMatchedLanguage() -> String {
        return Bundle.preferredLocalizations(from: availableLanguages).first ?? "en"
    }
    
    // getSearch: Return search in the correct language
    func getSearch() -> String {
        let search: LocalizedDictionary = ["en" : "Search", "es" : "Buscar"]
        return search[getBestMatchedLanguage()] ?? "Search"
    }
    
    // getCancel: Return cancel in the correct language
    func getCancel() -> String {
        let cancel: LocalizedDictionary = ["en" : "Cancel", "es" : "Cancelar"]
        return cancel[getBestMatchedLanguage()] ?? "Cancel"
    }
    
    func getSave() -> String {
        let done: LocalizedDictionary = ["en" : "Save", "es" : "Guardar"]
        return done[getBestMatchedLanguage()] ?? "Done"
    }
    
}


















