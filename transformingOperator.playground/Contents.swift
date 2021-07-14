import UIKit
import RxSwift

//Transforming element
let bag = DisposeBag()
Observable.of(1 ,2 ,3 ,4 ,5 ,6 )
    .toArray()
    .subscribe(onSuccess: {value in
        print(value)
    } ).disposed(by: bag)
print("------------------")

let bag2 = DisposeBag()
let formatter = NumberFormatter()
formatter.numberStyle = .spellOut
Observable<Int>
    .of(1 ,2 ,4 ,5 ,10 , 999, 9999, 1000000)
    .map{ formatter.string(for: $0) ?? "" }
    .subscribe(onNext:{ string in
        print(string)
    })
    .disposed(by: bag)
print("------------------")

let disposeBag = DisposeBag()

Observable.of(1 ,2 ,3 ,4 ,5 ,6)
    .enumerated()
    .map{ index, integer in
        index > 2 ? integer*2 : integer
    }
    .subscribe(onNext:{ print($0) })
    .disposed(by: disposeBag)
/*
let array = Array(0...10)
Observable.from(array)
    .enumerated()
    .map{ index ,integer in
        index % 2 == 0 ? integer * 2 : integer
    }
    .subscribe(onNext:{ print($0)})
    .disposed(by:disposeBag)
*/
print("------------------")
print("------------------")
print("------------------")
/// User để tạo ra đối tượng người dùng
struct User{
    /// - Parameter value: BehaviorSubject<String>
    let message : BehaviorSubject<String>
    
}
let bag3 = DisposeBag()

let cuTy = User(message: BehaviorSubject(value: "Cu tý chào bạn"))
let cuTeo = User(message: BehaviorSubject(value: "Cu tèo chào bạn"))
let subject = PublishSubject<User>()
subject.flatMapLatest{ $0.message }
    .subscribe(onNext: { msg in
        print(msg)
    })
    .disposed(by: bag3)

subject.onNext(cuTy)
cuTy.message.onNext("Cu Tý: There are 0 ball in the basket")
cuTy.message.onNext("Cu Tý: There are 1 ball in the basket")
cuTy.message.onNext("Cu Tý: There are 2 ball in the basket")
cuTy.message.onNext("Cu Tý: There are 3 ball in the basket")
cuTy.message.onNext("Cu Tý: There are 4 ball in the basket")
subject.onNext(cuTeo)
cuTy.message.onNext("Cu Tý: Hello Cu Tèo")
cuTeo.message.onNext("Cu Tèo: What chu doing?")
cuTy.message.onNext("Cu Tý: Counting balls")
cuTy.message.onNext("Cu Tý: I Have 4 Ball")
cuTeo.message.onNext("Cu Tèo Can I have 1?")
print("------------------")

let bag4 = DisposeBag()

subject.flatMap{ $0.message }
    .subscribe(onNext: { msg in
        print(msg)
    })
    .disposed(by: bag4)
let cuTi = User(message: BehaviorSubject(value: "Cu tý chào bạn"))
let cuTe = User(message: BehaviorSubject(value: "Cu tèo chào bạn"))
let subject1 = PublishSubject<User>()
subject1.onNext(cuTi)
cuTi.message.onNext("Cu Tý: There are 0 ball in the basket")
cuTi.message.onNext("Cu Tý: There are 1 ball in the basket")
cuTi.message.onNext("Cu Tý: There are 2 ball in the basket")
cuTi.message.onNext("Cu Tý: There are 3 ball in the basket")
cuTi.message.onNext("Cu Tý: There are 4 ball in the basket")
subject1.onNext(cuTeo)
cuTi.message.onNext("Cu Tý: Hello Cu Tèo")
cuTe.message.onNext("Cu Tèo: What chu doing?")
cuTi.message.onNext("Cu Tý: Counting balls")
cuTi.message.onNext("Cu Tý: I Have 4 Ball")
cuTe.message.onNext("Cu Tèo Can I have 1?")

