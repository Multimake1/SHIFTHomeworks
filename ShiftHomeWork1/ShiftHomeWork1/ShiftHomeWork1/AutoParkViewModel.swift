//
//  AutoParkViewModel.swift
//  ShiftHomeWork1
//
//  Created by Арсений on 19.09.2025.
//

import Foundation

class AutoParkViewModel {
    private var cars: [AutoPark] = []
    
    var onCarsUpdated: (([AutoPark]) -> Void)?
    
    func addBody() -> EnumBody {
        print("Выберите тип кузова:")
        guard let bodyInput = readLine(),
              let bodyIndex = Int(bodyInput),
              let selectedBody = EnumBody(rawValue: bodyIndex) else {
            print("Некорректный ввод типа кузова")
            return addBody()
        }
        return selectedBody
    }
    
    func addCar(manufacturer: String, model: String, body: EnumBody, yearOfIssue: Int?, carNumber: String?) {
        let newCar = AutoPark(manufacturer: manufacturer,
                              model: model,
                              body: body,
                              yearOfIssue: yearOfIssue,
                              carNumber: carNumber)
        cars.append(newCar)
        
        onCarsUpdated?(cars)
    }
    
    func getCars() -> [AutoPark] {
        return cars
    }
    
    func printCars(cars: [AutoPark]) {
        if cars.isEmpty {
            print("Список автомобилей пуст.")
            return
        }
        
        for (index, car) in cars.enumerated() {
            print("Автомобиль \(index + 1):")
            print("  Производитель: \(car.manufacturer)")
            print("  Модель: \(car.model)")
            print("  Кузов: \(car.body.description)")
            if let year = car.yearOfIssue {
                print("  Год выпуска: \(year)")
            } else {
                print("  Год выпуска: --")
            }
            if let number = car.carNumber, !number.isEmpty {
                print("  Номер: \(number)")
            } else {
                print()
            }
            print("--------------------------")
        }
        print()
    }
    
    func printCarsFiltered(byBody bodyType: EnumBody) {
        let filteredCars = cars.filter { $0.body == bodyType }
        print(bodyType)
        
        if filteredCars.isEmpty {
            print("Автомобили с кузовом \(bodyType.description) не найдены.")
        } else {
            print("Список автомобилей с кузовом \(bodyType.description):")
            for car in filteredCars {
                print("  Производитель: \(car.manufacturer)")
                print("  Модель: \(car.model)")
                if let year = car.yearOfIssue {
                    print("  Год выпуска: \(year)")
                } else {
                    print("  Год выпуска: --")
                }
                if let number = car.carNumber, !number.isEmpty {
                    print("  Номер: \(number)")
                } else {
                    print()
                }
            }
        }
    }
    
    func printBody() {
        EnumBody.allCases.forEach {
            print($0.description)
        }
    }
    
}

struct AutoPark {
    let manufacturer: String
    let model: String
    let body: EnumBody
    let yearOfIssue: Int?
    let carNumber: String?
}

enum EnumBody: Int, CaseIterable, CustomStringConvertible {
    case hatchback = 1
    case sedan = 2
    case coupe = 3
    
    var description: String {
        switch self {
        case .hatchback:
            return "\(rawValue) - Хэтчбэк"
        case .sedan:
            return "\(rawValue) - Седан"
        case .coupe:
            return "\(rawValue) - Купе"
        }
    }
}
