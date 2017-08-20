public typealias NoArguments = Void

public protocol State {
    associatedtype Arguments
    associatedtype MappedState

    static func create(arguments: Arguments, state: MappedState) -> Self
}

public protocol StateTakingInput: State {
    typealias MappedState = Void

    static func create(arguments: Arguments) -> Self
}

extension StateTakingInput {
    public static func create(arguments: Arguments, state: Void) -> Self {
        return self.create(arguments: arguments)
    }
}

public protocol StateUsingMappedState: State {
    typealias Arguments = NoArguments

    static func create(state: MappedState) -> Self
}

extension StateUsingMappedState {
    public static func create(arguments: NoArguments, state: MappedState) -> Self {
        return self.create(state: state)
    }
}

extension State {
    static var stateId: String { return String(describing: Self.self) }
    var stateId: String { return Self.stateId }

    public static func ==(lhs: Self, rhs: Self) -> Bool { //todo
        return lhs.stateId == type(of: rhs).stateId
    }

    public static var slot: StateSlot<Arguments, Self> {
        return StateSlot()
    }
}
