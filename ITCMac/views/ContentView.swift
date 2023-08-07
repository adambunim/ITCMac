
import SwiftUI

struct ContentView: View {
    
    @StateObject var apiState = ApiState()
    @State var showingAlert = false
    @State var errorMessage: String = ""
    @State var showingAddSheet = false
    
    var body: some View {
        VStack {
            ZStack {
                ItemsList()
                
                if apiState.loading {
                    ProgressView()
                }
            }
    
            Spacer()
            
            HStack {
                Button(action: {
                    showingAddSheet = true
                }) {
                    Text("+")
                }
                .buttonStyle(.plain)
                .sheet(isPresented: $showingAddSheet) {
                    ItemAddView(showingAddSheet: $showingAddSheet)
                }
                
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
        .alert(errorMessage, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
        .environmentObject(apiState)
        .onAppear {
            load()
        }
    }
    
    func load() {
        showingAlert = false
        apiState.loading = true
        Api.get { response in
            DispatchQueue.main.async {
                apiState.loading = false
                if let error = response.errorMessage {
                    showingAlert = true
                    errorMessage = error
                }
                else {
                    showingAlert = false
                    errorMessage = ""
                }
                apiState.items = response.items
            }
        }
    }
}
