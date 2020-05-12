//
//  APIClient.swift
//  MVVM-UI
//
//  Created by Kashif Jilani.

import UIKit

enum APIError: Error {
  case internalError
  case serverError
  case parsingError
}

protocol NetworkServiceProvider {
  func retrieveList(completion: @escaping((Result<[NSDictionary], APIError>) -> Void))
}

//1 - This APIClient will be called by the viewModel to get our top 100 app data.

class APIClient: NetworkServiceProvider {
  
  private let postbaseURL = "http://dummy.restapiexample.com/api/v1/employees"
  
  func retrieveList(completion: @escaping ((Result<[NSDictionary], APIError>) -> Void)) {
    self.request(baseURL: postbaseURL, completion: completion)
  }
  
  private func request<T>(baseURL: String, completion: @escaping((Result<[T], APIError>) -> Void)) {
    
    guard let url = URL(string: baseURL) else {
      return
    }
    let session = URLSession.shared
    let dataTask = session.dataTask(with: url) { (data, response, error) in
      guard error == nil else {
        completion(.failure(.serverError))
        return
      }
      guard let unwrappedData = data else {
        completion(.failure(.serverError));
        return
      }
      do {
        if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary {
          if let apps = responseJSON.value(forKeyPath: "data") as? [T] {
            completion(Result.success(apps))
          }
        }
      } catch {
        completion(Result.failure(.parsingError))
      }
    }
    dataTask.resume()
  }
  
}
