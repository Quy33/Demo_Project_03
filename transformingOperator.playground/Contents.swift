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
print("------------------")
print("------------------")
print("------------------")

//observing events
enum MyError: Error{
    case anError
}

let bag5 = DisposeBag()
let C1 = User(message: BehaviorSubject(value: "C1 chào bạn"))
let C2 = User(message: BehaviorSubject(value: "C2 chào bạn"))
let subject2 = PublishSubject<User>()
let roomChat = subject2
    .flatMapLatest{ $0.message.materialize() }
roomChat.subscribe(onNext:{ msg in
    print(msg)
})
.disposed(by: bag5)
subject2.onNext(C1)
C1.message.onNext("Tý A")
C1.message.onNext("Tý B")
C1.message.onNext("Tý C")

C1.message.onError(MyError.anError)
C1.message.onNext("Tý D")
C1.message.onNext("Tý E")
subject2.onNext(C2)
C2.message.onNext("Tèo 1")
C2.message.onNext("Tèo 2")
print("------------------")


let bag6 = DisposeBag()
let C3 = User(message: BehaviorSubject(value: "C3 chào bạn"))
let C4 = User(message: BehaviorSubject(value: "C4 chào bạn"))
let subject3 = PublishSubject<User>()
let roomChat2 = subject3
    .flatMapLatest{ $0.message.materialize() }
roomChat2.filter{
    guard $0.error == nil else {
        print("Lỗi phát sinh: \($0.error!)")
        return false
    }
    return true
}.dematerialize()
.subscribe(onNext: { msg in
    print(msg)
}).disposed(by: bag6)
subject3.onNext(C3)
C3.message.onNext("Tý A")
C3.message.onNext("Tý B")
C3.message.onNext("Tý C")

C3.message.onError(MyError.anError)
C3.message.onNext("Tý D")
C3.message.onNext("Tý E")
subject3.onNext(C4)
C4.message.onNext("Tèo 1")
C4.message.onNext("Tèo 2")
