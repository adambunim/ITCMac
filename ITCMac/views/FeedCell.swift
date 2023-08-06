
import SwiftUI

struct FeedCell: View {
    
    let item: FeedItem
    
    var body: some View {
        HStack {
            Text(item.title)
        }
        .padding([.leading, .trailing])
    }
}

