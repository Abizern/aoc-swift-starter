import ArgumentParser
import Challenges
import Utilities

let allProblems: [any AdventDay] = [
    Day01(),
]

@main
struct AdventOfCode: AsyncParsableCommand {
    @Argument(help: "The day of the challenge. For December 1st, use '1'.")
    var day: Int?

    @Flag(help: "Benchmark the time taken by the solution")
    var benchmark: Bool = false

    @Flag(help: "Run all the days available")
    var all: Bool = false

    /// The selected day, or the latest day if no selection is provided.
    var selectedProblem: any AdventDay {
        get throws {
            if let day {
                if let problem = allProblems.first(where: { $0.day == day }) {
                    return problem
                } else {
                    throw ValidationError("No solution found for day \(day)")
                }
            } else {
                return latestProblem
            }
        }
    }

    /// The latest problems  in `allProblems`.
    var latestProblem: any AdventDay {
        allProblems.max(by: { $0.day < $1.day })!
    }

    func run<T>(part: () async throws -> T, named: String) async -> Duration {
        var result: Result<T, Error>?
        let timing = await ContinuousClock().measure {
            do {
                result = try .success(await part())
            } catch {
                result = .failure(error)
            }
        }
        switch result! {
        case let .success(success):
            print("\(named): \(success)")
        case let .failure(failure as PartUnimplemented):
            print("Day \(failure.day) part \(failure.part) unimplemented")
        case let .failure(failure):
            print("\(named): Failed with error: \(failure)")
        }
        return timing
    }

    func run() async throws {
        let problems =
            if all {
                allProblems
            } else {
                try [selectedProblem]
            }

        for problem in problems {
            print("Executing Advent of Code problem \(problem.day)...")

            let timing1 = await run(part: problem.part1, named: "Part 1")
            let timing2 = await run(part: problem.part2, named: "Part 2")

            if benchmark {
                print("Part 1 took \(timing1), part 2 took \(timing2).")
                #if DEBUG
                    print("Looks like you're benchmarking debug code. Try swift run -c release")
                #endif
            }
        }
    }
}
