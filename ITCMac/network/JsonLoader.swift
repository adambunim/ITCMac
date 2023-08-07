
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
        FeedItem(id: "1", title: "milk", details: "milk"),
                 FeedItem(id: "2", title: "cookies", details: "cookies")
    ]
}
