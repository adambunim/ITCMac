
import SwiftUI

class ObservableItems: ObservableObject {
    @Published var list: [FeedItem] = []
}
