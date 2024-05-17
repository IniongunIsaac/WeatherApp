//
//  Codable+.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation

extension Encodable {
    var jsonString: String {
        do {
            return String(data: try JSONEncoder().encode(self), encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
    
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
    
    var prettyJson: String {
        if let responseData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) {
            return String(data: responseData, encoding: .utf8) ?? ""
        }
        return ""
    }
    
    var dictionaryValue: Any {
        do {
            let data = try JSONEncoder().encode(self)
            //return String(data: data , encoding: .utf8) ?? ""
            return try JSONSerialization.jsonObject(with: data)
        } catch {
            return ""
        }
    }
    
    var dictionaryArray: [[String: Any]] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [[String: Any]] ?? [[:]]
    }
    
    func encodedData() -> Data? {
        try? JSONEncoder().encode(self)
    }
    
}

public extension Decodable {
    ///Maps JSON String to actual Decodable Object
    ///throws an exception if mapping fails
    static func mapFrom(jsonString: String) throws -> Self? {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: Data(jsonString.utf8))
    }
}
