import UIKit
import Foundation

final class ConverterViewController: UIViewController {
    @IBOutlet weak var outputDisplay: UITextField!
    @IBOutlet weak var inputDisplay: UITextField!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var positiveNegativeButton: UIButton!
    @IBOutlet weak var converterButton: UIButton!
    @IBOutlet weak var decimalButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    
    
    let conversionArray = [ConversionType(label: "Fahrenheit to Celcius", inputUnit: "°F", outputUnit: "°C"),
                           ConversionType(label: "Celcius to Fahrenheit", inputUnit: "°C", outputUnit: "°F"),
                           ConversionType(label: "Miles to Kilometers", inputUnit: "mi", outputUnit: "km"),
                           ConversionType(label: "Kilometers to Miles", inputUnit: "km", outputUnit: "mi")]
    private var typeOfConversion: TypeOfConversion = .fahrenheitToCelcius
    private var inputNumberText = "0"
    private var isDecimal = false
    private var isPositive = true
    private var isZero = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculate()
        applyAccessibility()
    }
    

    @IBAction func setConversionType(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose Converter", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: conversionArray[0].label, style: .default, handler: { alertAction in
            self.typeOfConversion = .fahrenheitToCelcius
            self.calculate()
        }))
        alert.addAction(UIAlertAction(title: conversionArray[1].label, style: UIAlertAction.Style.default, handler: { alertAction in
            self.typeOfConversion = .celciusToFahrenheit
            self.calculate()
        }))
        alert.addAction(UIAlertAction(title: conversionArray[2].label, style: UIAlertAction.Style.default, handler: { alertAction in
            self.typeOfConversion = .milesToKilometers
            self.calculate()
        }))
        alert.addAction(UIAlertAction(title: conversionArray[3].label, style: UIAlertAction.Style.default, handler: { alertAction in
            self.typeOfConversion = .kilometersToMiles
            self.calculate()
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func setZero(_ sender: Any) {
        if !isZero {
            inputNumberText = inputNumberText + "0"
        }
        calculate()
    }
    
    @IBAction func setDecimal(_ sender: Any) {
        isZero = false
        if isDecimal {
            return
        } else {
            isDecimal = true
            inputNumberText = inputNumberText + "."
        }
        calculate()
    }
    
    @IBAction func setOne(_ sender: Any) {
        numberButtonTapped("1")
    }
    
    @IBAction func setTwo(_ sender: Any) {
        numberButtonTapped("2")
    }
    
    @IBAction func setThree(_ sender: Any) {
        numberButtonTapped("3")
    }
    
    @IBAction func setFour(_ sender: Any) {
        numberButtonTapped("4")
    }
    
    @IBAction func setFive(_ sender: Any) {
        numberButtonTapped("5")
    }
    
    @IBAction func setSix(_ sender: Any) {
        numberButtonTapped("6")

    }
    
    @IBAction func setSeven(_ sender: Any) {
        numberButtonTapped("7")
    }
    
    @IBAction func setEight(_ sender: Any) {
        numberButtonTapped("8")
    }
    
    @IBAction func setNine(_ sender: Any) {
        numberButtonTapped("9")
    }
    
    @IBAction func clearInput(_ sender: Any) {
        inputNumberText = "0"
        isDecimal = false
        isPositive = true
        isZero = true
        calculate()
    }
    
    @IBAction func changeToPositiveNegative(_ sender: Any) {
        if isZero {
            return
        } else {
            if isPositive {
                inputNumberText = "-" + inputNumberText
                isPositive = false
            } else {
                inputNumberText.remove(at: inputNumberText.startIndex)
                isPositive = true
            }
        }
        calculate()
    }
    
    func calculate() {
        switch typeOfConversion {
        case .fahrenheitToCelcius:
            self.inputDisplay.text = self.inputNumberText + self.conversionArray[0].inputUnit
            self.inputDisplay.accessibilityLabel = "Input"
            self.inputDisplay.accessibilityValue = self.inputNumberText + " Degrees Fahrenheit"
            
            self.outputDisplay.text = self.convertFahrenheitToCelcius() + self.conversionArray[0].outputUnit
            self.outputDisplay.accessibilityLabel = "Output"
            self.outputDisplay.accessibilityValue = self.convertFahrenheitToCelcius() + " Degrees Celcius"
            
        case .celciusToFahrenheit:
            self.inputDisplay.text = self.inputNumberText + self.conversionArray[1].inputUnit
            self.inputDisplay.accessibilityLabel = "Input"
            self.inputDisplay.accessibilityValue = self.inputNumberText + " Degrees Celcius"
            
            self.outputDisplay.text = self.convertCelciusToFahrenheit() + self.conversionArray[1].outputUnit
            self.outputDisplay.accessibilityLabel = "Output"
            self.outputDisplay.accessibilityValue = self.convertCelciusToFahrenheit() + " Degrees Fahrenheit"
            
        case .milesToKilometers:
            self.inputDisplay.text = self.inputNumberText + self.conversionArray[2].inputUnit
            self.inputDisplay.accessibilityLabel = "Input"
            self.inputDisplay.accessibilityValue = self.inputNumberText + " Miles"
            
            self.outputDisplay.text = self.convertMilesToKilometers() + self.conversionArray[2].outputUnit
            self.outputDisplay.accessibilityLabel = "Output"
            self.outputDisplay.accessibilityValue = self.convertMilesToKilometers() + " Kilometers"
            
        case .kilometersToMiles:
            self.inputDisplay.text = self.inputNumberText + self.conversionArray[3].inputUnit
            self.inputDisplay.accessibilityLabel = "Input"
            self.inputDisplay.accessibilityValue = self.inputNumberText + " Kilometers"
            
            self.outputDisplay.text = self.convertKilometersToMiles() + self.conversionArray[3].outputUnit
            self.outputDisplay.accessibilityLabel = "Ouput"
            self.outputDisplay.accessibilityValue = self.convertKilometersToMiles() + " Miles"
        }
    }
    
    func numberButtonTapped(_ buttonText: String) {
        if isZero {
            inputNumberText = buttonText
            isZero = false
        } else {
            inputNumberText = inputNumberText + buttonText
        }
        
        calculate()
    }
    
    func convertFahrenheitToCelcius() -> String {
        let outputNumber = (Float(inputNumberText)! - 32) * 5/9
        return String(outputNumber)
    }
    
    func convertCelciusToFahrenheit() -> String {
        let outputNumber = (Float(inputNumberText)! * 9/5) + 32
        return String(outputNumber)
    }
    
    func convertMilesToKilometers() -> String {
        let outputNumber = Float(inputNumberText)! * 1.609344
        return String(outputNumber)
    }
    
    func convertKilometersToMiles() -> String {
        let outputNumber = Float(inputNumberText)! / 1.609344
        return String(outputNumber)
    }
    
    func applyAccessibility() {
        clearButton.accessibilityLabel = "Clear"
        positiveNegativeButton.accessibilityLabel = "Postive or Negative"
        converterButton.accessibilityLabel = "Change Conversion Type"
        decimalButton.accessibilityLabel = "Set Decimal"
        
        inputDisplay.isAccessibilityElement = true
        outputDisplay.isAccessibilityElement = true
        
        zeroButton.titleLabel?.adjustsFontForContentSizeCategory = true
        oneButton.titleLabel?.adjustsFontForContentSizeCategory = true
        twoButton.titleLabel?.adjustsFontForContentSizeCategory = true
        threeButton.titleLabel?.adjustsFontForContentSizeCategory = true
        fourButton.titleLabel?.adjustsFontForContentSizeCategory = true
        fiveButton.titleLabel?.adjustsFontForContentSizeCategory = true
        sixButton.titleLabel?.adjustsFontForContentSizeCategory = true
        sevenButton.titleLabel?.adjustsFontForContentSizeCategory = true
        eightButton.titleLabel?.adjustsFontForContentSizeCategory = true
        nineButton.titleLabel?.adjustsFontForContentSizeCategory = true
        clearButton.titleLabel?.adjustsFontForContentSizeCategory = true
        positiveNegativeButton.titleLabel?.adjustsFontForContentSizeCategory = true
        decimalButton.titleLabel?.adjustsFontForContentSizeCategory = true
        converterButton.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
}
