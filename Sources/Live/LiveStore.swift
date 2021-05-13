//
//  File.swift
//  
//
//  Created by Nicholas Della Valle on 5/13/21.
//

import Foundation
import Combine
import SwiftUI

public typealias Reducer<State, Action, Environment> =
  (inout State, Action, Environment) -> AnyPublisher<Action, Never>?

public func packageReducer(state: inout PackageState, action: PackageAction, services :Services) -> AnyPublisher<PackageAction, Never> {
    
    switch action {
    case .add(value: let value):
        state.value += value
    }
    
    return Empty().eraseToAnyPublisher()

}

public struct System {}

public enum PackageAction {
    case add(value: Int)
}

public struct Services {
    public init() {}
}

public struct PackageState: Equatable {
    
    public init() {}
    
    var value: Int = 0
}


public typealias PackageStore = Store<PackageState, PackageAction, Services>

public final class Store<State, Action, Environment>: ObservableObject {
  @Published private(set) var state: State
  
  private let services: Environment
  private let reducer: Reducer<State, Action, Environment>
  private var cancellables: Set<AnyCancellable> = []
  
  public init(initialState: State, reducer: @escaping Reducer<State, Action, Environment>, services: Environment) {
    self.state = initialState
    self.reducer = reducer
    self.services = services
    
    
  }
  
  func send(_ action: Action) {
    guard let effect = reducer(&state, action, services) else {
      return
    }
    
    effect
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: send)
      .store(in: &cancellables)
  }
    
    
}

