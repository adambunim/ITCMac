
import SwiftUI

struct ItemCell: View {
    
    let item: FeedItem
    @State private var showingSheet = false
    
    var body: some View {
        Button(action: {
            showingSheet = true
        }) {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(item.title)
                        .font(.title)
                        
                    Text(item.details)
                        .font(.body)
                    
                    HStack(spacing: 0) {
                        Spacer()
                        
                        Button(action: {
                            print("more")
                        }) {
                            Text("more")
                        }
                        .buttonStyle(.plain)
                        
                        Image(systemName: "chevron.down")
                    }
                    .foregroundColor(.accentColor)
                    
                }
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.top, 8)
            .padding(.bottom, 8)
            .background(Color.white)
            .cornerRadius(10)
            .sheet(isPresented: $showingSheet) {
                ItemView(item: item, showingSheet: $showingSheet)
            }
        }
        .buttonStyle(.plain)
    }
}

