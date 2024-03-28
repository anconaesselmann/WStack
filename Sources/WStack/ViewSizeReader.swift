//  Created by Axel Ancona Esselmann on 3/28/24.
//

import SwiftUI

public struct ViewSizeReader: View {

    @Binding
    private var size: CGSize

    public init(_ size:  Binding<CGSize>) {
        self._size = size
    }

    public var body: some View {
        GeometryReader { proxy in
            Color.clear
                .onAppear {
                    if proxy.size != size {
                        size = proxy.size
                    }
                }
                .onChange(of: proxy.size) {
                    if proxy.size != size {
                        size = proxy.size
                    }
                }
        }
        .frame(height: 0)
    }
}
