
import SwiftUI

struct ContentView: View {
    
    let items: [FeedItem] = [
        FeedItem(id: "1", title: "milk"),
        FeedItem(id: "2", title: "cookies")
    ]
    
    var body: some View {
        List(items) {
            FeedCell(item: $0)
        }
    }
}
