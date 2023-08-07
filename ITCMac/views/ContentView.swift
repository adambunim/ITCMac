
import SwiftUI

struct ContentView: View {
    
    @State var loading = false
    @State var errorMessage: String? = nil
    @StateObject var items = ObservableItems()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ItemsList()
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
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
            DispatchQueue.main.async {
                loading = false
                self.errorMessage = response.errorMessage
                items.list = response.items
            }
        }
    }
}
