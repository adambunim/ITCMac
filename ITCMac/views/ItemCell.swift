
import SwiftUI
import MapKit

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
                
                if let lat = item.lat, let long = item.long {
                    HStack {
                        Spacer()
                        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long)), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))), interactionModes: [])
                            .frame(width: 200, height: 200)
                        Spacer()
                    }
                }
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

