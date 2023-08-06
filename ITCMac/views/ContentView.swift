
import SwiftUI

struct ContentView: View {
    
    @State var loading = false
    @State var items: [FeedItem]? = nil
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Messages")
                    .font(.title)
                Spacer()
                
                Button(action: {
                    load()
                }) {
                    Image(systemName: "arrow.triangle.2.circlepath")
                }
                .buttonStyle(.plain)
                .disabled(loading)
            }
            .padding()
            
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
    }
    
    func load() {
        loading = true
        loadFromApi { response in
            loading = false
            items = response
        }
    }
}
