//
//  ViewController.swift
//  Monkeys UIPicker
//
//  Created by Andrey Sushkov on 22.06.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableMonkeys: UITableView!
    
    @IBOutlet weak var selectedMonkeyTextField: UITextField!
    var monkeysList: [String] = []
    let picker = UIPickerView()
    
    func toolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()                         // подгоняет под размеры экрана
        let done = UIBarButtonItem(title: "Done",  // создаем кнопку в тулбаре
                                   style: .done,
                                   target: self, // у кого вызывать метод
                                   action: #selector(selectItem)) // какой метод вызывать
        toolbar.setItems([done], animated: false)  // добавление кнопки Done на тулбар
        return toolbar
    }
    
    @objc func selectItem() {
        selectedMonkeyTextField.text =  "\(picker.selectedRow(inComponent: 0) + 1) " + monkeysList[picker.selectedRow(inComponent: 1)] // текст в текстфилде
        selectedMonkeyTextField.resignFirstResponder()  // убирает фокус с активных элементов(тут - текстфилд)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        monkeysList = Parser.parseNamesFromJSON()?.list ?? []
        picker.delegate = self // для обработки событий
        picker.dataSource = self  // для обработки данных
        
        selectedMonkeyTextField.inputView = picker
        selectedMonkeyTextField.inputAccessoryView = toolbar()
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {  // кол-во колонок в пикере
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 10
        case 1:
            return monkeysList.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {  // текст того, что может быть выбрано
        case 0:
            return "\(row + 1)"
        case 1:
            return monkeysList[row]
        default:
            return ""
        }
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monkeysList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellName = monkeysList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "monkeys") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = cellName
        return cell
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

    }
}
