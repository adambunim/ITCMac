
import SwiftUI

struct ItemCell: View {
    
    let item: FeedItem
    @State private var showingMore = false
    @State var showingEditSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(item.title)
                .font(.title)
               
            if showingMore {
                Text(item.details)
                    .font(.body)
            }
            
            HStack {
                if showingMore {
                    Button(action: {
                        showingEditSheet = true
                    }) {
                        Image(systemName: "pencil")
                            .sheet(isPresented: $showingEditSheet) {
                                ItemEditView(item: item, showingSheet: $showingEditSheet)
                            }
                    }
                    .buttonStyle(.plain)
                }
                
                Spacer()
                
                Button(action: {
                    showingMore.toggle()
                }) {
                    HStack(spacing: 0) {
                        Text(showingMore ? "less" : "more")
                        Image(systemName: showingMore ? "chevron.up" : "chevron.down")
                    }
                    .foregroundColor(.accentColor)
                }
                .buttonStyle(.plain)

            }
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .padding(.top, 8)
        .padding(.bottom, 8)
        .background(Color.white)
        .cornerRadius(10)
    }
}

