//  Created by Axel Ancona Esselmann on 3/28/24.
//

import Foundation

public extension Array {
    func bin<T>(using transform: (Element) -> T, whenFull condition: (T) -> Bool) -> [[Element]]
        where T: Numeric
    {
        var bins: [[Element]] = []
        var currentBin: [Element] = []
        var accumulator: T = 0
        for element in self {
            let currentValue = transform(element)
            guard !condition(currentValue) else {
                if !currentBin.isEmpty {
                    bins.append(currentBin)
                    currentBin = []
                }
                bins.append([element])
                accumulator = 0
                continue
            }
            accumulator += currentValue
            if condition(accumulator) {
                bins.append(currentBin)
                currentBin = [element]
                accumulator = currentValue
            } else {
                currentBin.append(element)
            }
        }
        if !currentBin.isEmpty {
            bins.append(currentBin)
        }
        return bins
    }
}
