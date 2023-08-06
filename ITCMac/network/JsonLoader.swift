
import Foundation

func loadJsonFromFile() -> [FeedItem] {
    guard let filepath = Bundle.main.path(forResource: "items", ofType: "json") else {
        return []
    }
    do {
        let json = try String(contentsOfFile: filepath)
        let data = Data(json.utf8)
        return try JSONDecoder().decode([FeedItem].self, from: data)
    } catch {
        return []
    }
}

func loadDummyJson() -> [FeedItem] {
    return [
        FeedItem(id: "1", title: "milk", body: "milk"),
                 FeedItem(id: "2", title: "cookies", body: "cookies")
    ]
}

func loadFromApi(_ callback: @escaping (GetItemsResult) -> Void) {
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
