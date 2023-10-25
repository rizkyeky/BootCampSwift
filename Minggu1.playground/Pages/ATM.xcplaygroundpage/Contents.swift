
class ATMMachine {
//    let deposit = Deposit()
//    let withdraw = Withdraw()
}

extension ATMMachine {
    func checkBalance() {
        print("Your current balance is \(Deposit.nilai)")
    }
    func withdrawMoney(input inputString: String) {
        if let _input = Int(inputString) {
            Withdraw.nilai = Double(_input)
        }
        else {
            print("Input Error, Input Should be Interger")
            return
        }
        
        if (Deposit.nilai == 0) {
            print("Your current balance is zero.")
            print("You cannot withdraw!")
            print("You need to deposit money first.")
        }
        else if(withdraw.nilai > deposit.nilai) {
            print("The amount you withdraw is greater than to your deposit");
            print("\tPlease check the amount you entered.");
        }
        else {
            deposit.nilai -= withdraw.nilai
            print("You withdraw the amount of Rp\(withdraw.nilai)")
        }
    }
    func depositMoney(input inputString: String) {
        guard let _input = Int(inputString) else {
            print("Input Error, Input Should be Interger")
            return
        }
        deposit.nilai = Double(_input)
        print("You deposited the amount of \(deposit.nilai)")
    }
    
    func run() -> Void {
        let select: Int = 1
        // var choice: Int = 0
        
        print("====================================================")
        print("Welcome to this simple ATM machine")
        print("====================================================")
        print()
        
        var a = readLine() ?? "?"
        
        switch (select) {
            case 1:
                print("Enter the amount of money to deposit: ")
                var _input = readLine() ?? "0"
                depositMoney(input: _input)
                break
            case 2:
                print("To withdraw, make sure that you have sufficient balance in your account.")
                withdrawMoney(input: "1000")
                break
            case 3:
                checkBalance()
                break
            default:
                print("Transaction exited.")
                break
        }
    }
}

class Deposit {
    
    static let shared = Deposit()
        
    private init() {}
    
    private var _nilai: Double = 0
    
    var nilai: Double {
        set(val) {
            _nilai = val > 0 ? val : 0
        }
        get {
            return _nilai * 100
        }
    }
    
}

class Withdraw {
    
    static let shared = Withdraw()
        
    private init() {}
    
    private var _nilai: Double = 0
    
    var nilai: Double {
        set(val) {
            _nilai = val > 0 ? val : 0
        }
        get {
            return _nilai * 100
        }
    }
}

//class BalanceInquiry {
//
//    private var _nilai: Double = 0
//
//    var nilai: Double {
//        set(val) {
//            _nilai = val > 0 ? val : 0
//        }
//        get {
//            return _nilai * 100
//        }
//    }
//}

let atm = ATMMachine()
atm.run()
