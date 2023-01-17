//
//  Enums.swift
//  HeaderFooterViewPractice
//
//  Created by Abhishek Goel on 11/01/23.
//

import Foundation
import UIKit

var options: [Int: String] = [:]
enum FooterTitle {
    case about
    case product
    case connect
    case none
    
    func checkTitle(tag: Int) -> String {
        switch self {
        case .about:
            options = [0: "About Us", 1: "Advertise With Us", 2: "Write For Us", 3: "Contact Us"]
            return fetchOptions(options: options, tag: tag)
        case .product:
            options = [0: "Teams", 1: "Advertising", 2: "Collectives", 3: "Talent"]
            return fetchOptions(options: options, tag: tag)
        case .connect:
            options = [0: "Linkedin", 1: "Facebook", 2: "Twitter", 3: "Instagram", 4: "Gmail"]
            return fetchOptions(options: options, tag: tag)
        default:
            return ""
        }
    }
    
    func getImage(tag: Int) -> String {
        switch self {
        case .connect:
            options = [0: "linkedin", 1: "facebook", 2: "twitter", 3: "instagram", 4: "gmail"]
            return fetchOptions(options: options, tag: tag)
        default :
            return ""
        }
    }
    
    func fetchOptions(options: [Int: String], tag: Int) -> String {
        return options[tag] ?? ""
    }
}

enum SocialConnectType {
    case linkedin
    case facebook
    case twitter
    case instagram
    case gmail
    case none
    
    func createLink() {
        guard let url = URL(string: self.openUrl()) else { return }
        UIApplication.shared.open(url)
    }
    
    func openUrl() -> String {
        switch self {
        case .instagram:
            return "https://www.instagram.com/architg883/?next=%2F"
        case .facebook:
            return "https://www.facebook.com/profile.php?id=100083798146770"
        case .linkedin:
            return "https://www.linkedin.com/in/abhishekgoel-19-march"
        case .gmail:
            return "https://www.gmail.com"
        case .twitter:
            return "https://twitter.com/Abhishe28004154"
        default:
            return ""
        }
    }
}
