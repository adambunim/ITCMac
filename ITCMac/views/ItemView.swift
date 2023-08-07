
import SwiftUI

struct ItemView: View {
    
    let item: FeedItem
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.body)
        }
    }
}
