import ComposableArchitecture

@Reducer
struct FeatureA {

    @ObservableState
    struct State {
        var data: LoadableState<ScreenType.State>

        init(data: LoadableState<ScreenType.State> = .loading) {
            self.data = data
        }
    }

    enum Action: ViewAction {
        case view(View)
        case taskResponse
        case screenType(ScreenType.Action)

        enum View {
            case onFirstAppear
        }
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .view(.onFirstAppear):
                state.data = .loading
                return .run { send in
                    // This represents the request for the screen type that should be presented
                    try await Task.sleep(nanoseconds: 1000000000)
                    await send(.taskResponse)
                }

            case .taskResponse:
                // Depending on the user type fetched from the request, different screen should be displayed, but here it is hardcoded to display ChildA
                state.data = .loaded(.childA(ChildA.State()))
                return .none

            case .screenType:
                return .none
            }
        }
        .ifLet(\.data.loaded, action: \.screenType) {
            ScreenType.body
        }
        ._printChanges()
    }
}

extension FeatureA {
    @Reducer(state: .equatable)
    enum ScreenType {
        case childA(ChildA)
        case childB(ChildB)
    }
}
