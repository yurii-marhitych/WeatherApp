//
//  RandomImageManager.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

import Combine
import UIKit

class RandomImageManager {
    
    // MARK: - Error Type
    enum RandomImageError: Error {
        case badURL
        case badAPIResponse
        case fetchingImage
    }
    
    // MARK: - Properties
    private var baseURL = "https://aws.random.cat/meow"
    private var subscriptions = Set<AnyCancellable>()
    
    func fetchRandomImage() -> Future<UIImage, RandomImageError> {
        return Future { promise in
            if let url = URL(string: self.baseURL) {
                URLSession.shared
                    .dataTaskPublisher(for: url)
                    .map(\.data)
                    .decode(type: RandomImage.self, decoder: JSONDecoder())
                    .sink { completion in
                        if case .failure = completion {
                            promise(.failure(.badAPIResponse))
                        }
                    } receiveValue: { randomImage in
                        URLSession.shared
                            .dataTaskPublisher(for: randomImage.url)
                            .map(\.data)
                            .tryMap { UIImage(data: $0) }
                            .sink { completion in
                                if case .failure = completion {
                                    promise(.failure(.fetchingImage))
                                }
                            } receiveValue: { image in
                                if let image = image {
                                    promise(.success(image))
                                } else {
                                    promise(.failure(.fetchingImage))
                                }
                            }
                            .store(in: &self.subscriptions)
                    }
                    .store(in: &self.subscriptions)

            } else {
                promise(.failure(.badURL))
            }
        }
    }
}
