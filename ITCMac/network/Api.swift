
import Foundation

class Api {

    static let host = "http://localhost:3000"
    
    static func get(_ callback: @escaping (GetItemsResult) -> Void) {
        guard let url = URL(string: host) else {
            callback(GetItemsResult(errorMessage: "bad url", items: []))
            return
        }

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                callback(GetItemsResult(errorMessage: "no data", items: []))
                return
            }
            do {
                let items = try JSONDecoder().decode([FeedItem].self, from: data)
                callback(GetItemsResult(errorMessage: nil, items: items))
            }
            catch {
                callback(GetItemsResult(errorMessage: "could not parse", items: []))
                return
            }
        }
        task.resume()
    }

    static func delete(_ id: String, _ callback: @escaping (ApiResponse) -> Void) {
        guard let url = URL(string: "\(host)/\(id)") else {
            callback(ApiResponse(success: false, errorMessage: "bad url"))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error != nil {
                callback(ApiResponse(success: false, errorMessage: "got error"))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                callback(ApiResponse(success: false, errorMessage: "wrong response type"))
                return
            }
            if httpResponse.statusCode != 200 {
                callback(ApiResponse(success: false, errorMessage: "error code \(httpResponse.statusCode)"))
                return
            }
            callback(ApiResponse(success: true, errorMessage: nil))
        }
        task.resume()
    }
    
    static func edit(_ id: String, _ item: FeedItem, _ callback: @escaping (ApiResponse) -> Void) {
        guard let url = URL(string: "\(host)/\(id)") else {
            callback(ApiResponse(success: false, errorMessage: "bad url"))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(item)
            request.httpBody = data
            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                if error != nil {
                    callback(ApiResponse(success: false, errorMessage: "got error"))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    callback(ApiResponse(success: false, errorMessage: "wrong response type"))
                    return
                }
                if httpResponse.statusCode != 200 {
                    callback(ApiResponse(success: false, errorMessage: "error code \(httpResponse.statusCode)"))
                    return
                }
                callback(ApiResponse(success: true, errorMessage: nil))
            }
            task.resume()
        }
        catch {
            callback(ApiResponse(success: false, errorMessage: "failed to encode"))
        }
    }
        
}
