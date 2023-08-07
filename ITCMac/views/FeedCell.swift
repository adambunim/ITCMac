
import SwiftUI

struct FeedCell: View {
    
    let item: FeedItem
    
    var body: some View {
        NavigationLink(destination: ItemView(item: item)) {
            HStack {
                Text(item.title)
                Spacer()
            }
            .padding([.leading, .trailing])
        }
    }
}

