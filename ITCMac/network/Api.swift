
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

    static func delete(_ id: String, _ callback: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(host)/\(id)") else {
            print("bad url")
            callback(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error != nil {
                print("got error")
                callback(false)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print("wrong response type")
                callback(false)
                return
            }
            if httpResponse.statusCode != 200 {
                print("error code \(httpResponse.statusCode)")
                callback(false)
                return
            }
            callback(true)
        }
        task.resume()
    }
    
    static func edit(_ id: String, _ item: FeedItem, _ callback: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(host)/\(id)") else {
            print("bad url")
            callback(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(item)
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                if error != nil {
                    print("got error")
                    callback(false)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("wrong response type")
                    callback(false)
                    return
                }
                if httpResponse.statusCode != 200 {
                    print("error code \(httpResponse.statusCode)")
                    callback(false)
                    return
                }
                callback(true)
            }
            task.resume()
        }
        catch {
            print("failed to encode")
            callback(false)
        }
    }
    
    static func add(_ item: FeedItem, _ callback: @escaping (Bool) -> Void) {
        guard let url = URL(string: host) else {
            print("bad url")
            callback(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(item)
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                if error != nil {
                    print("got error")
                    callback(false)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("wrong response type")
                    callback(false)
                    return
                }
                if httpResponse.statusCode != 200 {
                    print("error code \(httpResponse.statusCode)")
                    callback(false)
                    return
                }
                callback(true)
            }
            task.resume()
        }
        catch {
            print("failed to encode")
            callback(false)
        }
    }
        
}
