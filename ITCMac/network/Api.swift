
import Foundation

class Api {

    static func loadFromApi(_ callback: @escaping (GetItemsResult) -> Void) {
        guard let url = URL(string: "http://localhost:3000") else {
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

}
