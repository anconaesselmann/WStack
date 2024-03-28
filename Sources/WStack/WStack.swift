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
    private var size: CGSize = .zero

    @State
    private var sizes: [Element.ID: CGSize] = [:]

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
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        size = proxy.size
                    }
                    .onChange(of: proxy.size) {
                        size = proxy.size
                    }
            }
            .frame(height: 0)
            let bins = createBins(elements, for: size.width)
            ForEach(bins, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(row, id: \.self) { element in
                        elementContentBuilder(element)
                            .background(
                                GeometryReader { proxy in
                                    Color.clear
                                        .onAppear {
                                            if proxy.size.width < (sizes[element.id]?.width ?? size.width) {
                                                sizes[element.id] = proxy.size
                                            }
                                        }
                                        .onChange(of: proxy.size) {
                                            if proxy.size.width < (sizes[element.id]?.width ?? size.width) {
                                                sizes[element.id] = proxy.size
                                            }
                                        }
                                }
                            )
                            .frame(minWidth: sizes[element.id]?.width ?? size.width)
                    }
                }
            }
        }
    }

    private func createBins(_ elements: [Element], for width: CGFloat) -> [[Element]] {
        var rows: [[Element]] = []
        var row: [Element] = []
        var rowWidth: CGFloat = 0
        for element in elements {
            let elementWidth = sizes[element.id]?.width ?? .zero
            guard elementWidth < width else {
                if !row.isEmpty {
                    rows.append(row)
                    row = []
                }
                rows.append([element])
                rowWidth = 0
                continue
            }
            rowWidth += elementWidth
            if rowWidth < width {
                row.append(element)
            } else {
                rows.append(row)
                row = [element]
                rowWidth = elementWidth
            }
        }
        if !row.isEmpty {
            rows.append(row)
        }
        return rows
    }
}
