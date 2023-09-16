//
//  ViewController.swift
//  NiceSimplePicker
//
//  Created by Jisu Kim on 2023/09/16.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Properties
    private var animalSelectedData: AnimalExampleConfigs = .horse
    private var vehicleSelectedData: VehicleExampleConfigs = .boat
    @IBOutlet weak var animalSelectButton: UIButton!
    @IBOutlet weak var vehicleSelectButton: UIButton!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // init data
        self.setAnimalSelectedData(config: animalSelectedData)
        self.setVehicleSelectedData(config: vehicleSelectedData)
    }
    
    //MARK: - Methods
    @IBAction func didTappedAnimalButton(_ sender: Any) {
        let pickerView = NiceSimplePickerView()
        pickerView.delegate = self
        pickerView.dataSource = AnimalExampleConfigs.allCases
            .map({ $0.pickerConfig })
        pickerView.selectedData = self.animalSelectedData.pickerConfig
        pickerView.tintColor = .systemIndigo
        pickerView.contentInset = 25
        pickerView.tag = 0
        pickerView.headerText = "동물선택"
        self.present(pickerView, animated: true)
    }
    
    @IBAction func didTappedVehicleButton(_ sender: Any) {
        let pickerView = NiceSimplePickerView()
        pickerView.delegate = self
        pickerView.dataSource = VehicleExampleConfigs.allCases
            .map({ $0.pickerConfig })
        pickerView.selectedData = self.vehicleSelectedData.pickerConfig
        pickerView.tintColor = .systemBlue
        pickerView.contentInset = 10
        pickerView.tag = 1
        pickerView.headerText = "🚀뭐에 타실래요?"
        self.present(pickerView, animated: true)
    }
    
    private func setAnimalSelectedData(config: AnimalExampleConfigs) {
        self.animalSelectButton.setTitle(config.title, for: .normal)
        self.animalSelectedData = config
    }
    
    private func setVehicleSelectedData(config: VehicleExampleConfigs) {
        self.vehicleSelectButton.setTitle(config.title, for: .normal)
        self.vehicleSelectedData = config
    }
}

//MARK: - NiceSimplePickerDelegate
extension ViewController: NiceSimplePickerDelegate {
    func didTappedSelection(picker: NiceSimplePickerView, index: Int) {
        if picker.tag == 0 {
            setAnimalSelectedData(config: AnimalExampleConfigs.allCases[index])
        } else if picker.tag == 1 {
            setVehicleSelectedData(config: VehicleExampleConfigs.allCases[index])
        }
    }
}
