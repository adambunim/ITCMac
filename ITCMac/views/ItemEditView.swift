
import SwiftUI

struct ItemEditView: View {
    
    let item: FeedItem
    @EnvironmentObject var apiState: ApiState
    @Binding var showingEditSheet: Bool
    @State var title = ""
    @State var itemBody = ""
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: {
                    showingEditSheet = false
                }) {
                    Text("x")
                }
            }
            
            TextField("Title", text: $title)
            TextField("Body", text: $itemBody)
            
            Spacer()
            
            Button(action: save) {
                Text("Save")
            }
        }
        .padding()
        .onAppear {
            title = item.title
            itemBody = item.body
        }
    }
    
    func save() {
        let item = FeedItem(id: item.id, title: title, body: itemBody)
        Api.edit(item.id, item) { response in
            DispatchQueue.main.async {
                if response.success {
//                    apiState.items = apiState.items.filter {
//                        $0.id != item.id
//                    }
                    //TODO
                    showingEditSheet = false
                }
                else {
                    apiState.showingAlert = true
                    apiState.errorMessage = "failed to delete"
                }
            }
        }
    }
    
}
