import ComposableArchitecture
import SwiftUI

@ViewAction(for: Root.self)
struct RootView: View {
    let store: StoreOf<Root>

    init(store: StoreOf<Root> = Store(initialState: Root.State()) {
        Root()
    }) {
        self.store = store
    }

    var body: some View {
        WithPerceptionTracking {
            VStack {
                HStack {
                    Button("Feature A") {
                        send(.selectFeature(.a))
                    }
                    Button("Feature B") {
                        send(.selectFeature(.b))
                    }
                }
                Group {
                    switch store.selectedFeature {
                    case .a:
                        FeatureAView(store: store.scope(state: \.a, action: \.a))
                    case .b:
                        FeatureBView(store: store.scope(state: \.b, action: \.b))
                    }
                }
                .frame(maxHeight: .infinity)
            }
        }
    }
}

