
import Foundation
class UserLoginFileManager {
    func getFilePath() -> URL {
        let files = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = files[0].appendingPathComponent("usersLoginData.json")
        print(path)
        return path
    }
    
    func writeUserData(users: [User]) {
        do {
            let data = try JSONEncoder().encode(users)  // datamizi encode etdi json'a
            try data.write(to: getFilePath()) // bu URL'deki fayla encode etdiyimiz datani yaz
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readUserData(complete: (([User]) -> Void)) {
        if let data = try? Data(contentsOf: getFilePath()) {
            do {
                let items = try JSONDecoder().decode([User].self, from: data)
                complete(items)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
