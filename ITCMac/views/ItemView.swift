
import SwiftUI

struct ItemView: View {
    
    let item: FeedItem
    @EnvironmentObject var apiState: ApiState
    @Binding var showingSheet: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: {
                    showingSheet = false
                }) {
                    Text("x")
                }
            }
            
            Text(item.title)
                .font(.title)
            Text(item.body)
                .font(.body)
            Spacer()
            Button(action: delete) {
                Text("Delete")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
    
    func delete() {
        Api.delete(item.id) { response in
            DispatchQueue.main.async {
                if response.success {
                    apiState.items = apiState.items.filter {
                        $0.id != item.id
                    }
                    showingSheet = false
                }
                else {
                    apiState.showingAlert = true
                    apiState.errorMessage = "failed to delete"
                }
            }
        }
    }
    
}
