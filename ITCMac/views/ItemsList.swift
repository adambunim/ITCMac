
import SwiftUI

struct ItemsList: View {
    
    @EnvironmentObject var apiState: ApiState
    
    var body: some View {
        List(apiState.items) {
            ItemCell(item: $0)
        }
    }
}
