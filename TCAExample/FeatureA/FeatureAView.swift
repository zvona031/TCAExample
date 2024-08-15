import ComposableArchitecture
import SwiftUI

@ViewAction(for: FeatureA.self)
struct FeatureAView: View {
    let store: StoreOf<FeatureA>

    var body: some View {
        WithPerceptionTracking {
            VStack {
                switch store.data {
                case .initial:
                    EmptyView()
                case .loading:
                    ProgressView()
                        .progressViewStyle(.circular)
                case .loaded:
                    if let store = store.scope(state: \.data.loaded, action: \.screenType) {
                        switch store.case {
                        case .childA(let store):
                            ChildAView(store: store)
                        case .childB(let store):
                            ChildBView(store: store)
                        }
                    }
                case .failed:
                    Text("Failed")
                }
            }
            .onFirstAppear {
                send(.onFirstAppear)
            }
        }
    }
}

