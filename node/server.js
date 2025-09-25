let express = require('express')

let app = express()

let port = 23456

class Album
{
    constructor(ID, Title, Artist, Price) {
        this.ID = ID
        this.Title = Title
        this.Artist = Artist
        this.Price = Price
    }
}

const albums = [
    new Album("1", "Blue Train", "John Coltrane", 56.99),
    new Album("2", "Jeru", "Gerry Mulligan", 17.99),
    new Album("3", "Sarah Vaughan and Clifford Brown", "Sarah Vaughan", 39.99),
];

app.get('/albums', function(req, res) {
    res.json(albums)
})

app.listen(port)