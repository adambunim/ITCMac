
import SwiftUI

struct ItemEditView: View {
    
    let item: FeedItem
    @EnvironmentObject var apiState: ApiState
    @Binding var showingSheet: Bool
    @State var title = ""
    @State var details = ""
    @State var error = false
    
    var body: some View {
        VStack {
            HStack {
                if error {
                    Image(systemName: "exclamationmark")
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                Button(action: {
                    showingSheet = false
                }) {
                    Text("x")
                }
            }
            
            TextField("Title", text: $title)
            TextField("Details", text: $details)
            
            Spacer()
            
            Button(action: save) {
                Text("Save")
            }
            .disabled(title == item.title && details == item.details)
            
        }
        .padding()
        .onAppear {
            title = item.title
            details = item.details
        }
    }
    
    func save() {
        let item = FeedItem(id: item.id, title: title, details: details)
        Api.edit(item.id, item) { success in
            DispatchQueue.main.async {
                if success {
                    apiState.items = apiState.items.filter {
                        $0.id != item.id
                    }
                    apiState.items.append(item)
                    showingSheet = false
                }
                else {
                    error = true
                }
            }
        }
    }
    
}
