
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
                
                if showingMore {
                    HStack(spacing: 0) {
                        Button(action: {
                            showingMore = false
                        }) {
                            Text("less")
                        }
                        .buttonStyle(.plain)
                        
                        Image(systemName: "chevron.up")
                    }
                    .foregroundColor(.accentColor)
                }
                else {
                    HStack(spacing: 0) {
                        Button(action: {
                            showingMore = true
                        }) {
                            Text("more")
                        }
                        .buttonStyle(.plain)
                        
                        Image(systemName: "chevron.down")
                    }
                    .foregroundColor(.accentColor)
                }
            }            
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

