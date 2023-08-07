
import SwiftUI

struct ContentView: View {
    
    @StateObject var apiState = ApiState()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ItemsList()
                    
                    if let errorMessage = apiState.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    if apiState.loading {
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
                    .disabled(apiState.loading)
                }
                .padding()
                
            }
        }
        .alert("Important message", isPresented: $apiState.showingAlert) {
            Button("OK", role: .cancel) { }
        }
        .environmentObject(apiState)
        .onAppear {
            load()
        }
    }
    
    func load() {
        apiState.showingAlert = false
        apiState.loading = true
        Api.get { response in
            DispatchQueue.main.async {
                apiState.loading = false
                apiState.errorMessage = response.errorMessage
                apiState.items = response.items
            }
        }
    }
}
