
import SwiftUI

struct ItemCell: View {
    
    let item: FeedItem
    @State private var showingSheet = false
    
    var body: some View {
        Button(action: {
            showingSheet = true
        }) {
            HStack {
                Text(item.title)
                Spacer()
            }
            .padding([.leading, .trailing])
            .sheet(isPresented: $showingSheet) {
                ItemView(item: item, showingSheet: $showingSheet)
            }
        }
    }
}

