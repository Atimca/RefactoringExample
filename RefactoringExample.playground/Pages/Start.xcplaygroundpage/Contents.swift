/*:
 ## Refacoring demo!

 Initial

 */

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
    let daysRented: Int

    init(movie: Movie, daysRented: Int) {
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
}
//: [Next](@next)
