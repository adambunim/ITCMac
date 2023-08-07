
import SwiftUI

struct ItemAddView: View {
    
    @Binding var showingSheet: Bool
    @EnvironmentObject var apiState: ApiState
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
            .disabled(title.isEmpty || details.isEmpty)
            
        }
        .padding()
    }
    
    func save() {
        //TODO ID
        let item = FeedItem(id: "0", title: title, details: details)
        Api.add(item) { success in
            DispatchQueue.main.async {
                if success {
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
