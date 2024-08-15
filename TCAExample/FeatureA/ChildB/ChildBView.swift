import ComposableArchitecture
import SwiftUI

@ViewAction(for: ChildB.self)
struct ChildBView: View {
    let store: StoreOf<ChildB>

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

