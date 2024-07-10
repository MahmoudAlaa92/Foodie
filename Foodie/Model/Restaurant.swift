//
//  Restaurant.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 26/06/2024.
//

import Foundation

struct Restaurant: Hashable{
    
    enum Rating: String{
        case Awesome
        case Terrible
        case Cool
        case Sad
        case Okay
        
        var image: String{
            switch self{
            case .Awesome:
                return "love"
            case .Terrible:
                return "angry"
            case .Cool:
                return "cool"
            case .Sad:
                return "sad"
            default:
                return "cool"
            }
        }
    }
    
    var name: String = ""
    var type: String = ""
    var location: String = ""
    var phone: String = ""
    var description: String = ""
    var image: String = ""
    var isFavorite: Bool = false
    var rating: Rating?
}
