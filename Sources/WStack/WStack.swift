//  Created by Axel Ancona Esselmann on 3/27/24.
//

import SwiftUI

public struct WStack<Element, ElementContent>: View
    where
        Element: Hashable,
        Element: Identifiable,
        ElementContent: View
{

    private let elements: [Element]
    private let alignment: HorizontalAlignment
    private let verticalSpacing: CGFloat?

    @ViewBuilder
    private var elementContentBuilder: (Element) -> ElementContent

    @State
    private var containerSize: CGSize = .zero

    @State
    private var elementSizes: [Element.ID: CGSize] = [:]

    private var bins: [[Element]] {
        elements.bin {
            elementSizes[$0.id]?.width ?? .zero
        } whenFull: {
            $0 >= containerSize.width
        }
    }

    public init(
        _ data: [Element],
        alignment: HorizontalAlignment = .center,
        verticalSpacing: CGFloat? = nil,
        @ViewBuilder
        elementContentBuilder: @escaping (Element) -> ElementContent
    ) {
        self.alignment = alignment
        self.verticalSpacing = verticalSpacing
        self.elements = data
        self.elementContentBuilder = elementContentBuilder
    }

    public var body: some View {
        VStack(alignment: alignment, spacing: verticalSpacing) {
            ViewSizeReader($containerSize)
            ForEach(bins, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(row) { element in
                        elementContentBuilder(element)
                            .writeSize(for: element.id, to: $elementSizes)
                            .frame(minWidth: elementSizes[element.id]?.width ?? containerSize.width)
                    }
                }
            }
        }
    }
}
