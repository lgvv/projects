//
//  LocationInformationModelTest.swift
//  FindCVSTests
//
//  Created by Hamlit Jason on 2022/02/18.
//

import XCTest
import Nimble

@testable import FindCVS

class LocationInformationModelTest: XCTestCase {
    
    let stubNetwork = LocalNetworkStub()
    var doc: [KLDocument]!
    var model: LocationInformationModel!

    override func setUp() {
        // 가상의 네트워크 모델을 주고 시작한다.
        self.model = LocationInformationModel(localNetwork: stubNetwork)
        self.doc = cvsList
    }

    
    func testdocumentsToCellData() {
        let cellData = model.documentsToCellData(doc) // 실제 모델의 값
        let placeName = doc.map { $0.placeName } // dummy의 값
        let address0 = cellData[1].address// 실제 모델의 값
        let roadAddressName = doc[1].roadAddressName // dummy의 값
        
        // 실제와 동일해야 한다. 즉, 외부의 값 자체가 달라져서는 안된다.
        expect(cellData.map {$0.placeName}).to(
            equal(placeName),
            description: "DetailListCellData의 placeName은 document의 PlaceName이다")
        
        expect(address0).to(
            equal(roadAddressName),
            description: "KLDocument의 RoadAddressName이 빈 값이 아닐경우 roadAddress가 CellData에 전달된다.")
    }

}
