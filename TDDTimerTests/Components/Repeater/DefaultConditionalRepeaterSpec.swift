import Quick
import Nimble
@testable import TDDTimer

class DefaultConditionalRepeaterSpec: QuickSpec {
    override func spec() {
        describe("the default conditional repeater") {
            it("starts the timer") {
                let conditionalRepeater = DefaultConditionalRepeater()
                conditionalRepeater.start(
                    timeInterval: 0.01,
                    conditionToStop: nil,
                    closureToRepeat: nil
                )


                expect(conditionalRepeater.isValid).to(beTrue())
            }

            it("invokes the closure to repeat after calling start") {
                let conditionalRepeater = DefaultConditionalRepeater()


                var closureWasCalled = false
                conditionalRepeater.start(
                    timeInterval: 0.01,
                    conditionToStop: nil,
                    closureToRepeat: {
                        closureWasCalled = true
                    }
                )
                RunLoop.advance()


                expect(closureWasCalled).to(beTrue())
            }

            it("invalidates the timer when stop is invoked") {
                let conditionalRepeater = DefaultConditionalRepeater()
                conditionalRepeater.start(
                    timeInterval: 0.01,
                    conditionToStop: nil,
                    closureToRepeat: nil
                )


                conditionalRepeater.stop()


                expect(conditionalRepeater.isValid).to(beFalse())
            }

            it("stops the timer automatically when the stop condition is met") {
                let conditionalRepeater = DefaultConditionalRepeater()
                conditionalRepeater.start(
                    timeInterval: 0.01,
                    conditionToStop: {
                        return true
                    },
                    closureToRepeat: nil
                )


                expect(conditionalRepeater.isValid).toEventually(beFalse())
            }
        }
    }
}
