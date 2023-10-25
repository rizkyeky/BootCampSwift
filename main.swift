
import Foundation

enum Days: String, CaseIterable {
    case Sunday = "Minggu"
    case Monday = "Senin"
    case Tuesday = "Selasa"
    case Wednesday = "Rabu"
    case Thursday = "Kamis"
    case Friday = "Jumat"
    case Saturday = "Sabtu"
    
    func description() -> String {
        switch self {
        case .Sunday, .Saturday:
            return "Libur"
        default:
            return "Kerja"
        }
    }
    
    func checkDayFromString(_ dayString: String) -> Bool {
        for day in Days.allCases {
            return day.rawValue == dayString
        }
        return false
    }
}


struct MyStruct<T>: Equatable {
    private var _numInt: Int
    private var _numFloat: Float
    private var _numDouble: Double

    var strChildren: [String] {
        var childs = ["child1", "child2", "child3"]
        childs.append("child4")
        return childs
    }

    var numInt: Int {
        get {
            return _numInt * 5
        }
        set(newValue) {
            _numInt = newValue * 9
        }
    }

    var numFloat: Float {
        get {
            return _numFloat * 5.1
        }
        set(newValue) {
            _numFloat = Float(newValue * 10)
        }
    }

    var numDouble: Double {
        get {
            return _numDouble * 10.2
        }
        set(newValue) {
            _numDouble = Double(newValue * 1.1)
        }
    }

    var onLoop: (T) -> Void

    var children: () -> [String] 

    init(numInt: Int, numFloat: Float, numDouble: Double, onLoop: @escaping (T) -> Void, children : @escaping () -> [String]) {
        self._numInt = numInt
        self._numFloat = numFloat
        self._numDouble = numDouble
        self.onLoop = onLoop
        self.children = children
    }

    func getAllNumProps() -> (Int, Float, Double) {
        return (self._numInt, self._numFloat, self._numDouble)
    }

    static func ==(lhs: MyStruct<T>, rhs: MyStruct<T>) -> Bool {
        return lhs.numInt == rhs.numInt
    }
}

var myStruct = MyStruct<Days>(numInt: 1, numFloat: 1.1, numDouble: 1.1) { day in
    print(day.description())
    print(day.checkDayFromString("Monday") ? "Ada" : "Tidak")
} children: {
    [
        "String1",
        "String2",
        "String3"
    ]
}

myStruct.onLoop(Days.Monday)
print(myStruct.children())
print(myStruct.strChildren)
print(myStruct.getAllNumProps())