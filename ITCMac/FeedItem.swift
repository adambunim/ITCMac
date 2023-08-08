
import Foundation

struct FeedItem: Identifiable, Codable {
    var id: String = ""
    var title: String = ""
    var details: String = ""
    var lat: Double? = nil
    var long: Double? = nil
}
