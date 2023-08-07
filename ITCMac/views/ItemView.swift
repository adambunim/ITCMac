
import SwiftUI

struct ItemView: View {
    
    let item: FeedItem
    @EnvironmentObject var items: ObservableItems
    
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
            if response.success {
                DispatchQueue.main.async {
                    items.list = items.list.filter {
                        $0.id != item.id
                    }
                }
            }
            else {
                print(response.errorMessage ?? "faild")
            }
        }
    }
    
}
