@testable import CocoaHeads
import ComposableArchitecture
import Testing

@MainActor
struct CounterReducerTests {

    @Test
    func testGivenInitialState_whenDecrementAction_thenCountIsMinusOne() async {
        let store = TestStore(
            initialState: CounterReducer.State(),
            reducer: { CounterReducer() }
        )

        await store.send(.decrement) {
            $0.count = -1
        }
    }

    @Test
    func testGivenInitialState_whenIncrementAction_thenCountIsOne() async {
        let store = TestStore(
            initialState: CounterReducer.State(),
            reducer: { CounterReducer() }
        )

        await store.send(.increment) {
            $0.count = 1
        }
    }
}
