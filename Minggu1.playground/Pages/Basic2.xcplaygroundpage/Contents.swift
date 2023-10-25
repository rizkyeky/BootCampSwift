import UIKit


func doLoop(_ num: Int) {
    print("func1")
    var temp = 0
    for i in 0...num {
        temp += i
    }
}

func doLoop_(_ num: Int) -> String {
    print("func2")
    var temp: String = ""
    for i in 0...num {
        temp += "+\(i)"
    }
    return temp
}

func doLoop(number num: Int) -> String {
    print("func3")
    var temp: String = ""
    for i in 0...num {
        temp += "+ \(i)"
    }
    return temp
}

func doLoop(num: Int) -> String {
    print("func4")
    var temp = ""
    for i in 0...10 {
        temp += "- \(i)"
    }
    return temp
}

func doLoop(numbers: Int...) -> (Int, Float, Double) {
    print("func5")
    var temp = 0
    for num in numbers {
        temp += num
    }
    return (temp, Float(temp)/2, Double(temp)/2.2)
}

func doLoop(num: Int, doNum: @escaping (Int) -> Int) -> (Int) -> Int {
    print("func6")
    return doNum
}

doLoop(2) // func1
var str: String = doLoop_(2) // func2
var str1: String = doLoop(number: 10) // func3
var str2: String = doLoop(num: 4) // func4
var tuple1: (Int, Float, Double) = doLoop(numbers: 1,1,1,1,1,1) // func5

let range2 = 5...
print(type(of:range2))

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
    
    func getFromString(_ dayString: String) -> Bool {
        for day in Days.allCases {
            return day.rawValue == dayString
        }
        return false
    }
}

func getDayFromString(_ dayString: String) -> Days? {
    for day in Days.allCases {
        if (day.rawValue == dayString) {
            return day
        }
    }
    return nil
}

var hari1: Days? = .Sunday
var hari2: Days? = getDayFromString("Minggu")

print(hari1 ?? "-")
print(hari2 ?? "-")

// closure 1
func doLoop(number_ num: Int, onLoop: (Int) -> Void) {
    print("closure1")
    for i in 0..<num {
        onLoop(i)
    }
}

// closure 2
func doLoop(number num: Int, onLoop: (Int) -> Int) {
    print("closure2")
    for i in 0..<num {
        var ii = onLoop(i)
    }
}

// closure 3
func doLoop(number num: Int, onLoop: (Int) -> Int, outLoop: () -> Void) {
    print("closure3")
    for i in 0..<num {
        var ii = onLoop(i)
    }
    outLoop()
}

// closure 4
func doLoop(_ num: inout Int, doMyNum: (inout Int) -> Void) -> Void {
    print("closure4")
    doMyNum(&num)
}

doLoop(number_: 1, onLoop: { i in
    var temp = 0
    temp += i
})

doLoop(number: 2, onLoop: { i in
    return 10+i
})

doLoop(number: 3, onLoop: { i in
    return 10+i
}, outLoop: {
    print("Done")
})

doLoop(number: 4, onLoop: { i in
    return 10+i
}) {
    print("Done1")
}

doLoop(number: 5) { i in
    return 10+i
} outLoop: {
    print("Done2")
}

var number = 100

doLoop(&number) {
    num in
    num += 50
}

print(number)

// Struct
struct MyStruct {
    var num: Int
    var numFloat: Float
    let numConst: Double
    var numsFloat: Array<Float>
    var numsDouble: Array<Double>
    var days: Array<Days>
    var doAllMyDay: (Days) -> String
    
    init(num: Int, numFloat: Float, numConst: Double, doAllMyDay: @escaping (Days) -> String) {
        self.num = num
        self.numFloat = numFloat
        self.numConst = numConst
        self.doAllMyDay = doAllMyDay
        
        self.numsFloat = [1.0, 1.1, 1.2, 1.3, 1.4, 1.5]
        self.numsDouble = [1.0, 1.1, 1.2, 1.3, 1.4, 1.5]
        self.days = [.Monday, .Tuesday, .Wednesday]
    }
    
    mutating func doPopArray() -> Float {
        return numsFloat.removeFirst()
    }
    
    mutating func doPushArray(val: Float) -> Void {
        numsFloat.append(val)
    }
    
