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
        temp += "+"
    }
    return temp
}

func doLoop(num: Int) -> String {
    print("func4")
    var temp = ""
    for i in 0...10 {
        temp += "-"
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

