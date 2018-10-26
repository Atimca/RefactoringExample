//: [Previous](@previous)

//: ## Move Anount Calculation to Rental from Customer. Customer.amount(for:) -> Rental.charge()

class Movie {

    static var CHILDRENS = 2
    static var REGULAR = 0
    static var NEW_RELEASE = 1

    var title: String
    var priceCode: Int

    init(title: String, priceCode: Int) {
        self.title = title
        self.priceCode = priceCode
    }
}

class Rental {
    let movie: Movie
    let daysRented: Double

    init(movie: Movie, daysRented: Double) {
        self.movie = movie
        self.daysRented = daysRented
    }

    var charge: Double {
        var result = 0.0

        switch movie.priceCode {
        case Movie.REGULAR:
            result += 2
            if daysRented > 2 {
                result += (daysRented - 2) * 1.5
            }
        case Movie.NEW_RELEASE:
            result += daysRented * 3
        case Movie.CHILDRENS:
            result += 1.5
            if daysRented > 3 {
                result += (daysRented - 3) * 1.5
            }
        default:
            break
        }

        return result
    }
}

class Customer {
    let name: String
    private var rentals: [Rental] = []

    init(name: String, rentals: [Rental]) {
        self.name = name
        self.rentals = rentals
    }

    func add(rental: Rental) {
        rentals.append(rental)
    }

    func statement() -> String {
        var totalAmount = 0.0
        var frequentRenterPoints = 0.0
        var result = "Rental Record for " + name + "\n"

        rentals.forEach { each in
            let thisAmount = each.charge

            // add frequent renter points
            frequentRenterPoints += 1;
            // add bonus for a two day new release rental
            if (each.movie.priceCode == Movie.NEW_RELEASE) && (each.daysRented > 1) {
                frequentRenterPoints += 1;
            }

            // show figures for this rental
            result += "\t" + each.movie.title + "\t" + "\(thisAmount)" + "\n"
            totalAmount += thisAmount
        }

        // add footer lines
        result += "Amount owed is \(totalAmount) \n"
        result += "You earned \(frequentRenterPoints) frequent renter points"

        return result
    }
}

import XCTest

class CustomerTests: XCTestCase {

    let customer = Customer(name: "CustomerTestName", rentals: [Rental(movie: Movie(title: "Terminator 2",
                                                                                    priceCode: Movie.NEW_RELEASE),
                                                                       daysRented: 365)])
    func testStatementGeneration() {
        XCTAssertEqual("Rental Record for CustomerTestName\n\tTerminator 2\t1095.0\nAmount owed is 1095.0 \nYou earned 2.0 frequent renter points",
                       customer.statement())
    }
}

CustomerTests.defaultTestSuite.run()

class RentalTests: XCTestCase {

    let rental = Rental(movie: Movie(title: "Frozen",
                                     priceCode: Movie.CHILDRENS),
                        daysRented: 10)

    func testRentalCharge() {
        XCTAssertEqual(rental.charge, 12)
    }
}

RentalTests.defaultTestSuite.run()
//: thisAmount -> each.charge()

//: [Next](@next)
