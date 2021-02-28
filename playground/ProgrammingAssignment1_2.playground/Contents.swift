
import Foundation

// Частина 1

// Дано рядок у форматі "Student1 - Group1; Student2 - Group2; ..."

let studentsStr = "Дмитренко Олександр - ІП-84; Матвійчук Андрій - ІВ-83; Лесик Сергій - ІО-82; Ткаченко Ярослав - ІВ-83; Аверкова Анастасія - ІО-83; Соловйов Даніїл - ІО-83; Рахуба Вероніка - ІО-81; Кочерук Давид - ІВ-83; Лихацька Юлія - ІВ-82; Головенець Руслан - ІВ-83; Ющенко Андрій - ІО-82; Мінченко Володимир - ІП-83; Мартинюк Назар - ІО-82; Базова Лідія - ІВ-81; Снігурець Олег - ІВ-81; Роман Олександр - ІО-82; Дудка Максим - ІО-81; Кулініч Віталій - ІВ-81; Жуков Михайло - ІП-83; Грабко Михайло - ІВ-81; Іванов Володимир - ІО-81; Востриков Нікіта - ІО-82; Бондаренко Максим - ІВ-83; Скрипченко Володимир - ІВ-82; Кобук Назар - ІО-81; Дровнін Павло - ІВ-83; Тарасенко Юлія - ІО-82; Дрозд Світлана - ІВ-81; Фещенко Кирил - ІО-82; Крамар Віктор - ІО-83; Іванов Дмитро - ІВ-82"

// Завдання 1
// Заповніть словник, де:
// - ключ – назва групи
// - значення – відсортований масив студентів, які відносяться до відповідної групи
//let studentsStr = "Дмитренко Олександр - ІП-84; Матвійчук Андрій - ІВ-83; МатвійчукАнд - ІВ-83"
var studentsGroups: [String: [String]] = [:]

// Ваш код починається тут
let studentsArray = studentsStr.components(separatedBy: "; ")
var studentWithGroup = studentsArray.map{ $0.components(separatedBy: " - ") }.map{ (nameOfStudent: $0[0], groupNumber: $0[1]) }

for (name, group) in studentWithGroup {
    if var groups = studentsGroups[group] {
        groups.append(name)
        studentsGroups[group] = groups
    } else {
        studentsGroups[group] = [name]
    }
}
// Ваш код закінчується тут

print("Завдання 1")
print(studentsGroups)
print()

// Дано масив з максимально можливими оцінками

let points: [Int] = [12, 12, 12, 12, 12, 12, 12, 16]

// Завдання 2
// Заповніть словник, де:
// - ключ – назва групи
// - значення – словник, де:
//   - ключ – студент, який відносяться до відповідної групи
//   - значення – масив з оцінками студента (заповніть масив випадковими значеннями, використовуючи функцію `randomValue(maxValue: Int) -> Int`)

func randomValue(maxValue: Int) -> Int {
    switch(arc4random_uniform(6)) {
    case 1:
        return Int(ceil(Float(maxValue) * 0.7))
    case 2:
        return Int(ceil(Float(maxValue) * 0.9))
    case 3, 4, 5:
        return maxValue
    default:
        return 0
    }
}

var studentPoints: [String: [String: [Int]]] = [:]

// Ваш код починається тут
studentsGroups.forEach{ groups in
    var studentWithPoints: [String: [Int]] = [:]
    groups.value.forEach{ student in
        studentWithPoints[student] = points.map{ randomValue(maxValue: $0) }
    }
    studentPoints[groups.key] = studentWithPoints
}
// Ваш код закінчується тут

print("Завдання 2")
print(studentPoints)
print()

// Завдання 3
// Заповніть словник, де:
// - ключ – назва групи
// - значення – словник, де:
//   - ключ – студент, який відносяться до відповідної групи
//   - значення – сума оцінок студента

var sumPoints: [String: [String: Int]] = [:]

// Ваш код починається тут
studentPoints.forEach{ group, students in
    var studentWithSumPoints: [String: Int] = [:]
    students.forEach{ student, points in
        studentWithSumPoints[student] = points.reduce(0, +)
    }
    sumPoints[group] = studentWithSumPoints
}
// Ваш код закінчується тут

print("Завдання 3")
print(sumPoints)
print()

// Завдання 4
// Заповніть словник, де:
// - ключ – назва групи
// - значення – середня оцінка всіх студентів групи

