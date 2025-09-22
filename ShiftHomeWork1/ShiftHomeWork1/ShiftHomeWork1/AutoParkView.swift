//
//  AutoParkViewController.swift
//  ShiftHomeWork1
//
//  Created by Арсений on 19.09.2025.
//

import Foundation

class AutoParkView {
    
    private let viewModel = AutoParkViewModel()
    
    init() {
        viewModel.onCarsUpdated = { [weak self] cars in
            self?.viewModel.printCars(cars: cars)
        }
    }
    
    func start() {
        while true {
            printMenu()
            guard let input = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines),
                  let menu = Menu(rawValue: input) else {
                print("Неизвестная команда, попробуйте снова.")
                continue
            }
            switch menu {
            case .addCar:
                addCarFlow()
            case .printCars:
                let cars = viewModel.getCars()
                viewModel.printCars(cars: cars)
            case .selectBodyTypesAndPrintFilteredCars:
                selectBodyTypeAndPrintFilteredCars()
            case .exit:
                print("Выход из программы.")
                return
            }
        }
    }
    
    enum Menu: String, CaseIterable, CustomStringConvertible {
        case addCar = "1"
        case printCars = "2"
        case selectBodyTypesAndPrintFilteredCars = "3"
        case exit = "0"
        
        var description: String {
            switch self {
            case .addCar:
                return "\(rawValue) - Добавить автомобиль"
            case .printCars:
                return "\(rawValue) - Просмотреть автомобили"
            case .selectBodyTypesAndPrintFilteredCars:
                return "\(rawValue) - Найти автомобили с выбранным кузовом"
            case .exit:
                return "\(rawValue) - Выход"
            }
        }
    }
}



private extension AutoParkView {
    
    func printMenu() {
        print("Выберите действие: ")
        Menu.allCases.forEach {
            print($0.description)
        }
        print("Ввод:", terminator: " ")
    }
    
    func addManufacterer() -> String {
        print("Введите производителя:")
        guard let manufacturer = readLine(), !manufacturer.isEmpty else {
            print("Производитель не может быть пустым")
            return addManufacterer()
        }
        return manufacturer
    }
    
    func addModel() -> String {
        print("Введите модель:")
        guard let model = readLine(), !model.isEmpty else {
            print("Модель не может быть пустой")
            return addModel()
        }
        return model
    }
    
    func addYearOfIssue() -> Int? {
        print("Введите год выпуска (число) или нажмите Enter, чтобы пропустить:")
        let yearInput = readLine()
        var yearOfIssue: Int? = nil
        if let yearStr = yearInput, !yearStr.isEmpty {
            if let year = Int(yearStr) {
                yearOfIssue = year
            } else {
                print("Год выпуска введён некорректно, будет пропущен")
            }
        }
        return yearOfIssue ?? nil
    }
    
    func addCarNumber() -> String? {
        print("Введите номер автомобиля или нажмите Enter, чтобы пропустить:")
        let carNumber = readLine()
        return carNumber ?? nil
    }
    
    func addCarFlow() {
        viewModel.addCar(manufacturer: addManufacterer(),
                         model: addModel(),
                         body: viewModel.addBody(),
                         yearOfIssue: addYearOfIssue(),
                         carNumber: addCarNumber())
        
        print("Автомобиль добавлен успешно!")
    }
    
    func selectBodyTypeAndPrintFilteredCars() {
        print("Выберите тип кузова:")
        viewModel.printBody()
        print("Ввод: ", terminator: "")
        
        
        
        guard let input = readLine(),
              let choiceInt = Int(input),
              let selectedBody = EnumBody(rawValue: choiceInt) else {
            print("Некорректный ввод, попробуйте снова.")
            return
        }
        
        print(input)
        
        viewModel.printCarsFiltered(byBody: selectedBody)
    }
}
