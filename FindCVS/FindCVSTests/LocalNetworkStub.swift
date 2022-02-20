//
//  LocalNetworkStub.swift
//  FindCVSTests
//
//  Created by Hamlit Jason on 2022/02/20.
//

import Foundation
import Stubber // 네트워크 상에서 너무 변수가 많으니까 가상의 네트워크에서 주입하는거
import RxSwift

@testable import FindCVS

class LocalNetworkStub: LocalNetwork {
    // LocalNetwork 상속 받아서 사용함.
    override func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        return Stubber.invoke(getLocation, args: mapPoint)
    }
}
