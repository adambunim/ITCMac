
import SwiftUI

struct ItemCell: View {
    
    let item: FeedItem
    @State private var showingSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(item.title)
                .font(.title)
               
            if showingSheet {
                Text(item.details)
                    .font(.body)
            }
            
            HStack(spacing: 0) {
                Spacer()
                
                if showingSheet {
                    Button(action: {
                        showingSheet = false
                    }) {
                        Text("less")
                    }
                    .buttonStyle(.plain)
                    
                    Image(systemName: "chevron.up")
                }
                else {
                    Button(action: {
                        showingSheet = true
                    }) {
                        Text("more")
                    }
                    .buttonStyle(.plain)
                    
                    Image(systemName: "chevron.down")
                }
            }
            .foregroundColor(.accentColor)
            
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .padding(.top, 8)
        .padding(.bottom, 8)
        .background(Color.white)
        .cornerRadius(10)
//        .sheet(isPresented: $showingSheet) {
//            ItemView(item: item, showingSheet: $showingSheet)
//        }
//        .buttonStyle(.plain)
    }
}

