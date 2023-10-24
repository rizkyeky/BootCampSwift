import UIKit


func doLoop(_ num: Int) {
    print("func1")
    var temp = 0
    for i in 0...num {
        temp += i
    }
}

//func doLoop(_ num: Int) -> String {
//    print("func2")
//    var temp: String = ""
//    for i in 0...num {
//        temp += "+"
//    }
//    return temp
//}

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

doLoop(2) // func1
//var str: String = doLoop(2) // func2
var str1: String = doLoop(number: 10) // func3
var str2: String = doLoop(num: 4) // func4
var tuple1: (Int, Float, Double) = doLoop(numbers: 1,1,1,1,1,1) // func5

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
func doLoop(number num: Int, onLoop: (Int) -> Void) {
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

doLoop(number: 1, onLoop: { i in
    print("++ \(i)")
})

doLoop(number: 2, onLoop: { i in
    print("++ \(i)")
    return 10+i
})

doLoop(number: 3, onLoop: { i in
    print("++ \(i)")
    return 10+i
}, outLoop: {
    print("Done")
})

doLoop(number: 4, onLoop: { i in
    print("++ \(i)")
    return 10+i
}) {
    print("Done1")
}

doLoop(number: 5) { i in
    print("++ \(i)")
    return 10+i
} outLoop: {
    print("Done2")
}
