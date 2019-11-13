import Foundation
import PlaygroundSupport

// For this homework project, we'll be connecting to the "TLDR" server
// to add a few books. The first thing you need to do is create an object
// that we'll upload to the server.

// MARK: - STEP ONE

// Implement a struct that defines a book. A book consists of the following
// items:
// A title, which is a string
// An author, which is a string
// The publication year, as a string (because dates are hard)
// A string for the URL for an image for the book cover
//
// Remember that this structure needs to conform to the `Encodable` protocol.
// Using `Codable` more generally will be useful, as by doing this you'll
// be able to reuse this struct in Project Three.

struct Book: Codable {
    let title: String
    let author: String
    let publicationYear: String
    let coverImageURL: String
}

// MARK: - STEP TWO

// Once you've defined this structure, you'll need to define a couple of
// book objects that you can insert into the database. In order or us to
// have an amusing dataset to work with, each student is requested to
// create five different books for this database.

let dorianBook = Book(title: "The Picture of Dorian Gray", author: "Oscar Wilde", publicationYear: "1890", coverImageURL: "https://images-na.ssl-images-amazon.com/images/I/518mU%2BLls5L.jpg")
let gilgameshBook = Book(title: "Epic of Gilgamesh", author: "Unknown", publicationYear: "c. 1800 BC", coverImageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Tablet_V_of_the_Epic_of_Gilgamesh.jpg/220px-Tablet_V_of_the_Epic_of_Gilgamesh.jpg")
let endersBook = Book(title: "Ender's Game", author: "Orson Scott Card", publicationYear: "1985", coverImageURL: "https://upload.wikimedia.org/wikipedia/en/e/e4/Ender%27s_game_cover_ISBN_0312932081.jpg")
let troopersBook = Book(title: "Starship Troopers", author: "Robert A. Heinlein", publicationYear: "1959", coverImageURL: "https://upload.wikimedia.org/wikipedia/en/a/a9/Starship_Troopers_%28novel%29.jpg")
let expectationsBook = Book(title: "Great Expectations", author: "Charles Dickens", publicationYear: "1861", coverImageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Greatexpectations_vol1.jpg/800px-Greatexpectations_vol1.jpg")

let bookList: [Book] = [dorianBook, gilgameshBook, endersBook, troopersBook, expectationsBook]

// MARK: - STEP THREE

// Now we need to publish this data to the server.

// Create a URL to connect to the server. Its address is:
//      https://uofd-tldrserver-develop.vapor.cloud/books

// Create a URL request to publish the information, based upon the URL you
// just created.

// Add the body to the URL request you just created, by using JSONEncoder.

// Add a "Content-Type" : "application/json" header to your request, so that
// the server will properly understand the body of your request.

// Set the method of the request to "POST", because we're providing information
// rather than retrieving it.

// Create a data task for publishing this element, and kick it off with a resume().

func requestBookPost(book: Book) {
    let tldrServerURL = URL(string: "https://uofd-tldrserver-develop.vapor.cloud/books")
    var request = URLRequest(url: tldrServerURL!)
    request.httpBody = try? JSONEncoder().encode(book)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    let task = URLSession(configuration: .ephemeral).dataTask(with: request)
    task.resume()
}

for book in bookList {
    requestBookPost(book: book)
    print("Finished \(book.title)")
}

// MARK: - HELPFUL HINTS
// You might want to create a method for publishing the data, so that you
// can effectively loop over an array of books.
//
// If you visit the URL for the service in a 'GET' request, it will return a
// list of books to you. We'll be using this list of books for Project Three.
