
import SwiftUI

struct ContentView: View {
    
    @State var items: [FeedItem]? = nil
    
    var body: some View {
        if let items = items {
            ItemsList(items: items)
        }
        else {
            ProgressView()
                .onAppear {
                    load()
                }
        }
    }
    
    func load() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            items = [
                FeedItem(id: "1", title: "milk", body: "milk"),
                         FeedItem(id: "2", title: "cookies", body: "cookies")
            ]
        }
    }
}
