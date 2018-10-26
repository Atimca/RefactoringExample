//: [Previous](@previous)

//: ## Temp with Query for totalAmount and frequentRentalPoints

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

    var frequentRenterPoints: Double {
        if (movie.priceCode == Movie.NEW_RELEASE) && (daysRented > 1) {
            return 2
        }

        return 1
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
        var result = "Rental Record for " + name + "\n"

        rentals.forEach { each in
            // show figures for this rental
            result += "\t" + each.movie.title + "\t" + "\(each.charge)" + "\n"
        }

        // add footer lines
        result += "Amount owed is \(totalCharge) \n"
        result += "You earned \(totalFrequentRenterPoints) frequent renter points"

        return result
    }

    private var totalCharge: Double {
        var result = 0.0
        rentals.forEach { each in
            result += each.charge
        }
        return result
    }

    private var totalFrequentRenterPoints: Double {
        var result = 0.0
        rentals.forEach { each in
            result += each.frequentRenterPoints
        }
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

    func testfrequentRenterPoints_Equals2_WhenRentedDaysMoreThan2AndPriceCodeIsNewRelease() {
        // Prepare
        let daysRentedMoreThan2 = 3.0
        let newReleasePriceCode = Movie.NEW_RELEASE
        let rental = Rental(movie: Movie(title: "Avengers",
                                         priceCode: newReleasePriceCode),
                            daysRented: daysRentedMoreThan2)
        // Run
        let frequentRenterPoints = rental.frequentRenterPoints
        // Test
        XCTAssertEqual(frequentRenterPoints, 2)
    }
}

RentalTests.defaultTestSuite.run()
//: New Statement

//: [Next](@next)
