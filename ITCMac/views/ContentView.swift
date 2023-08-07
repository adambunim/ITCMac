
import SwiftUI

struct ContentView: View {
    
    @State var loading = false
    @State var response: GetItemsResult? = nil
    @StateObject var items = ObservableItems()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    if let response = response {
                        if let errorMessage = response.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                        }
                        else {
                            ItemsList()
                        }
                    }
                    else {
                        Spacer()
                    }
                    
                    if loading {
                        ProgressView()
                    }
                }
        
                Spacer()
                
                HStack {
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
                
            }
        }
        .environmentObject(items)
        .onAppear {
            load()
        }
    }
    
    func load() {
        loading = true
        Api.get { response in
            loading = false
            self.response = response
            items.list = response.items
        }
    }
}
