//import UIKit
import Foundation
//import CoreML
//import ARKit
//import Vision
//import CoreData
//import CoreNFC
//import CoreBluetooth

var greeting = "Hello, playground"

var str: String = String()

let greet = "Hello"

let num = 10.0
let num1: Double = 1

let num2: Float = 2.0

var num3: Float?

var str1, str2, str3, str4: String?

print("\(greeting)")

print("\(num3 ?? 0)")

typealias Kata = String

var tupl: (Kata, Int, Bool) = ("asda", 1010, true)

print("\(tupl.0)-\(tupl.1)-\(tupl.2)")

var list: [String?] = ["Float", "Int", "--", nil, nil]
var list2: [Any?] = ["Float", 3.0, ("Int", 2.0), nil, nil]

let num4: String = "-0"

//print("cek: \(Int(num4))")

if let possibleNumber = Int("0101") {
    print(" \(possibleNumber)")
} else {
    print("Error")
}

if let possibleNumber1 = Int("0101"), false == true, 123 == tupl.1, var sar = list[0] {
    print(" \(possibleNumber1) - \(sar)")
} else {
    print("Error")
}

var kata: Kata? = list[1]

if (kata != nil) {
    print("")
}

guard var num4 = Int(num4) else {
    fatalError("The number was invalid")
}
print(num4)

var any: Any = "app"
any = 10
any = true

enum Days: String, CaseIterable {
    case Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
    
    func description() -> String {
        switch self {
        case .Sunday, .Saturday:
            return "Libur"
        default:
            return "Kerja"
        }
    }
}

var namaHari: Days = Days.Friday

for day in Days.allCases {
    print(day)
    print(day.description())
}

if (namaHari == .Friday) {
    print("Friday")
} else {
    print("Not Friday")
}

switch (namaHari) {
case .Monday:
    print("Hari Senin")
case .Tuesday:
    print("Hari Selasa")
case .Wednesday:
    print("Hari Rabu")
case .Thursday:
    print("Hari Kamis")
case .Friday:
    print("Hari Jumat")
case .Saturday:
    print("Hari Sabtu")
case .Sunday:
    print("Hari Minggu")
}

enum Laptop {
  case name(String)
  case price(Int)
}

var laptopName: Laptop = Laptop.name("Razer")
var laptopPrice: Laptop = Laptop.price(9999)

//for  i in 0..10 {
//    print(i)
//}

for  i in 0...10 {
    print(i)
}

for  i in 0..<10 {
    print(i)
}

//for  i in 0...<10 {
//    print(i)
//}

let names: [String] = ["ss", "aa", "bb", "cc", "dd", "ee"]
for  i in 0..<names.count {
    print(i)
}

for name in names {
    print(name)
}

for name in names[...2] {
    print(name)
}

for name in names[2...] {
    print(name)
}





