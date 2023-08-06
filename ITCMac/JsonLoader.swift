
import Foundation

func loadJson() {
    if let filepath = Bundle.main.path(forResource: "example", ofType: "txt") {
        do {
            let contents = try String(contentsOfFile: filepath)
            print(contents)
        } catch {
            // contents could not be loaded
        }
    } else {
        // example.txt not found!
    }
}
