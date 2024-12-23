
class Book {
  int id;
  String title;
  bool borrowed;
  String borrowedBy;

  Book(
      {required this.title,
      this.id = 0,
      this.borrowed = false,
      this.borrowedBy = "not borrowed"});

  void displayInfo() {
    print("Book info:\nID: $id \nTitle: $title \nBorrowed: $borrowed\n");
  }
}

class User {
  int id;
  String name;
  List<Book> borrowedBooks;
  User(this.id, this.name, this.borrowedBooks);

  dynamic displayInfo() {
    print("User info: \nID: $id \nName:$name");
    return User(id, name, borrowedBooks);
  }
}

class Library {
  List<Book> bookList = [
    Book(title: "Harry Potter and the philosopher's stone", id: 1),
    Book(title: "A song of Ice and Fire", id: 2),
    Book(title: "The Catcher in the Rye", id: 3),
    Book(title: "The Hobbit", id: 4)
  ];
  List<User> usersList = [
    User(1, "Mostafa", []),
    User(2, "Omar", []),
    User(3, "Abdelrahman", []),
  ];

  void addUser(String name) {
    int id = usersList.length + 1;
    usersList.add(User(id, name, []));
    print("user $name added with id $id");
  }

  void addBook(String title, [bool borrowed = false]) {
    int id = bookList.length + 1;
    for (var book in bookList) {
      if (book.title == title) {
        print("${book.title} already exists and its ID is ${book.id}");
        return;
      }
    }
    bookList.add(Book(title: title, id: id));
    print('$title is added with id $id');
  }

  void borrowBook(int id, int userID) {
    var book = bookList[id - 1];
    var user = usersList[userID - 1];
    if (book.borrowed) {
      print('${book.title} is already borrowed by ${book.borrowedBy}');
    } else {
      book.borrowed = true;
      book.borrowedBy = user.name;
      user.borrowedBooks
          .add(Book(title: book.title, id: book.id, borrowed: book.borrowed));
      print('${book.title} was borrowed by ${book.borrowedBy}');
    }
  }

  void returnBook(int id, int userID, [int borrowedBookID = 1]) {
    var book = bookList[id - 1];
    var user = usersList[userID - 1];
    if (borrowedBookID < 1 || borrowedBookID > user.borrowedBooks.length) {
      print("this user has no borrowed books");
      return;
    }
    var borrowedBook = user.borrowedBooks[borrowedBookID - 1];

    if (!book.borrowed) {
      print("${book.title} is not borrowed by ${user.name}");
    } else if (borrowedBook.title != book.title) {
      print(
          "incorrect borrowed book id or ${book.title} isn't borrowed by ${user.name}");
    } else {
      user.borrowedBooks.remove(borrowedBook);
      book.borrowed = false;
      print("${book.title} is returned by ${book.borrowedBy}");
      book.borrowedBy = "not borrowed";
    }
  }

  void displayBooksInfo([int bookID = -1]) {
    if (bookID == -1) {
      for (var book in bookList) {
        print(
            "\nBook info:\nID: ${book.id} \nTitle: ${book.title} \nBorrowed: ${book.borrowed}\nBorrowed by: ${book.borrowedBy}");
      }
    } else {
      var book = bookList[bookID - 1];
      print(
          "\nBook info:\nID: ${book.id} \nTitle: ${book.title} \nBorrowed: ${book.borrowed}\nBorrowed by: ${book.borrowedBy}");
    }
  }

  void displayUsersInfo([int userID = -1]) {
    if (userID == -1) {
      for (var user in usersList) {
        print("\nUser info:\nID:${user.id}\nName:${user.name}\nborrowed books:");
        if (user.borrowedBooks.isEmpty) {
          print("no books borrowed");
        } else {
          for (var borrowedBook in user.borrowedBooks) {
            print("Title: ${borrowedBook.title}");
          }
        }
      }
    } else {
      var user = usersList[userID - 1];
      print("\nUser info:\nID:${user.id}\nName:${user.name}\nborrowed books:");
      if (user.borrowedBooks.isEmpty) {
        print("no books borrowed");
      } else {
        for (var borrowedBook in user.borrowedBooks) {
          print(borrowedBook.title);
        }
      }
    }
  }
}

main() {
  Library library =
      Library(); //this object contains the list of books and users
  library.addBook("A Game Of Thrones");
  library.addBook("A Game Of Thrones");

  library.addUser("Ahmed");

  library.borrowBook(1, 1);
  library.borrowBook(2, 1);
  library.borrowBook(3, 2);
  library.borrowBook(1, 3);

  library.displayUsersInfo(1);
  library.displayUsersInfo();

  library.displayBooksInfo(1);
  library.displayBooksInfo();

  print(" ");

  library.returnBook(2, 2);
  library.returnBook(4, 2);
  library.returnBook(4, 3, 2);
  library.returnBook(2, 1, 2);
  library.returnBook(3, 2);
}
