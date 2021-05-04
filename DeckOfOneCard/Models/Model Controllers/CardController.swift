//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Jenny Morales on 5/4/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class CardController {
    //MARK: - Properties
    static private let baseURL = URL(string: "https:deckofcardsapi.com/api/deck")
    static private let newDeckEndPoint = "new"
    static private let drawEndPoint = "draw"
    
    //MARK: - Functions
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
      // 1 - Prepare URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let deckURL = baseURL.appendingPathComponent(newDeckEndPoint).appendingPathComponent(drawEndPoint) //https://deckofcardsapi.com/api/deck/new/draw
        var components = URLComponents(url: deckURL, resolvingAgainstBaseURL: true)
        let countQuery = URLQueryItem(name: "count", value: "1")
        components?.queryItems = [countQuery]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL)) }
        print(finalURL) //https://deckofcardsapi.com/api/deck/new/draw/?count=1
        
      // 2 - Contact server
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            // 3 - Handle errors from the server
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("CARD STATUS CODE: \(response.statusCode)")
            }
            // 4 - Check for json data
            guard let data = data else { return completion(.failure(.noData)) }
            // 5 - Decode json into a Card
            do {
                let topLevelObject = try JSONDecoder().decode(TopLeveObject.self, from: data)
                guard let card = topLevelObject.cards.first else { return completion(.failure(.noData)) }
                completion(.success(card))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result <UIImage, CardError>) -> Void) {
      // 1 - Prepare URL
        guard let imageURL = card.image else { return completion(.failure(.invalidURL)) }
      // 2 - Contact server
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            // 3 - Handle errors from the server
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("CARD IMAGE STATUS CODE: \(response.statusCode)")
            }
            // 4 - Check for image data
            guard let imageData = data else { return completion(.failure(.noData)) }
            // 5 - Initialize an image from the data
            guard let cardImage = UIImage(data: imageData) else { return completion(.failure(.unableToDecode)) }
            completion(.success(cardImage))
        }.resume()
    }
}//End of class
