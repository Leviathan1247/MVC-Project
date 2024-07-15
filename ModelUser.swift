//
//  ModelUser.swift
//  WelcomePatternMVC
//
//  Created by Левиафан on 2024-06-15.
//

import Foundation

struct ModelUser {
    let firstName, lastName, email: String
    let age: Int
    let location: Location
}

struct Location {
    let city: String
    let address: String
}
