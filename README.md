# ApiManager.swift
A simple API caller to integrate in your project without external library

[![contact](https://img.shields.io/badge/Contact-@FrankSorro-blue.svg)](https://twitter.com/franksorro) ![platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)  ![license](https://img.shields.io/badge/License-MIT-darkgray.svg)

# Installation
```sh
Copy ApiManager.swift in your project
```

# Usage
```sh
class ToDo: Decodable {
    var id: Int
    var userId: Int
    var title: String
    var completed: Bool
}

var todos: [ToDo] = []

func fetchData() {
    ApiManager.shared.Request(with: "https://jsonplaceholder.typicode.com/todos", type: [ToDo].self) { (result) in
        switch result {
        case .success(let items):
            DispatchQueue.main.async {
                todos = items
            }
            
        case .failure(let error):
            print("API Error: \(error)")
        }
    }
}
```

## License
```sh
MIT License

Copyright (c) 2019 FRΛƝCƎƧCØ ƧØЯRƎƝTIƝØ

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```