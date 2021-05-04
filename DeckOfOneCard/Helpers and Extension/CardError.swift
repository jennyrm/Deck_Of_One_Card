//
//  CardError.swift
//  DeckOfOneCard
//
//  Created by Jenny Morales on 5/4/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

enum CardError: LocalizedError {
  case invalidURL
  case thrownError(Error)
  case noData
  case unableToDecode
    
  // Give the user whatever information you think they should know. Feel free to write your own descriptions.
  var errorDescription: String? {
      switch self {
      case .invalidURL:
          return "Internal error. Please update Deck of One Card or contact support."
      case .thrownError(let error):
          return error.localizedDescription
      case .noData:
          return "The server responded with no data."
      case .unableToDecode:
          return "The server responded with bad data."
      }
  }
}//End of enum

