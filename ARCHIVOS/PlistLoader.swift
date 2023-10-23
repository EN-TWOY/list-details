//
//  PlistLoader.swift
//  Color Contacts
//
//  Created by Aldo Olivares Dominguez on 10/27/17.
//  Copyright © 2017 Aldominium. All rights reserved.
//

import UIKit

enum PlistError: Error {
    case invalidResource
    case parsingFailure
}

class PlistLoader {
    static func array(fromFile name: String, ofType type: String) throws -> [[String: String]] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw PlistError.invalidResource
        }
        
        guard let array = NSArray(contentsOfFile: path) as? [[String: String]] else {
            throw PlistError.parsingFailure
        }
        
        return array
    }
}

class ContactsSource {
    static var contacts: [Contact] {
        let data = try! PlistLoader.array(fromFile: "Contacts", ofType: "plist")
        return data.compactMap { Contact(dictionary: $0) }
    }
    
}
