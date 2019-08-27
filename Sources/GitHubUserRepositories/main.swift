import Foundation

var name: String?

repeat {
    print("Введите никнейм:", terminator:" ")
    name = readLine()
    if name == "" {
        print("Вы ничего не ввели")
    }
}
while name == ""

guard let userName = name else { exit(0) }
print(userName)
