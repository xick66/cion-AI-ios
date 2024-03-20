//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
//  OpenAIManager.swift
//  cion
//
//  Created by Rahul K M on 28/02/24.
//

import Foundation
import OpenAI
import SwiftUI
import UIKit

class OpenAIManager {
    static let shared = OpenAIManager()
    private init() {}

    func analyzeImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        let apiKey = ""  // Replace with your actual API key
        let base64Image = UIImageToBase64.convert(image: image)

        let headers: [String: String] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]

        let payload: [String: Any] = [
            "model": "gpt-4-vision-preview",  
            "messages": [
                [
                    "role": "user",
                    "content": [
                        [
                            "type": "text",
                            "text": "Detect what food is in the image and give me the nutritional value for the food i.e give it to me exactly in this format only calories: X, protein: Y, fat: Z, carbs: P and  fibre: Q, considering the amount by approximating from image, keep the response very short and to the point,don't say anything except that. answer only if its food or drinks or any eatable otherwise respond in a funny way that you couldn't find any eatable in the image."
                        ],
                        [
                            "type": "image_url",
                            "image_url": [
                                "url": "data:image/jpeg;base64,\(base64Image)"
                            ]
                        ]
                    ]
                ]
            ],
            "max_tokens": 2000
        ]

        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response: Could not cast to HTTPURLResponse")
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response: Could not cast to HTTPURLResponse"])))
                return
            }

            if !(200...299).contains(httpResponse.statusCode) {
                let responseBody = String(data: data!, encoding: .utf8) ?? "No response body"
                print("Response status code: \(httpResponse.statusCode), Body: \(responseBody)")
                let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Received non-200 response: \(httpResponse.statusCode), body: \(responseBody)"])
                completion(.failure(error))
                return
            }

            guard let mimeType = httpResponse.mimeType, mimeType == "application/json",
                  let data = data else {
                print("Invalid response")
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                return
            }

            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let choices = jsonResponse["choices"] as? [[String: Any]],
                   let firstChoice = choices.first,
                   let message = firstChoice["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    completion(.success(content))
                } else {
                    print("Invalid JSON structure")
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON structure"])))
                }
            } catch {
                print("JSON parsing error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }

        task.resume()
    }



    func analyzeText(text: String, completion: @escaping (Result<String, Error>) -> Void) {
        let apiKey = ""

        let headers: [String: String] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]

        let payload: [String: Any] = [
            "model": "gpt-4-0125-preview",
            "messages": [
                ["role": "user", "content": text]
            ],
            "max_tokens": 150,
            "temperature": 0.7
        ]

        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response: Could not cast to HTTPURLResponse")
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response: Could not cast to HTTPURLResponse"])))
                return
            }

            print("Response status code: \(httpResponse.statusCode)")

            guard let data = data else {
                print("Invalid response: Data is nil")
                completion(.failure(NSError(domain: "dataNilError", code: -10001, userInfo: nil)))
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let choices = json["choices"] as? [[String: Any]],
                       let text = choices.first?["message"] as? [String: Any],
                       let content = text["content"] as? String {
                        completion(.success(content.trimmingCharacters(in: .whitespacesAndNewlines)))
                    } else {
                        print("Invalid JSON structure")
                        completion(.failure(NSError(domain: "invalidResponseError", code: -10002, userInfo: nil)))
                    }
                } else {
                    print("Invalid JSON")
                    completion(.failure(NSError(domain: "invalidJSONError", code: -10003, userInfo: nil)))
                }
            } catch {
                print("JSON parsing error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}
