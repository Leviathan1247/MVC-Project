//
//  Network.swift
//  WelcomePatternMVC
//
//  Created by Левиафан on 2024-06-15.
//

import Foundation


class Network {
    static let shared = Network()
    private init() {}
    
    private var user: ModelUser?
    
    func login(email: String, password: String, completion: @escaping(Bool) -> Void) {
        
        DispatchQueue.global().async {
            sleep(2)
        DispatchQueue.main.async {
            if email == "SteveJobs@apple.com" && password == "password" {
                self.user = ModelUser(firstName: "Steve", lastName: "Jobs", email: "SteveJobs@apple.com", age: 40, location: Location(city: "Cupertino, One Apple Park Way", address: "CA 95014"))
                 completion(true)
                } else {completion(false)
                    self.user = nil
                }
            }
        }
    }
    
    func getLoggedInUser() -> ModelUser? {
        return user
        
    }
    
}
