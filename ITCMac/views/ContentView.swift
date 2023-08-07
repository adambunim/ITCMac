
import SwiftUI

struct ContentView: View {
    
    @StateObject var apiState = ApiState()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ItemsList()
                    
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
        .alert(apiState.errorMessage, isPresented: $apiState.showingAlert) {
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
                if let error = response.errorMessage {
                    apiState.showingAlert = true
                    apiState.errorMessage = error
                }
                else {
                    apiState.showingAlert = false
                    apiState.errorMessage = ""
                }
                apiState.items = response.items
            }
        }
    }
}
