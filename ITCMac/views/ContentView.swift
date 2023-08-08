
import SwiftUI

struct ContentView: View {
    
    @StateObject var apiState = ApiState()
    @State var showingAlert = false
    @State var showingAddSheet = false
    @State var search = ""
    @State var filterByLocation = false
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Search", text: $search)
                .onSubmit {
                    load()
                }
            
            Toggle("Show only items near Tel Aviv", isOn: $filterByLocation)
                .onChange(of: filterByLocation) { _ in
                    load()
                }
            
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
                    ItemAddView(showingSheet: $showingAddSheet)
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
        .alert("Could not load data", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
        .environmentObject(apiState)
        .onAppear {
            load()
        }
        .padding()
    }
    
    func load() {
        showingAlert = false
        apiState.loading = true
        Api.get(search, filterByLocation ? telAviv : nil) { items in
            DispatchQueue.main.async {
                apiState.loading = false
                guard let items = items else {
                    showingAlert = true
                    return
                }
                showingAlert = false
                apiState.items = items
            }
        }
    }
}
