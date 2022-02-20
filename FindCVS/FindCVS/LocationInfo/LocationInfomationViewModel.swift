//
//  LocationInfomationViewModel.swift
//  FindCVS
//
//  Created by Hamlit Jason on 2022/02/18.
//

import RxSwift
import RxCocoa

struct LocationInformationViewModel {
    let disposeBag = DisposeBag()
    
    //subViewModels
    let detailListBackgroundViewModel = DetailListBackgroundViewModel()
    
    //viewModel -> view
    let setMapCenter: Signal<MTMapPoint>
    let errorMessage: Signal<String>
    let detailListCellData: Driver<[DetailListCellData]>
    let scrollToSelectedLocation: Signal<Int>
    
    //view -> viewModel
    let currentLocation = PublishRelay<MTMapPoint>()
    let mapCenterPoint = PublishRelay<MTMapPoint>()
    let selectPOIItem = PublishRelay<MTMapPOIItem>()
    let mapViewError = PublishRelay<String>()
    let curentLocationButtonTapped = PublishRelay<Void>()
    let detailListItemSelected = PublishRelay<Int>()
    
    private let documentData = PublishSubject<[KLDocument]>()
    
    init(model: LocationInformationModel = LocationInformationModel()) {
        //MARK: 네트워크 통신으로 데이터 불러오기
        let cvsLocationDataResult = mapCenterPoint
            .flatMapLatest(model.getLocation)
            .share()
        
        let cvsLocationDataValue = cvsLocationDataResult
            .compactMap { data -> LocationData? in
                guard case let .success(value) = data else { // case let으로 변수처럼 사용도 가능
                    return nil
                }
                return value
            }
        
        let cvsLocationDataErrorMessage = cvsLocationDataResult
            .compactMap { data -> String? in
                switch data {
                case let .success(data) where data.documents.isEmpty: // 네트워크 작업에서 데이터가 비어 있다면
                    return """
                    500m 근처에 이용할 수 있는 편의점이 없어요.
                    지도 위치를 옮겨서 재검색해주세요.
                    """
                case let .failure(error):
                    return error.localizedDescription
                default:
                    return nil
                }
            }
        
        cvsLocationDataValue
            .map { $0.documents }
            .bind(to: documentData) // 네트워크 작업 통해서 가져온 값을 바꾼다.
            .disposed(by: disposeBag)
        
        //MARK: 지도 중심점 설정
        let selectDetailListItem = detailListItemSelected // detailListItemSelected에서
            .withLatestFrom(documentData) {
                print($1) // withLatestFrom을 사용하면서 documentData이 $1
                return $1[$0] // $0은 배열 인덱스
            } // documentData을 withLatestFrom로 만든다.
            .map(model.documentToMTMapPoint)
        
        let moveToCurrentLocation = curentLocationButtonTapped
            .withLatestFrom(currentLocation) // 터치 이벤트 들어오면 현재 위치만 담아서 변수에 담는다.
        
        let currentMapCenter = Observable
            .merge(
                selectDetailListItem,
                currentLocation.take(1), // currentLocation는 한번만
                moveToCurrentLocation
            )
        
        setMapCenter = currentMapCenter
            .asSignal(onErrorSignalWith: .empty())
        
        errorMessage = Observable
            .merge(
                cvsLocationDataErrorMessage,
                mapViewError.asObservable()
            )
            .asSignal(onErrorJustReturn: "잠시 후 다시 시도해주세요.")
        
        detailListCellData = documentData
            .map(model.documentsToCellData)
            .asDriver(onErrorDriveWith: .empty())
        
        documentData
            .map { !$0.isEmpty } // Bool 타입으로 내려간다. 배열이 비지 않으면 false가 내려간다.
            .bind(to: detailListBackgroundViewModel.shouldHideStatusLabel)
            .disposed(by: disposeBag)
        
        scrollToSelectedLocation  = selectPOIItem
            .map { $0.tag }
            .asSignal(onErrorJustReturn: 0)
    }
}
