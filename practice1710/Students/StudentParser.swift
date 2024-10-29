import Foundation

struct Address: Codable {
    let street: String
    let city: String
    let postalCode: String?
}

struct Student: Codable {
    let id: Int
    let name: String?
    let age: Int?
    var imageName: String?
    let subjects: [String]?
    let address: Address?
    let scores: [String: Int?]?
    let hasScholarship: Bool?
    let graduationYear: Int?
    
    var averageScore: Double? {
            guard let scores = scores else { return nil }
            let scoreValues = scores.values.compactMap { $0 }
            guard !scoreValues.isEmpty else { return nil }
            let totalScore = scoreValues.reduce(0, +)
            return Double(totalScore) / Double(scoreValues.count)
        }
}

struct StudentsWrapper: Codable {
    var students: [Student]
}

class Students {
    var list: [Student] = []
    private let imageNames = ["1", "2", "3", "4", "5"]
    
    init(filename: String) {
        loadData(from: filename)
    }
   
    private func loadData(from filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("Error: JSON file \(filename).\("json") not found in bundle.")
            return
        }
       
        do {
            // https://stackoverflow.com/questions/24410881/reading-in-a-json-file-using-swift
           
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
        
            var studentsWrapper = try decoder.decode(StudentsWrapper.self, from: data)
            
            for index in studentsWrapper.students.indices {
                            let randomImageName = imageNames.randomElement() ?? "defaultImage"
                            studentsWrapper.students[index].imageName = randomImageName
                        }
            self.list = studentsWrapper.students
            print("JSON data successfully loaded")
        } catch {
            print("Error loading or decoding JSON: \(error.localizedDescription)")
        }
    }
        
    func printAllStudents() {
        for student in list {
            printStudent(student: student)
        }
    }
    

    
    func printStudent(student: Student){
        print("ID: \(student.id)")
           
        if let name = student.name {
            print("Name: \(name)")
        } else {
            print("Name: nil")
        }
        
        
        if let age = student.age {
            print("Age: \(age)")
        } else {
            print("Age: nil")
        }
        
        
        if let subjects = student.subjects {
            print("Subjects: \(subjects.joined(separator: ", "))")
        } else {
            print("Subjects: nil")
        }
        
        
        if let address = student.address {
            print("Address:")
            print("  Street: \(address.street)")
            print("  City: \(address.city)")
            if let postalCode = address.postalCode {
                print("  Postal Code: \(postalCode)")
            } else {
                print("  Postal Code: nil")
            }
        } else {
            print("Address: nil")
        }
        
        if let scores = student.scores {
            print("Scores:")
            for (subject, score) in scores {
                if let scoreValue = score {
                    print("  \(subject): \(scoreValue)")
                } else {
                    print("  \(subject): nil")
                }
            }
        } else {
            print("Scores: nil")
        }
        
        
        if let hasScholarship = student.hasScholarship {
            print("Has Scholarship: \(hasScholarship)")
        } else {
            print("Has Scholarship: nil")
        }
        
        
        if let graduationYear = student.graduationYear {
            print("Graduation Year: \(graduationYear)")
        } else {
            print("Graduation Year: nil")
        }
        print("\n")
    }
    
    func checkScholarshipStatus(student: Student) -> Bool {
        return student.hasScholarship ?? false
    }

}
