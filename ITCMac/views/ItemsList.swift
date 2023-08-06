
import SwiftUI

struct ItemsList: View {
    
    let items: [FeedItem]
    
    var body: some View {
        List(items) {
            FeedCell(item: $0)
        }
    }
}
