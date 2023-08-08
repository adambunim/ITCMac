
import SwiftUI
import MapKit

struct ItemEditView: View {
    
    let item: FeedItem
    @EnvironmentObject var apiState: ApiState
    @Binding var showingSheet: Bool
    @State var title = ""
    @State var details = ""
    @State var error = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: telAviv.latitude, longitude: telAviv.longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                if error {
                    Image(systemName: "exclamationmark")
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                Button(action: {
                    showingSheet = false
                }) {
                    Text("x")
                }
            }
            
            Form {
                TextField("Title", text: $title)
                TextField("Details", text: $details)
            }
            
            Map(coordinateRegion: $region)
                        .frame(width: 200, height: 200)
            
            Button(action: save) {
                Text("Save")
            }
            .disabled(!isChanged())
            .buttonStyle(.plain)
            .foregroundColor(.accentColor)
            
            Button(action: delete) {
                Text("Delete")
                    .foregroundColor(.red)
            }
            .buttonStyle(.plain)
            .foregroundColor(.red)
        }
        .padding()
        .frame(width: 300, alignment: .leading)
        .onAppear {
            title = item.title
            details = item.details
            if let lat = item.lat, let long = item.long {
                region.center.latitude = lat
                region.center.longitude = long
            }
        }
    }
    
    func isChanged() -> Bool {
        if title != item.title || details != item.details {
            return true
        }
        
        if let lat = item.lat, let long = item.long {
            return !region.center.latitude.isNear(lat) || !region.center.longitude.isNear(long)
        }
        else {
            return !region.center.latitude.isNear(telAviv.latitude) || !region.center.longitude.isNear(telAviv.longitude)
        }
    }
    
    func save() {
        let item = FeedItem(id: item.id, title: title, details: details, lat: region.center.latitude, long: region.center.longitude)
        Api.edit(item.id, item) { success in
            DispatchQueue.main.async {
                if success {
                    apiState.items = apiState.items.filter {
                        $0.id != item.id
                    }
                    apiState.items.append(item)
                    showingSheet = false
                }
                else {
                    error = true
                }
            }
        }
    }
    
    func delete() {
        Api.delete(item.id) { success in
            DispatchQueue.main.async {
                if success {
                    apiState.items = apiState.items.filter {
                        $0.id != item.id
                    }
                    showingSheet = false
                }
                else {
                    error = true
                }
            }
        }
    }
    
}

extension Double {
    func isNear(_ other: Double) -> Bool {
        let delta = abs(self - other)
        return delta < 0.0001
    }
}
