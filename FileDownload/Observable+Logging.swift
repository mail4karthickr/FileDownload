import RxSwift

extension Observable {
    func logNext() -> Observable<Element> {
        return self.do(onNext: { element in
            print("\(element)")
        })
    }
}
