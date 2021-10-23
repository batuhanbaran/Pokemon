//
//  Observable.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 15.10.2021.
//

import Foundation

public final class Observable<Value> {

    private var closure: ((Value) -> ())?

    public var value: Value {
        didSet { closure?(value) }
    }

    public init(value: Value) {
        self.value = value
    }

    public func observe(_ closure: @escaping (Value) -> Void) {
        self.closure = closure
        closure(value)
    }
}
