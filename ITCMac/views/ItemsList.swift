
import SwiftUI

struct ItemsList: View {
    
    @EnvironmentObject var apiState: ApiState
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(apiState.items) {
                    ItemCell(item: $0)
                }
            }
        }
    }
}
