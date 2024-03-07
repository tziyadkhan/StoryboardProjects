//
//  User.swift
//  BankApp
//
//  Created by Ziyadkhan on 16.10.23.
//

import Foundation

struct User: Codable {
    var fullname: String?
    var email: String?
    var birthdate: String?
    var phonenumber: String?
    var password: String?
    var cardList: [Card]?
}

struct Card: Codable {
    var cardName: String?
    var cardNumber: String?
    var cardDate: String?
    var cardCVC2: String?
    var cardBalance: Double?
}

extension User {
    mutating func addCard(_ card: Card) {
        if cardList == nil {
            cardList = [card]
        } else {
            cardList?.append(card)
        }
    }
}
