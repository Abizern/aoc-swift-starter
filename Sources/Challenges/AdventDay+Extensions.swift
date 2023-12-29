import Foundation
import Utilities

public extension AdventDay {
    /// An initializer that loads the test data from the corresponding data file.
    init() {
        self.init(rawInput: Self.loadData(challengeDay: Self.day))
    }

    static func loadData(challengeDay: Int) -> String {
        let dayString = String(format: "%02d", challengeDay)
        let dataFilename = "day\(dayString)"
        let dataURL = Bundle.module.url(
            forResource: dataFilename,
            withExtension: "txt",
            subdirectory: "Inputs"
        )

        guard let dataURL,
              let rawInput = try? String(contentsOf: dataURL, encoding: .utf8)
        else {
            fatalError("Couldn't find file '\(dataFilename).txt' in the 'Inputs' directory.")
        }
        return rawInput
    }
}
