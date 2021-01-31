//
//  Settings.swift
//  CashTree
//
//  Created by La Luo on 1/25/21.
//

import SpriteKit

enum PhysicsCategories {
    static let none: UInt32 = 0
    static let dollarCategory: UInt32 = 0x1  // 00000001  0x00000001
    static let bluebugCategory: UInt32 = 0x1 << 1  // 00000010  0x00000002
    static let playerCategory: UInt32 = 0x1 << 2  // 00000100  0x00000004
    static let groundCategory: UInt32 = 0x1 << 3  // 00001000  0x00000008
}
