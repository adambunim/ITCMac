
import SwiftUI

class ApiState: ObservableObject {
    @Published var items: [FeedItem] = []
    @Published var loading = false
}
