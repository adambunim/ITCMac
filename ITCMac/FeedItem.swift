
import Foundation

struct FeedItem: Identifiable, Codable {
    var id: String = ""
    var title: String = ""
    var details: String = ""
    var lat: Float? = nil
    var long: Float? = nil
}
