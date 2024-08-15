import ComposableArchitecture

@Reducer
struct ChildB {

    @ObservableState
    struct State: Equatable {
        var data: LoadableState<String>

        init(data: LoadableState<String> = .loading) {
            self.data = data
        }
    }

    enum Action: ViewAction {
        case view(View)
        case taskResponse

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
                    try await Task.sleep(nanoseconds: 1000000000)
                    await send(.taskResponse)
                }
            case .taskResponse:
                state.data = .loaded("Loaded Child B")
                return .none
            }
        }
    }
}

