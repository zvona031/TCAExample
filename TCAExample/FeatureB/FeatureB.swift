import ComposableArchitecture

@Reducer
struct FeatureB {

    @ObservableState
    struct State {

    }

    enum Action {

    }

    var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}
