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
    
    // getStart: Return start in the correct language
    func getStart() -> String {
        let start: LocalizedDictionary = ["en" : "Start", "es" : "Empezar"]
        return start[getBestMatchedLanguage()] ?? "Start"
    }
    
    // getUsername: Return username in the correct language
    func getUsername() -> String {
        let email: LocalizedDictionary = ["en" : "Username", "es" : "Nombre de usuario"]
        return email[getBestMatchedLanguage()] ?? "Username"
    }
    
    // getEmail: Return email in the correct language
    func getEmail() -> String {
        let email: LocalizedDictionary = ["en" : "Email", "es" : "Correo Electronico"]
        return email[getBestMatchedLanguage()] ?? "Email"
    }
    
    // getEmail: Return email in the correct language
    func getPassword() -> String {
        let password: LocalizedDictionary = ["en" : "Password", "es" : "Contraseña"]
        return password[getBestMatchedLanguage()] ?? "Password"
    }
    
    func getSignIn() -> String {
        let text: LocalizedDictionary = ["en" : "Sign In", "es" : "Iniciar Sesión"]
        return text[getBestMatchedLanguage()] ?? "Sign In"
    }
    
    // getNewAccount: Return the text at the left side of the signUpButton in SFLoginNode
    func getNewAccount() -> String {
        let text: LocalizedDictionary = ["en" : "Don't have an account?", "es" : "¿No tienes cuenta?"]
        return text[getBestMatchedLanguage()] ?? "Don't have an account?"
    }
    
    func getSignUp() -> String {
        let text: LocalizedDictionary = ["en" : "Sign Up", "es" : "Crear Cuenta"]
        return text[getBestMatchedLanguage()] ?? "Sign Up"
    }
}


















