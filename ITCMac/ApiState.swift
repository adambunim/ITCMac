
import SwiftUI

class ApiState: ObservableObject {
    @Published var items: [FeedItem] = []
    @Published var showingAlert = false
    @Published var errorMessage: String? = nil
    @Published var loading = false
}
