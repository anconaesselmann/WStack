//  Created by Axel Ancona Esselmann on 3/28/24.
//

import SwiftUI

public extension View {
    func writeSize(to size: Binding<CGSize>) -> some View {
        background(ViewSizeReader(size))
    }

    func writeSize<ID: Hashable>(for id: ID, to elementSizes: Binding<[ID: CGSize]>) -> some View {
        writeSize(to: Binding(
            get: { elementSizes.wrappedValue[id] ?? .zero },
            set: { elementSizes.wrappedValue[id] = $0 }
        ))
    }
}
