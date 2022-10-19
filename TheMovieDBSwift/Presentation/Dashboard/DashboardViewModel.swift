import RxSwift
import RxCocoa
import NSObject_Rx
import Action

final class DashboardViewModel: BaseViewModel {
    // MARK: - Dependency

    // MARK: - Input
    private let viewDidloadObserver = BehaviorSubject<Void>(value: ())
    // MARK: - Output
    private let errorObserver = BehaviorSubject<String>(value: "")
    private let movieListObserver = BehaviorSubject<[Movie]>(value: [])
    
    override init() {
        super.init()
        self.binding()
    }
    
    private func binding() {
    }
}

extension DashboardViewModel: DashboardViewModelType {
    var input: DashboardViewModelInputType {
        return self
    }
    var output: DashboardViewModelOutputType {
        return self
    }
}

extension DashboardViewModel: DashboardViewModelInputType {
    var viewDidLoad: AnyObserver<Void> {
        return viewDidloadObserver.asObserver()
    }
}

extension DashboardViewModel: DashboardViewModelOutputType {
    var MoviesResult: Observable<[Movie]> {
        return movieListObserver.asObservable()
    }
}