// Ваш код починається тут
var groupAvg: [String: Float] = [:]
sumPoints.forEach{ groups in
    let sumOfPointsPerGroup = groups.value.values.reduce(0, +)
    let totalNumberOfStudentsInGroup = groups.value.values.count
    groupAvg[groups.key] = Float(sumOfPointsPerGroup)/Float(totalNumberOfStudentsInGroup)
}
// Ваш код закінчується тут

print("Завдання 4")
print(groupAvg)
print()

// Завдання 5
// Заповніть словник, де:
// - ключ – назва групи
// - значення – масив студентів, які мають >= 60 балів

var passedPerGroup: [String: [String]] = [:]

// Ваш код починається тут
let deadPoint: Int = 60
sumPoints.forEach{ group, students in
    var studentPassed: [String] = []
    students.forEach{ student, point in
        if point >= deadPoint {
            studentPassed.append(student)
        }
    }
    passedPerGroup[group] = studentPassed
}
// Ваш код закінчується тут

print("Завдання 5")
print(passedPerGroup)

// Приклад виведення. Ваш результат буде відрізнятися від прикладу через використання функції random для заповнення масиву оцінок та через інші вхідні дані.
//
//Завдання 1
//["ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"]]
//
//Завдання 2
//["ІВ-73": ["Давиденко Костянтин": [5, 8, 9, 12, 11, 12, 0, 0, 14], "Капінус Артем": [5, 8, 12, 12, 0, 12, 12, 12, 11], "Науменко Павло": [4, 8, 0, 12, 12, 11, 12, 12, 15], "Чередніченко Владислав": [5, 8, 12, 12, 11, 12, 12, 12, 15], "Гончар Юрій": [5, 6, 0, 12, 0, 11, 12, 11, 14]], "ІВ-71": ["Корнійчук Ольга": [0, 0, 12, 9, 11, 11, 9, 12, 15], "Музика Олександр": [5, 8, 12, 0, 11, 12, 0, 9, 15], "Гуменюк Олександр": [5, 8, 12, 9, 12, 12, 11, 12, 15], "Трудов Антон": [5, 0, 0, 11, 11, 0, 12, 12, 15], "Андрющенко Данило": [5, 6, 0, 12, 12, 12, 0, 9, 15], "Феофанов Іван": [5, 8, 12, 9, 12, 9, 11, 12, 14]], "ІВ-72": ["Киба Олег": [5, 8, 12, 12, 11, 12, 0, 0, 11], "Овчарова Юстіна": [5, 8, 12, 0, 11, 12, 12, 12, 15], "Бортнік Василь": [4, 8, 12, 12, 0, 12, 9, 12, 15], "Тимко Андрій": [0, 8, 11, 0, 12, 12, 9, 12, 15]]]
//
//Завдання 3
//["ІВ-72": ["Бортнік Василь": 84, "Тимко Андрій": 79, "Овчарова Юстіна": 87, "Киба Олег": 71], "ІВ-73": ["Капінус Артем": 84, "Науменко Павло": 86, "Чередніченко Владислав": 99, "Гончар Юрій": 71, "Давиденко Костянтин": 71], "ІВ-71": ["Корнійчук Ольга": 79, "Трудов Антон": 66, "Андрющенко Данило": 71, "Гуменюк Олександр": 96, "Феофанов Іван": 92, "Музика Олександр": 72]]
//
//Завдання 4
//["ІВ-71": 79.333336, "ІВ-72": 80.25, "ІВ-73": 82.2]
//
//Завдання 5
//["ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-73": ["Давиденко Костянтин", "Капінус Артем", "Чередніченко Владислав", "Гончар Юрій", "Науменко Павло"], "ІВ-71": ["Музика Олександр", "Трудов Антон", "Гуменюк Олександр", "Феофанов Іван", "Андрющенко Данило", "Корнійчук Ольга"]]

class CoordinateIS {
    
    enum Direction {
        case latitude
        case longtitude
    }
    
    enum CompassDirection: String {
        case north = "N"
        case south = "S"
        case west = "W"
        case east = "E"
    }
    
    let degrees: Int
    let minutes: UInt
    let seconds: UInt
    let direction: Direction
    
    init(degrees: Int = 0, minutes: UInt = 0, seconds: UInt = 0, direction: Direction = .latitude) {
        
        self.direction = direction
        self.minutes = (0...59).contains(minutes) ? minutes : 0
        self.seconds = (0...59).contains(seconds) ? seconds : 0
        
        switch (degrees, direction) {
        case (-90...90, .latitude) :
            self.degrees = degrees
        case (-180...180, .longtitude) :
            self.degrees = degrees
        default:
            self.degrees = 0
        }
    }
    
