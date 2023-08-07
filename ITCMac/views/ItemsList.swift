
import SwiftUI

struct ItemsList: View {
    
    @EnvironmentObject var items: ObservableItems
    
    var body: some View {
        List(items.list) {
            ItemCell(item: $0)
        }
    }
}
