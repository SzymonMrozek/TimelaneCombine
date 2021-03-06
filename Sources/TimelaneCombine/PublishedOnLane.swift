//
//  PublishedOnLane.swift
//  TimelaneCombine
//
//  Created by Casey Liss on 28/2/20.
//  Copyright © 2020 Limitliss LLC. All rights reserved.
//

import Combine
import TimelaneCore

/// Property wrapper that offers a publisher for the given property
/// **and** creates a Timelane lane for it.
@propertyWrapper public class PublishedOnLane<Value> {
    @Published private var value: Value
    private let laneName: String
    private let filter: Set<Timelane.LaneType>
    
    /// Gets or sets the value of this property.
    public var wrappedValue: Value {
        get { self.value }
        set { self.value = newValue }
    }
    
    /// Gets the lane-enabled `Publisher` for this property.
    public var projectedValue: AnyPublisher<Value, Never> {
        return self.$value.lane(laneName, filter: filter).eraseToAnyPublisher()
    }

    /// Creates a `PublishedOnLane` wrapper.
    /// - Parameters:
    ///   - initialValue: Value to wrap; usually implicit.
    ///   - name: The name of this lane; defaults to the
    ///           type of this property if not provided.
    public init(wrappedValue initialValue: Value,
                _ name: String? = nil,
                filter: Set<Timelane.LaneType> = Set(Timelane.LaneType.allCases)) {
        self.value = initialValue
        self.laneName = name ?? "\(initialValue.self)"
        self.filter = filter
    }
}