    mutating func doSortArrayFloat() -> Void {
        numsFloat.sort() { a, b in
            return a > b
        }
    }
    
    mutating func doLoopArray(inLoop: (Float) -> Float) -> Void {
        for num in numsFloat {
            inLoop(num)
        }
    }
    
    mutating func doSortArrayDay() -> Void {
        days.sort() { a, b in
            return a.rawValue.startIndex > b.rawValue.startIndex
        }
    }
    
    func doLoopMyDays() -> Void {
        for day in days {
            var cek = doAllMyDay(day)
        }
    }
}

protocol Mother {
    func loveTheirChildren() -> Void
    func kind() -> String
}

// Class
class MyMotherClass: Mother {
    
    func loveTheirChildren() {}
    
    func kind() -> String {
        return "100"
    }
    
    var num1: Int
    var num2: Int
    
    init(num1: Int, num2: Int) {
        self.num1 = num1
        self.num2 = num2
    }
}

class MyClass: MyMotherClass {
    var num: Int
    var numFloat: Float
    let numConst: Double = 19.9
    var numsFloat: Array<Float>
    var numsDouble: Array<Double>
    var days: Array<Days>
    var doAllMyDay: (Days) -> String
    var str: String {
        return ""
    }
    
    init(num: Int, numFloat: Float, numConst: Double, doAllMyDay: @escaping (Days) -> String) {
        
        self.num = num
        self.numFloat = numFloat
        self.doAllMyDay = doAllMyDay
        
        self.numsFloat = [1.0, 1.1, 1.2, 1.3, 1.4, 1.5]
        self.numsDouble = [1.0, 1.1, 1.2, 1.3, 1.4, 1.5]
        self.days = [.Monday, .Tuesday, .Wednesday]
        
        super.init(num1: 100, num2: 1200)
    }
    
    init(num: Int, numFloat: Float) {
        self.num = num
        self.numFloat = numFloat
        self.doAllMyDay = {
            day in
            return day.rawValue
        }
        
        self.numsFloat = [1.0, 1.1, 1.2, 1.3, 1.4, 1.5]
        self.numsDouble = [1.0, 1.1, 1.2, 1.3, 1.4, 1.5]
        self.days = [.Monday, .Tuesday, .Wednesday]
        
        super.init(num1: 100, num2: 1200)
    }
    
    convenience init(num: Int) {
        self.init(num: num, numFloat: 1.1, numConst: 1.1) {
            day in
            return day.rawValue
        }
        self.numFloat = 1.1
        self.num = num
        
        self.numsFloat = [1.0, 1.1, 1.2, 1.3, 1.4, 1.5]
        self.numsDouble = [1.0, 1.1, 1.2, 1.3, 1.4, 1.5]
        self.days = [.Monday, .Tuesday, .Wednesday]
    }
    
    override func kind() -> String {
        return "I love you mom"
    }
    
    func doPopArray() -> Float {
        return numsFloat.removeFirst()
    }
    
    func doPushArray(val: Float) -> Void {
        numsFloat.append(val)
    }
    
    func doSortArrayFloat() -> Void {
        numsFloat.sort() { a, b in
            return a > b
        }
    }
    func doLoopArray(inLoop: (Float) -> Float) -> Void {
        for num in numsFloat {
            inLoop(num)
        }
        for myMotherNum in 0..<self.num1 {
            inLoop(Float(myMotherNum))
        }
    }
    
    func doSortArrayDay() -> Void {
        days.sort() { a, b in
            return a.rawValue.startIndex > b.rawValue.startIndex
        }
    }
    
    func doLoopMyDays() -> Void {
        for day in days {
            var cek = doAllMyDay(day)
        }
    }
    
}

extension MyClass {
    func getDays() -> Days {
        return Days.Friday
    }
}

var struct1 = MyStruct(num: 10, numFloat: 1.1, numConst: 0.11) {
    day in
    return "100"
}

var struct2 = struct1
struct2.num = 50

print(struct1.num)

var class1 = MyClass(num: 10, numFloat: 1.1, numConst: 0.11) {
    day in
    return "100"
}

var class2 = class1
class2.num = 50

print(class1.num)

class2.doLoopArray() {
    fl in
    return fl + 1.5
}