    var compassDirection: CompassDirection {
        switch (direction, degrees) {
        case (.latitude, 0...):
            return .north
        case (.latitude, ..<0):
            return .south
        case (.longtitude, 0...):
            return .west
        case (.longtitude, ..<0):
            return .east
        default:
            return .north
        }
    }
    
    func getCoordinate() -> String {
        return "\(abs(degrees))°\(minutes)′\(seconds)″ \(compassDirection.rawValue)"
    }
    
    func getCoordinateDecimal() -> String {
        return "\(Float(abs(degrees)) + Float(minutes) / 60 + Float(seconds) / 3600)° \(compassDirection.rawValue)"
        
    }
    
    func getMiddleCoordinate(coordinate: CoordinateIS) -> CoordinateIS? {
        guard coordinate.direction == self.direction else {
            return nil
        }
        return CoordinateIS(
            degrees: Int((self.degrees + coordinate.degrees) / 2),
            minutes: UInt((self.minutes + coordinate.minutes) / 2),
            seconds: UInt((self.seconds + coordinate.seconds) / 2),
            direction: self.direction
        )
    }
    
    class func getMiddleCoordinatesOfTwoCoordinates(coordinateOne: CoordinateIS, coordinateTwo: CoordinateIS) -> CoordinateIS? {
        guard coordinateOne.direction == coordinateTwo.direction else {
            return nil
        }
        return CoordinateIS(
            degrees: Int((coordinateOne.degrees + coordinateTwo.degrees) / 2),
            minutes: UInt((coordinateOne.minutes + coordinateTwo.minutes) / 2),
            seconds: UInt((coordinateOne.seconds + coordinateTwo.seconds) / 2),
            direction: coordinateOne.direction
        )
    }
}

//50°28′19″ пн. ш. 30°23′46″ сх. д. (Нивки)
let latitudeZero = CoordinateIS()
let longitudeZero = CoordinateIS()

print()
print("Latitude of 0 coordinate \(latitudeZero.getCoordinate())")
print("Longitude of 0 coordinate \(longitudeZero.getCoordinate())")
print()

print("Latitude of 0 coordinate decimal \(latitudeZero.getCoordinateDecimal())")
print("Longitude of 0 coordinate decimal \(longitudeZero.getCoordinateDecimal())")
print()

let latitude = CoordinateIS(degrees: 50, minutes: 28, seconds: 19, direction: .latitude)
let longitude = CoordinateIS(degrees: -30, minutes: 23, seconds: 46, direction: .longtitude)

print("50°28′19″ пн. ш. coordinate: \(latitude.getCoordinate())")
print("30°23′46″ сх. д. coordinate: \(longitude.getCoordinate())")
print()

print("50°28′19″ пн. ш. coordinate of decimal: \(latitude.getCoordinateDecimal())")
print("30°23′46″ сх. д. coordinate of decimal: \(longitude.getCoordinateDecimal())")
print()

print("Get middle coordinate between 50°28′19″ пн. ш. and 0: \(latitude.getMiddleCoordinate(coordinate: latitudeZero)?.getCoordinate() ?? "")")
print("Get middle coordinate between 30°23′46″ сх. д. and 0: \(longitude.getMiddleCoordinate(coordinate: longitudeZero)?.getCoordinate() ?? "")")
print()

//50°28′17″ пн. ш. 30°25′22″ сх. д. (Нивки)
let latitude1 = CoordinateIS(degrees: 50, minutes: 28, seconds: 17, direction: .latitude)
let longitude1 = CoordinateIS(degrees: -30, minutes: 25, seconds: 22, direction: .longtitude)

let middleCoordinateLatitude = CoordinateIS.getMiddleCoordinatesOfTwoCoordinates(coordinateOne: latitude, coordinateTwo: latitude1)?.getCoordinate()
let middleCoordinateLongitude = CoordinateIS.getMiddleCoordinatesOfTwoCoordinates(coordinateOne: longitude, coordinateTwo: longitude1)?.getCoordinate()

print("Get middle coordinate between 50°28′19″ пн. ш. and 50°28′17″ пн. ш.: \(middleCoordinateLatitude ?? "")")
print("Get middle coordinate between 30°23′46″ сх. д. and 30°25′22″ сх. д.: \(middleCoordinateLongitude ?? "")")
print()

let middleCoordinateBetweenLongitudeAndLatitude = CoordinateIS.getMiddleCoordinatesOfTwoCoordinates(coordinateOne: longitude, coordinateTwo: latitude1)?.getCoordinate()

print("Get middle coordinate between 30°23′46″ сх. д. and 50°28′17″ пн. ш.: \(middleCoordinateBetweenLongitudeAndLatitude ?? "")")
