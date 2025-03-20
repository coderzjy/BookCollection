//
//  Layout.swift
//  BookCollection
//
//  Created by zjy on 2025/3/19.
//

import UIKit
import SnapKit


// MARK: - UI 代码链式调用

extension UIView: NamespaceProtocol { }
extension TypeWrapperProtocol where WrappedType: UIView {
    
    @discardableResult
    public func adhere(toSuperView: UIView) -> WrappedType {
        toSuperView.addSubview(wrappedValue)
        return wrappedValue
    }
    
    @discardableResult
    public func layout(snapKitMaker: (ConstraintMaker) -> Void) ->  WrappedType{
        wrappedValue.snp.makeConstraints { (make) in
            snapKitMaker(make)
        }
        return wrappedValue
    }
    
    @discardableResult
    public func config(_ config: (WrappedType) -> Void) -> WrappedType {
        config(wrappedValue)
        return wrappedValue
    }
}
