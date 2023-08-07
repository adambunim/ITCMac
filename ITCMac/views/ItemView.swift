
import SwiftUI

struct ItemView: View {
    
    let item: FeedItem
    @EnvironmentObject var apiState: ApiState
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.body)
            Spacer()
            HStack {
                Spacer()
                
                Button(action: delete) {
                    Image(systemName: "trash")
                }
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
                    dismiss()
                }
                else {
                    apiState.showingAlert = true
                    apiState.errorMessage = "failed to delete"
                }
            }
        }
    }
    
}
