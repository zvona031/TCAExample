import ComposableArchitecture
import SwiftUI

@ViewAction(for: ChildA.self)
struct ChildAView: View {
    let store: StoreOf<ChildA>

    var body: some View {
        WithPerceptionTracking {
            WithPerceptionTracking {
                VStack {
                    switch store.data {
                    case .initial:
                        EmptyView()
                    case .loading:
                        ProgressView()
                            .progressViewStyle(.circular)
                    case .loaded(let text):
                        Text(text)
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
}

