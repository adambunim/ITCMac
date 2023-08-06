
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

func loadFromApi(_ callback: @escaping ([FeedItem]) -> Void) {
    guard let url = URL(string: "http://localhost:3000") else {
        callback([])
        return
    }

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else {
            callback([])
            return
        }
        print(String(data: data, encoding: .utf8)!)
    }
    task.resume()
}
