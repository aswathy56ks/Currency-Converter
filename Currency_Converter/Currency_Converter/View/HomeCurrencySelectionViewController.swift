//
//  HomeCurrencySelectionViewController.swift
//  iOS_Test
//
//  Created by Aswathy Krishnan Sheela on 17/06/23.
//

import Foundation
import UIKit

class HomeCurrencySelectionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    private var viewModel: HomeCurrencySelectionViewModel
    private var selectedHomeCurrency: String?

    private let homeCurrencyDropdown = UIPickerView()
    private let convertButton = UIButton(type: .system)

    init(viewModel: HomeCurrencySelectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel.fetchCurrencyRates { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.homeCurrencyDropdown.reloadAllComponents()
                }
            case .failure(let error):
                print("Failed to fetch currency rates: \(error)")
            }
        }
    }

    private func setupUI() {
        // Configure home currency dropdown
        homeCurrencyDropdown.delegate = self
        homeCurrencyDropdown.dataSource = self

        // Position the home currency dropdown
        homeCurrencyDropdown.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(homeCurrencyDropdown)
        NSLayoutConstraint.activate([
            homeCurrencyDropdown.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeCurrencyDropdown.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        // Configure convert button
        convertButton.setTitle("Convert", for: .normal)
        convertButton.addTarget(self, action: #selector(convertButtonPressed), for: .touchUpInside)

        // Position the convert button
        convertButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(convertButton)
        NSLayoutConstraint.activate([
            convertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            convertButton.topAnchor.constraint(equalTo: homeCurrencyDropdown.bottomAnchor, constant: 20)
        ])
    }

    @objc func convertButtonPressed() {
        guard let homeCurrency = selectedHomeCurrency else {
            return
        }

     let conversionCurrency = homeCurrencyDropdown.selectedRow(inComponent: 0).description

        guard let conversionRate = viewModel.currencyRates[conversionCurrency] else {
            return
        }

        let amountToConvert = 1.0
        let convertedAmount = amountToConvert * conversionRate

        let resultString = "1 \(homeCurrency) = \(convertedAmount) \(conversionCurrency)"
        print(resultString)
    }

    // MARK: - UIPickerViewDelegate and UIPickerViewDataSource Methods

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return (viewModel.currencies.count > 1) ? 1 : 0
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.currencies.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.currencies[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedHomeCurrency = viewModel.currencies[row]
    }
}
