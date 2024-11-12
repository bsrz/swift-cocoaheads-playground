@testable import CocoaHeads
import ComposableArchitecture
import Foundation
import Testing

@MainActor
struct CounterListReducerTests {

    @Test
    func testGivenInitialState_whenAddAction_thenCounterAdded() async {
        let store = TestStore(
            initialState: CounterListReducer.State(),
            reducer: { CounterListReducer() },
            withDependencies: {
                $0.uuid = .incrementing
            }
        )

        await store.send(.add) {
            $0.counters = [
                CounterReducer.State(id: UUID(0))
            ]
        }
    }

    @Test
    func testGivenOneCounter_whenRemoveAction_thenCounterRemoved() async {
        let store = TestStore(
            initialState: CounterListReducer.State(
                counters: [
                    CounterReducer.State(id: UUID(0))
                ]
            ),
            reducer: { CounterListReducer() }
        )

        await store.send(.remove(UUID(0))) {
            $0.counters = []
        }
    }
}
