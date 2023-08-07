
import SwiftUI

struct ItemsList: View {
    
    @EnvironmentObject var apiState: ApiState
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(apiState.items) {
                    ItemCell(item: $0)
                }
            }
            .padding()
        }
    }
}
