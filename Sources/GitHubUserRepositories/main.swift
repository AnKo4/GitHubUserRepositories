import Foundation
import Alamofire

var urlString = "https://api.github.com/users/"


func readName() -> String {
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
    return userName
}

func getUserRepositoriesList(url: String) {
    print("Запрашиваю список репозиториев...")
    request(url, method: .get).validate().responseJSON { response in
        guard response.result.isSuccess else {
            print("Ошибка: \(response.result.error?.localizedDescription ?? "")")
            exit(0)
        }
        guard let value = response.result.value as? [[String: Any]] else {
            print("Получены неверные данные")
            exit(0)
        }
        for item in value {
            guard let repoName = item["name"] as? String else { exit(0) }
            print(repoName)
        }
        exit(0)
    }
}


let userName = readName()
urlString = urlString + userName + "/repos"
getUserRepositoriesList(url: urlString)

RunLoop.current.run()




