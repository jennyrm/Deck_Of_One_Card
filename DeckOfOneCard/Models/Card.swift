//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Jenny Morales on 5/4/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

struct TopLeveObject: Decodable {
    var cards: [Card]
}

struct Card: Decodable {
    var value: String
    var suit: String
    var image: URL?
}//End of struct
