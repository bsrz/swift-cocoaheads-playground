@testable import CocoaHeads
import Foundation
import Testing

struct CounterListViewModelTests {

    @Test
    func testGivenInitialState_whenNoActions_thenListIsempty() {
        let sut = CounterListViewModel()
        #expect(sut.state.counters.isEmpty)
    }

    @Test
    func testGivenInitialState_whenAddAction_thenCounterAdded() {
        let sut = CounterListViewModel()

        sut.send(.add)

        #expect(sut.state.counters.count == 1)
    }

    @Test
    func testGivenOneCounter_whenRemoveAction_thenCounterRemoved() {
        let id = UUID()
        let state = CounterListViewModel.State(
            counters: [
                CounterViewModel(state: CounterViewModel.State(id: id))
            ]
        )
        let sut = CounterListViewModel()

        sut.send(.remove(id))

        #expect(sut.state.counters.count == 0)
    }
}
