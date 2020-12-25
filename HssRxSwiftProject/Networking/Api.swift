
import Foundation
import RxSwift
import RxCocoa

protocol Api {
    func apiGithub() -> Observable<String>
}
