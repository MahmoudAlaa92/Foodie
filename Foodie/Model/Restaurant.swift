//
//  Restaurant.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 26/06/2024.
//

import UIKit
import SwiftData


@Model class Restaurant {
    enum Rating: String {
        case Awesome
        case Cool
        case Sad
        case Terrible
        case Okay
        
        var image: String {
            switch self {
            case .Awesome:
                return "love"
            case .Terrible:
                return "angry"
            case .Cool:
                return "cool"
            case .Sad:
                return "sad"
            case .Okay:
                return "happy"
            }
        }
    }
    
    var name: String = ""
    var type: String = ""
    var location: String = ""
    var phone: String = ""
    var summary: String = ""
    
    @Attribute(.externalStorage) var imageData = Data()
    
    @Transient var image: UIImage {
        get {
            UIImage(data: imageData) ?? UIImage()
        }
        set {
            self.imageData = newValue.pngData() ?? Data()
        }
    }
    
    var isFavorite: Bool = false
    
    @Transient var rating: Rating? {
        get {
            guard let ratingText = ratingText else {
                return nil
            }
            return Rating(rawValue: ratingText)
        }
        set {
            self.ratingText = newValue?.rawValue
        }
    }
    
    @Attribute(originalName: "rating") var ratingText: Rating.RawValue?
    
    init(name: String = "", type: String = "", location: String = "", phon
         e: String = "", description: String = "", image: UIImage = UIImage(), isFa
         vorite: Bool = false, rating: Rating? = nil) {
        self.name = name
        self.type = type
        self.location = location
        self.phone = phone
        self.summary = description
        self.image = image
        self.isFavorite = isFavorite
        self.rating = rating
    }
}
