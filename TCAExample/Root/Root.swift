import ComposableArchitecture

@Reducer
struct Root {

    @ObservableState
    struct State {
        var a: FeatureA.State
        var b: FeatureB.State
        var selectedFeature: Feature

        init(
            a: FeatureA.State = FeatureA.State(),
            b: FeatureB.State = FeatureB.State(),
            selectedFeature: Feature = .a
        ) {
            self.a = a
            self.b = b
            self.selectedFeature = selectedFeature
        }

    }

    enum Action: ViewAction {
        case a(FeatureA.Action)
        case b(FeatureB.Action)
        case view(View)

        enum View {
            case selectFeature(Feature)
        }
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.a, action: \.a) {
            FeatureA()
        }

        Scope(state: \.b, action: \.b) {
            FeatureB()
        }

        Reduce { state, action in
            switch action {
            case .view(.selectFeature(let feature)):
                state.selectedFeature = feature
                return .none

            case .a:
                return .none

            case .b:
                return .none
            }
        }
    }
}

extension Root {
    enum Feature {
        case a
        case b
    }
}
