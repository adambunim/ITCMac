
import Foundation

class Api {

    static let host = "http://localhost:3000"
    
    static func get(_ filter: String, _ callback: @escaping ([FeedItem]?) -> Void) {
        guard let url = URL(string: "\(host)/\(filter)") else {
            print("bad url")
            callback(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                print("no data")
                callback(nil)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print("wrong response type")
                callback([])
                return
            }
            if httpResponse.statusCode != 200 {
                print("error code \(httpResponse.statusCode)")
                callback(nil)
                return
            }
            do {
                let items = try JSONDecoder().decode([FeedItem].self, from: data)
                callback(items)
            }
            catch {
                print("could not parse")
                callback(nil)
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
    
    static func add(_ item: FeedItem, _ callback: @escaping (String?) -> Void) {
        guard let url = URL(string: host) else {
            print("bad url")
            callback(nil)
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
                    callback(nil)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("wrong response type")
                    callback(nil)
                    return
                }
                if httpResponse.statusCode != 200 {
                    print("error code \(httpResponse.statusCode)")
                    callback(nil)
                    return
                }
                guard let data = data else {
                    print("no data")
                    callback(nil)
                    return
                }
                let id = String(decoding: data, as: UTF8.self)
                callback(id)
            }
            task.resume()
        }
        catch {
            print("failed to encode")
            callback(nil)
        }
    }
        
}
