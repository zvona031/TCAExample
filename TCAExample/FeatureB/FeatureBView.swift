import ComposableArchitecture
import SwiftUI

struct FeatureBView: View {
    let store: StoreOf<FeatureB>

    var body: some View {
        WithPerceptionTracking {
            Text("B")
        }
    }
}

