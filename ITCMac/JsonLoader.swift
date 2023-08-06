
import Foundation

func loadJson() -> [FeedItem] {
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
