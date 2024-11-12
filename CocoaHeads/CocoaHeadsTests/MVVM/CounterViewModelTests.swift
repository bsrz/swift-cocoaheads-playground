@testable import CocoaHeads
import Testing

struct CounterViewModelTests {

    @Test
    func testGivenInitialState_whenNoActions_thenCountIsZero() {
        let sut = CounterViewModel()
        #expect(sut.state.count == 0)
    }

    @Test
    func testGivenInitialState_whenDecrementAction_thenCountIsMinusOne() {
        let sut = CounterViewModel()
        sut.send(.decrement)
        #expect(sut.state.count == -1)
    }

    @Test
    func testGivenInitialState_whenIncrementAction_thenCountIsOne() {
        let sut = CounterViewModel()
        sut.send(.increment)
        #expect(sut.state.count == 1)
    }

    @Test
    func testGivenInitialState_whenRandomActions_thenCountIsExpected() {
        let decrements = Int.random(in: 0..<100)
        let increments = Int.random(in: 0..<100)
        let sut = CounterViewModel()

        for _ in 0...decrements {
            sut.send(.decrement)
        }
        for _ in 0...increments {
            sut.send(.increment)
        }

        #expect(sut.state.count == increments - decrements)
    }
}
