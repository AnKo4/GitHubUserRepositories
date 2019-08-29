import Foundation
import Alamofire

var urlString = "https://api.github.com/users/"

// MARK: - Запрашиваем никнейм до тех пор? пока пользователь что-нибудь не введет
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

// MARK: - Получаем список репозиториев и выводим его на экран
func getUserRepositoriesList(url: String) {
    print("Запрашиваю список репозиториев...")
    request(url, method: .get).validate().responseJSON { response in
        // Проверяем что запрос выполнен успешно
        guard response.result.isSuccess else {
            print("Ошибка: \(response.result.error?.localizedDescription ?? "")")
            exit(0)
        }
        // Проверяем что получен именно список репозиториев, а не другие данные
        guard let reposList = response.result.value as? [[String: Any]] else {
            print("Получены неверные данные")
            exit(0)
        }
        // Выводим список репозиториев на экран
        print("Список получен:")
        for item in reposList {
            guard let reposName = item["name"] as? String else { exit(0) }
            print(" \(reposName)")
        }
        exit(0)
    }
}


let userName = readName()
urlString = urlString + userName + "/repos"
getUserRepositoriesList(url: urlString)

// Для того, чтобы программа не завершилась до получения ответа с сервера
RunLoop.current.run()
