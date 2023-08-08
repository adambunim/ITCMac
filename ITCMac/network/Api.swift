
import MapKit

class Api {

    static let host = "http://localhost:3000"
    
    static func get(_ filter: String, _ location: CLLocationCoordinate2D?, _ callback: @escaping ([FeedItem]?) -> Void) {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.path = "/"
        components.port = 3000
        components.queryItems = []
        if !filter.isEmpty {
            components.queryItems?.append(URLQueryItem(name: "filter", value: filter))
        }
        if let location = location {
            components.queryItems?.append(URLQueryItem(name: "lat", value: "\(location.latitude)"))
            components.queryItems?.append(URLQueryItem(name: "long", value: "\(location.longitude)"))
        }
        guard let url = components.url else {
            print("bad url")
            callback(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if !isOk(response, error) {
                callback(nil)
                return
            }
            guard let data = data else {
                print("no data")
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
            if !isOk(response, error) {
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
                if !isOk(response, error) {
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
                if !isOk(response, error) {
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
    
    static func isOk(_ response: URLResponse?, _ error: Error?) -> Bool {
        if error != nil {
            print("got error")
            return false
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            print("wrong response type")
            return false
        }
        if httpResponse.statusCode != 200 {
            print("error code \(httpResponse.statusCode)")
            return false
        }
        return true
    }
    
}
