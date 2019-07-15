//
//  ConstrainArray+Extension.swift
//  SnapKitExtensionDemo
//
//  Created by echonn on 2018/5/21.
//  Copyright © 2018年 echonn. All rights reserved.
//

import SnapKit

public extension ConstraintArray {
    public var snp: ConstraintArrayDSL {
        return ConstraintArrayDSL(array: self as! Array<ConstraintView>)
    }
}

