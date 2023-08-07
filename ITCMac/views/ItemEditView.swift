
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
        }
        .padding()
        .onAppear {
            title = item.title
            itemBody = item.body
        }
    }
}
