//
//  Binder<String>+Extension.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import Foundation
import RxSwift

extension ObservableType where Element == String? {
    func orEmpty() -> Observable<String> {
        return self.map { $0 ?? "" }
    }
}
