//: [Previous](@previous)

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
            var thisAmount = 0.0

            //determine amounts for each line
            switch each.movie.priceCode {
            case Movie.REGULAR:
                thisAmount += 2
                if each.daysRented > 2 {
                    thisAmount += (each.daysRented - 2) * 1.5
                }
            case Movie.NEW_RELEASE:
                thisAmount += each.daysRented * 3
            case Movie.CHILDRENS:
                thisAmount += 1.5
                if each.daysRented > 3 {
                    thisAmount += (each.daysRented - 3) * 1.5
                }
            default:
                break
            }

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

//: [Next](@next)
