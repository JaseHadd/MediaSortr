// Large parts of code in this file are modified from code in the 
// SwiftyLevenshtein repository, the license for that code is included below.
// This license also obviously applies to my modifications of that code, in lieu
// of any other license that applies to this project.

// Original code available at: https://github.com/garrefa/SwiftyLevenshtein. 

//  Copyright © 2016 dryverless. (http://www.dryverless.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

extension String {
    func distance(to otherString: String) -> Int {
        let source = Array(self.unicodeScalars)
        let target = Array(otherString.unicodeScalars)
        let (sourceLength, targetLength) = (source.count, target.count)
        var distance = Matrix(rows: targetLength + 1, columns: sourceLength + 1, initialValue: 0)

        for sourceIndex in 1...sourceLength {
            distance[0, sourceIndex] = sourceIndex
        }
        for targetIndex in 1...targetLength {
            distance[targetIndex, 0] = targetIndex
        }
        for sourceIndex in 1...sourceLength {
            for targetIndex in 1...targetLength {
                if source[sourceIndex - 1] == target[targetIndex - 1] {
                    // same character
                    distance[targetIndex, sourceIndex] = distance[targetIndex - 1, sourceIndex - 1]
                } else {
                    let deletions = distance[targetIndex, sourceIndex - 1] + 1
                    let insertions = distance[targetIndex - 1, sourceIndex] + 1
                    let substitutions = distance[targetIndex - 1, sourceIndex - 1] + 1

                    distance[targetIndex, sourceIndex] = min(min(insertions, deletions), substitutions)
                }
            }
        }

        return distance[target.count, source.count]
    }
}

fileprivate struct Matrix<Element> {
    private(set) var rows, columns: Int
    var contents: [Element]

    init(rows: Int, columns: Int, initialValue: Element) {
        self.rows = rows
        self.columns = columns
        self.contents = Array(repeating: initialValue, count: rows * columns)
    }

    subscript(row: Int, column: Int) -> Element {
        get { return contents[columns * row + column] }
        set { contents[columns * row + column] = newValue }
    }
}
