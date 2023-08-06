
import SwiftUI

struct ContentView: View {
    
    @State var loading = false
    @State var response: GetItemsResult? = nil
    
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
            
            if let response = response {
                if let errorMessage = response.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                else {
                    ItemsList(items: response.items)
                }
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
            self.response = response
        }
    }
}
