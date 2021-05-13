import SwiftUI

public struct PackageStuff: View {
  
@EnvironmentObject var store: PackageStore
    
    public init() {
    }
  
  public var body: some View {
    Button("Change State \(store.state.value)", action: {
        store.send(.add(value: 3))
    })
  }
}
