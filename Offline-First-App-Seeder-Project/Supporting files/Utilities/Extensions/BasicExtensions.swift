//
//  BasicExtensions.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 03/05/23.
//

import Foundation
import UIKit
import LocalAuthentication


typealias AlertCompletion = (UIAlertAction) -> (Void)
var viewLoading:UIView?
var Y: CGFloat = 0
extension String{
    
    func returnCommaSeperatedPrice()-> String
    {
        var formattedDigit = ""
        var afterDecimal = ""
        let beforeDecimal = self.components(separatedBy: ".").first ?? self
        if self.contains("."){
            afterDecimal = self.components(separatedBy: ".").last ?? ""
        }
        if beforeDecimal.count > 3{
            let brforeDecimalReversed = String(beforeDecimal.reversed())
            if brforeDecimalReversed.contains("-"){
                let rC = String(brforeDecimalReversed.dropLast())
                let sign = String(brforeDecimalReversed.suffix(1))
                let commaSeperated = rC.inserting(separator: ",", every: 3) + sign
                formattedDigit = String(commaSeperated.reversed())
            }
            else{
                let commaSeperated = brforeDecimalReversed.inserting(separator: ",", every: 3)
                formattedDigit = String(commaSeperated.reversed())
            }
        }
        else
        {
            formattedDigit = beforeDecimal
        }
        
        let formattedNumber = formattedDigit == "" ? "0" : formattedDigit
        let returnNumber = afterDecimal == "" ? formattedNumber : formattedNumber + "." + afterDecimal
        
        return returnNumber
    }
    
    func returnCommaSeperatedPriceU()-> String
    {
        let price = NSNumber(value: Double(self) ?? 0)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        numberFormatter.maximumFractionDigits = 30
        let formattedNumber = numberFormatter.string(from: price)
        return formattedNumber ?? ""
    }
    
    func isValidPassword() -> Bool
    {
        let regEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#+-/~:{}^`=_\\[\\]\\(\\))(])[A-Za-z\\dd$@$!%*?&#+-/~:{}^`=_\\[\\]\\(\\))(]{8,}"
        
        let pwdPredicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return pwdPredicate.evaluate(with: self)
    }
    
    func setAttributedText(font:String,color: String,size:CGFloat)-> NSMutableAttributedString{
        let attrs = [NSMutableAttributedString.Key.foregroundColor : UIColor.init(hexString: color), NSMutableAttributedString.Key.font :UIFont(name:font, size: size)]
        let newattrs = attrs  as [NSMutableAttributedString.Key : Any]
        let attributedString = NSMutableAttributedString(string: self, attributes:newattrs)
        return attributedString
    }
    
    func isValidEmail() -> Bool
    {
        let emailRegEx     = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: self)
        
    }
    
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    func truncate(places: Int) -> String
    {
        var num = self
        if self.contains(".")
        {
            let beforeDecimal = self.components(separatedBy: ".").first ?? ""
            var afterDecimal = self.components(separatedBy: ".").last ?? ""
            
            if afterDecimal.count > places
            {
                afterDecimal = String(afterDecimal.prefix(places))
                let decimal = Int64(afterDecimal) == 0 ? "" : afterDecimal
                
                if decimal != "" {
                    let newNum = "0." + decimal
                    let NSafterDecimal = NSDecimalNumber.init(string: newNum)
                    let desValue = String(NSafterDecimal.description.dropFirst(2))
                    num = beforeDecimal + "." + desValue
                }else {
                    num = beforeDecimal
                }
            }
            else
            {
                let decimal = Int64(afterDecimal) == 0 ? "" : afterDecimal
                if decimal != "" {
                    let newNum = "0." + decimal
                    let NSafterDecimal = NSDecimalNumber.init(string: newNum)
                    let desValue = String(NSafterDecimal.description.dropFirst(2))
                    num = beforeDecimal + "." + desValue
                }else {
                    num = beforeDecimal
                }
            }
        }
        
        return num
    }
    
    
}



extension Collection {
    func distance(to index: Index) -> Int { distance(from: startIndex, to: index) }
}
extension StringProtocol where Self: RangeReplaceableCollection {
    mutating func insert<S: StringProtocol>(separator: S, every n: Int) {
        for index in indices.dropFirst().reversed()
        where distance(to: index).isMultiple(of: n) {
            insert(contentsOf: separator, at: index)
        }
    }
    func inserting<S: StringProtocol>(separator: S, every n: Int) -> Self {
        var string = self
        string.insert(separator: separator, every: n)
        return string
    }
}

extension Double
{
    
    func commaForNumbers()-> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:self)) ?? ""
        return formattedNumber
    }
    
    func returnIntegersAfterDecimal(count:Int) -> Double
    {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = count
        formatter.roundingMode = .down
        let strValue = formatter.string(from: NSNumber(value: self))
        return Double(strValue ?? "\(self)") ?? self
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIColor {
    convenience init(hexString: String) {
        
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIAlertController{
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.tintColor = UIColor.init(hexString: "#000000")
    }
}

extension CGRect {
    static func with(originY y: CGFloat, height h: CGFloat) -> CGRect {
        var custom         = CGRect.zero
        custom.origin.y    = y
        custom.size.height = h
        return custom
    }
}

extension UIViewController {
    var hasNotch: Bool {
        return UIDevice.hasNotch
    }
    
    var topToLayout: CGFloat {
        return UIDevice.hasNotch ? 44 : 20
    }
}

extension UIViewController {
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.7, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    
    func showAlert(withTitle title: String?, message : String?, button: String = "OK", andCompletion completion : AlertCompletion? = nil)
    {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.default, handler: completion))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showDevelopmentAlert() {
        showAlert(withTitle: "Coming Soon", message: "Development in progress, will be available soon")
    }
    
    func ShowTopAlert(Title:String,Color:UIColor = .errorRed, image:String = "ExclamationRed"){
        
        let customView = UIView()
        customView.backgroundColor = Color
        self.view.addSubview(customView)
        
        // Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named:image)
        // Set bound to reposition
        let imageOffsetY: CGFloat = -2
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 15, height: 15)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        // Add image to mutable string
        completeText.append(attachmentString)
        // Add your text to mutable string
        let textAfterIcon = NSAttributedString(string: "  \(Title)")
        completeText.append(textAfterIcon)
        
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.attributedText = completeText
        
        label.textColor = .white
        label.font = UIFont(name: "Nunito Sans", size: 14)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        let maximumLabelSize: CGSize = CGSize(width: view.frame.width, height: 9999)
        let expectedLabelSize: CGSize = label.sizeThatFits(maximumLabelSize)
        var newFrame: CGRect = label.frame
        newFrame.origin.x = 0
        expectedLabelSize.height > 40 ? (newFrame.size.height = expectedLabelSize.height) : (newFrame.size.height = 40)
        newFrame.size.width = self.view.frame.size.width
        label.frame = newFrame
        customView.addSubview(label)
        var viwHeight : CGFloat = 0
        alertYValue()
        if newFrame.size.height > 40
        {
            viwHeight = newFrame.size.height + 20
            
        }
        else
        {
            viwHeight = 40
            
        }
        customView.frame = CGRect(x: 0, y: Y, width: view.frame.width , height: viwHeight)
        label.center.y = customView.frame.height/2
        
        
        
        UIView.animate(withDuration: 0.3, animations: {
            customView.transform = CGAffineTransform(translationX: 0, y:20)
        }) { (true) in
            UIView.animate(withDuration: 0.3, delay: 3, options: .curveEaseOut, animations: {
                customView.transform = .identity
            }) { (true) in
                customView.removeFromSuperview()
            }
        }
    }
    
    func alertYValue()
    {
        if UIDevice.name == .iphone_6_6S_7_8{
            
            Y = 50
        }
        
        else if UIDevice.name == .iphone_Plus{
            
            Y = 50
        }
        
        else{
            Y = 80
        }
        
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}


extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: "AvenirNext-Medium", size: 12)!]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
    
    func setColorForText(_ textToFind: String, with color: UIColor, withFont : UIFont) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
            if withFont != UIFont(name: "ProximaNova-Regular", size: 10) {
                addAttribute(NSAttributedString.Key.font, value: withFont, range: range)
            }
        }
    }
}

class unAuthorized{
    private init(){}
    static var shared = unAuthorized()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var sessionHit:Bool = false
    
    
}



///extension for slide images in an array with transitionCrossDissolve animation
extension UIImageView{
    func setImage(_ image: UIImage?, animated: Bool = true) {
        let duration = animated ? 0.3 : 0.0
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.image = image
        }, completion: nil)
    }
}

extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
              let range = self[startIndex...]
            .range(of: string, options: options) {
            result.append(range)
            startIndex = range.lowerBound < range.upperBound ? range.upperBound :
            index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

extension Date {
    func getTimeString() -> String {
        let date = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short).replacingOccurrences(of: " ", with: "")
        return date
    }
    
}



extension UIView {
    public var safeAreaFrame: CGRect {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.layoutFrame
        }
        return bounds
    }
}


extension UIDevice {
    static var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            return bottom > 0
            
        } else {
            return false
        }
    }
}

extension UIDevice {
    
    static var hasSafeArea: Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                return false
                
            case 1334:
                return false
                
            case 1920, 2208:
                return false
                
            case 2436:
                return true
                
            case 2688:
                return true
                
            case 1792:
                return true
                
            default:
                return false
                
            }
        }else {
            return false
        }
        
    }
    
    enum DeviceName {
        case iphone_5_SE
        case iphone_6_6S_7_8
        case iphone_Plus
        case iphone_X_XS
        case iphone_XR
        case iphone_XSMax
        case unknown
        case ipad
        
    }
    
    static var name: DeviceName {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                return DeviceName.iphone_5_SE
                
            case 1334:
                return DeviceName.iphone_6_6S_7_8
                
            case 1920, 2208:
                return DeviceName.iphone_Plus
                
            case 2436:
                return DeviceName.iphone_X_XS
                
            case 2688:
                return DeviceName.iphone_XSMax
                
            case 1792:
                return DeviceName.iphone_XR
            default:
                print("Unknown")
                
                return DeviceName.unknown
                
            }
        }else {
            return DeviceName.ipad
            
        }
        
    }
    
}
//https://stackoverflow.com/a/62837729/10476608
extension UIViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
extension UIViewController {
    func popViewController(animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    func popToViewController(ofClass: AnyClass, _ animated: Bool = true) {
        self.navigationController?.popToViewController(ofClass: ofClass, animated: animated)
    }
    
    func addChildVC(_ controller: UIViewController, parentView: UIView){
        controller.view.frame = parentView.bounds
        parentView.addSubview(controller.view)
        addChild(controller)
        controller.didMove(toParent: self)
    }
    
    func showViewAnimated(){
        self.view.alpha = 0.3
        UIView.animate(withDuration: 0.1) {
            self.view.alpha = 1
        }
    }
    
    func removeViewAnimated(){
        UIView.animate(withDuration: 0.1) {
            self.view.alpha = 0.3
        } completion: { finished in
            if finished{
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        }
    }
}

extension UIColor {
    static let buttonGray   = UIColor(hexString  : "F2F2F2")
    static let buttonYellow = UIColor(hexString  : "FFB909")
    static let buttonBlue   = UIColor(hexString  : "216EFB")
    static let borderRed    = UIColor(hexString  : "FA716B")
    static let errorRed     = UIColor(hexString  : "FF6F6E")
    
    static let white            = UIColor(hexString  : "FFFFFF")
    static let purple           = UIColor(hexString  : "490576")
    static let textColor        = UIColor(hexString  : "000000")
    static let familyCircle     = UIColor(hexString  : "9B75C1")
    static let friendsCircle    = UIColor(hexString  : "477DFF")
    static let mySquad          = UIColor(hexString  : "FCD51B")
    static let seeAll           = UIColor(hexString  : "71CB86")
    static let timerRed         = UIColor(hexString  : "DC4C44")
    static let timerBlack       = UIColor(hexString  : "413D45")
    static let btnDisable       = UIColor(hexString  : "D9D5D2")
    static let borderErrorColor = UIColor(hexString: "F0F0F0")
    static let greenColor       = UIColor(hexString: "377F56")
    static let lightGreen       = UIColor(hexString: "78CC7C")
    
    static let circleEmergency  = UIColor(hexString  : "9B75C1")
    static let circleFirst      = UIColor(hexString  : "477DFF")
    static let circleSecond     = UIColor(hexString  : "FCD51B")
    static let friendsBorder    = UIColor(hexString  : "011B79")
    static let mySquadBorder    = UIColor(hexString  : "A88817")
    static let allCircleBorder  = UIColor(hexString  : "377F56")
    static let tabSelected      = UIColor(hexString  : "DAB6F2")
    static let tabSelectedDark  = UIColor(hexString  : "590576")
    static let skipButtonColor  = UIColor(hexString  : "A273C6")
    static let notHelpfulColor  = UIColor(hexString  : "DC4C44")
    static let HelpfulColor     = UIColor(hexString  : "65C466")
    static let mySquadCellSelection = UIColor(hexString: "F1F1F1")
    static let textColorGray = UIColor(hexString: "656565")
    static let  blueToothDisconnect = UIColor(hexString: "F6D2D0")
    static let openWalletDisabled = UIColor(hexString: "000000").withAlphaComponent(0.10)
    static let dropShadow = UIColor(hexString: "000000").withAlphaComponent(0.25)
    static let disabledGrey = UIColor(hexString: "E5E5E5")
    static let walletIconDisabled = UIColor(hexString: "929292")
    static let textMain = UIColor(hexString: "393938")
    static let sosBorderColor = UIColor(hexString: "DC4C44")
}


func isNotEmpty(string: String?) -> Bool {
    guard let text = string else { return false }
    return !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
}

extension Double {
    func formattedTime(outputFormat:String = "yyyy-MM-dd") -> String {
        let date = Date(timeIntervalSince1970: self/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = outputFormat
        let dateString = dateFormatter.string(from: date)
        return dateString
        
    }
    
    func getYearMonthDay() -> TimeData {
        
        let date = Date(timeIntervalSince1970: self/1000)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return TimeData(year: components.year ?? 0, month: components.month ?? 0, day: components.day ?? 0)
    }
    
    struct TimeData {
        var year : Int
        var month: Int
        var day  : Int
    }
    
    func metersToMiles() -> Double {
        let converted = self/1609.344
        return converted
    }
    
    func milesToMeters() -> Double {
        let converted = self * 1609.344
        return converted
    }
    
}


@IBDesignable  class BaseScrollView: UIScrollView {
    
    @IBInspectable var topBotInset: CGPoint {
        get {
            
            return CGPoint(x: contentInset.top, y: contentInset.bottom)
        }
        set {
            self.contentInset.top = newValue.x
            self.contentInset.bottom = newValue.y
        }
    }
    
    @IBInspectable var lefRigInset: CGPoint {
        get {
            return CGPoint(x: contentInset.left, y: contentInset.right)
        }
        set {
            self.contentInset.left = newValue.x
            self.contentInset.right = newValue.y
        }
    }
    
}

func isValidd(string: String?) -> Bool
{
    if let unwrapped =  string, !unwrapped.isEmpty
    {
        return true
    }
    else{
        return false
    }
}

func isValid(string: String?) -> Bool {
    if let unwrapped = string?.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: ""), !unwrapped.isEmpty {
        return true
    }else {
        return false
    }
}


extension UIImage {
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
}

extension String {
    var isEmptyString: Bool {
        return (self == "" || self.isEmpty)
    }
    
    func metersToMiles() -> Double? {
        if let doubleValue = Double(self) {
            let converted = doubleValue/1609.344
            return converted
        }else {
            return nil
        }
    }
    
    func milesToMeters() -> Double? {
        if let doubleValue = Double(self) {
            let converted = doubleValue * 1609.344
            return converted
        }else {
            return nil
        }
    }
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    
}

extension Int {
    var isZero: Bool {
        return self == 0
    }
    
    func metersToMiles() -> Double {
        let converted = Double(self)/1609.344
        return converted
    }
    
    func milesToMeters() -> Double {
        let converted = Double(self) * 1609.344
        return converted
    }
}

extension Array {
    mutating func replace(transform: (inout Element) -> Void) {
        for i in 0 ..< self.count {
            transform(&self[i])
        }
    }
}


extension String {
    enum TimeDataZone {
        case UTC
        case current
    }
    
    func date(inputFormat:String =  "yyyy-MM-dd'T'HH:mm", zone: TimeDataZone) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        dateFormatter.timeZone = zone == .UTC ? TimeZone(abbreviation: "UTC") : TimeZone.current
        
        let date = dateFormatter.date(from: self) ?? Date()
        return date
    }
    
    func dateString(inputFormat:String =  "yyyy-MM-dd'T'HH:mm", outputFormat:String = "ddMMMyy", locale: Locale) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = outputFormat
        dateFormatter.locale = locale
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    func dateString(inputFormat:String =  "yyyy-MM-dd'T'HH:mm", outputFormat:String = "YYYY-MM-dd'T'HH:mm:ss.SSSZ") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = outputFormat
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    func convert(inputFormat: String = ddMMYYYY, outputFormat: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = outputFormat
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func convertDate(inputFormat: String = MMddyyyy, outputFormat: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = outputFormat
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func getDate(inputFormat:String =  "yyyy-MM-dd'T'HH:mm:ss", outputFormat:String = "ddMMMyy", zone: TimeDataZone = .UTC) -> (Date?, String?) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = inputFormat
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat
            dateFormatter.timeZone = zone == .UTC ? TimeZone(abbreviation: "UTC") : TimeZone.current
            let dateString = dateFormatter.string(from: date)
            return (date,dateString)
        }else {
            return (nil,nil)
        }
    }
    
    func timeAgo(relatedDate: Date? = nil) -> String {
        
        var date: Date?
        if let related = relatedDate {
            date = related
        }else {
            let dateString: String = self
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            date = dateFormatter.date(from: dateString)
        }
        var diff: Int = 0
        if let date = date {
            let calendar = Calendar.current
            let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
            let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
            let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
            //  let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
            let weekAgo = calendar.date(byAdding: Calendar.Component.weekOfYear, value: -1, to: Date())!
            let monthAgo = calendar.date(byAdding: .month, value: -1, to: Date())!
            let yearAgo = calendar.date(byAdding: .year, value: -1, to: Date())!
            if minuteAgo < date {
                let diff = Calendar.current.dateComponents([.second], from: date, to: Date()).second ?? 0
                let appendSingular = "sec"
                let appendPlural   = "secs"
                return diff == 1 ? "\(diff) \(appendSingular)" : "\(diff) \(appendPlural)"
            } else if hourAgo < date {
                let diff = Calendar.current.dateComponents([.minute], from: date, to: Date()).minute ?? 0
                let appendSingular = "min"
                let appendPlural   = "mins"
                return diff == 1 ? "\(diff) \(appendSingular)" : "\(diff) \(appendPlural)"
            } else if dayAgo < date {
                let diff = Calendar.current.dateComponents([.hour], from: date, to: Date()).hour ?? 0
                let appendSingular = "hr"
                let appendPlural   = "hrs"
                return diff == 1 ? "\(diff) \(appendSingular)" : "\(diff) \(appendPlural)"
            } else if weekAgo < date {
                let diff = Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
                let appendSingular = "day"
                let appendPlural   = "days"
                return diff == 1 ? "\(diff) \(appendSingular)": "\(diff) \(appendPlural)"
            }
            else if monthAgo < date
            {
                let diff = Calendar.current.dateComponents([.weekOfYear], from: date, to: Date()).weekOfYear ?? 0
                let appendSingular = "week"
                let appendPlural   = "weeks"
                
                return diff == 1 ? "\(diff) \(appendSingular)" : "\(diff) \(appendPlural)"
            }
            
            else if yearAgo < date
            {
                let diff = Calendar.current.dateComponents([.month], from: date, to: Date()).month ?? 0
                let appendSingular = "week"
                let appendPlural   = "weeks"
                
                return diff == 1 ? "\(diff) \(appendSingular)" : "\(diff) \(appendPlural)"
            }
            else
            {
                diff = Calendar.current.dateComponents([.year], from: date, to: Date()).year ?? 0
            }
        }
        let appendSingular = "year"
        let appendPlural   = "years"
        
        return diff == 1 ? "\(diff) \(appendSingular)" : "\(diff) \(appendPlural)"
    }
}

extension Date {
    
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int64 {
        
        let currentCalendar = Calendar.current
        
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        
        return Int64(end - start)
    }
    
    func dateString(outputFormat:String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ", zone: String.TimeDataZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = outputFormat
        dateFormatter.timeZone = zone == .UTC ? TimeZone(abbreviation: "UTC") : TimeZone.current
        //        dateFormatter.locale = Locale(identifier: SEDefaults.shared.getLanguage().shortName)
        
        let dateString = dateFormatter.string(from: self)
        
        return dateString
    }
    
    func dateStringHour(hour: String = "08") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: self)
        let dateString = date + "T08:00:00.000"
        
        return dateString
    }
    
    func convert(format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
}


// split seconds to components
@inline(__always) func splitTime(fromSeconds: Int64) -> (Int64, Int64, Int64) {
    let travellingTime = fromSeconds
    let hours          = travellingTime / 3600
    let minutes        = (travellingTime % 3600) / 60
    let seconds        = (travellingTime % 3660) % 60
    
    let time           = (hours, minutes, seconds)
    return time
}

extension UIColor {
    struct OB {
        static let rowDarkBlue   = UIColor(hexString: "#E3E9F2")
        static let rowLightBlue  = UIColor(hexString: "#EAF0FA")
        static let rowWhite      = UIColor(hexString: "#FAFAFA")
        static let rowGray       = UIColor(hexString: "#F2F2F2")
        static let textDarkGray  = UIColor(hexString: "#B5B5B5")
        static let textGray      = UIColor(hexString: "#4D4D4D")
        static let textLightGray = UIColor(hexString: "#818181")
        static let blue          = UIColor(hexString: "#216EFB")
        static let red           = UIColor(hexString: "#FF6F6E")
        static let green         = UIColor(hexString: "#54CBA9")
        
    }
}

extension Sequence where Iterator.Element: Hashable {
    func uniq() -> [Iterator.Element] {
        var seen = Set<Iterator.Element>()
        return filter { seen.update(with: $0) == nil }
    }
    
}

extension NSAttributedString {
    func withLineSpacing(_ spacing: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.alignment = .center
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: string.count))
        return NSAttributedString(attributedString: attributedString)
    }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        guard let attributedText = label.attributedText else { return false }
        
        let mutableStr = NSMutableAttributedString.init(attributedString: attributedText)
        mutableStr.addAttributes([NSAttributedString.Key.font : label.font!], range: NSRange.init(location: 0, length: attributedText.length))
        
        // If the label have text alignment. Delete this code if label have a default (left) aligment. Possible to add the attribute in previous adding.
        //          let paragraphStyle = NSMutableParagraphStyle()
        //          paragraphStyle.alignment = .center
        //          mutableStr.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: attributedText.length))
        
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: mutableStr)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}


extension LAContext {
    enum BiometricType: String {
        case none
        case touchID
        case faceID
    }
    
    var biometricType: BiometricType {
        var error: NSError?
        
        guard self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return .none
        }
        
        if #available(iOS 11.0, *) {
            switch self.biometryType {
            case .none:
                return .none
            case .touchID:
                return .touchID
            case .faceID:
                return .faceID
            @unknown default:
                print("Handle new Biometric type")
            }
        }
        
        return  self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touchID : .none
    }
}

extension UIViewController {
    func presentAnimated(_ viewControllerToPresent: UIViewController) {
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func dismissAnimated() {
        dismiss(animated: true, completion: nil)
    }
}

extension UIAlertController {
    func setBackground(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
            self.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .white
            groupView.subviews.last?.backgroundColor = .white
            bgView.subviews.last?.backgroundColor = .white
        }
    }
    func setCancelBackground(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
            self.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .white
        }
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

//https://stackoverflow.com/a/56482389/10476608
extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
}

extension String {
    func setLineSpacing(fontSize: CGFloat = 14, spacing: CGFloat = 2) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.alignment = .center
        let attributes = [NSAttributedString.Key.font: CustomFonts.regular.font(size: fontSize), NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let attributedString = NSMutableAttributedString(string: self, attributes: attributes)
        
        return attributedString
    }
    
    func setLineSpacing(font: UIFont, spacing: CGFloat = 6, alignment: NSTextAlignment = .center) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.alignment = alignment
        let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let attributedString = NSMutableAttributedString(string: self, attributes: attributes)
        
        return attributedString
    }
    
    
    func setUnderline(fontSize: CGFloat = 16, color: UIColor = UIColor.init(hexString: "#413D45")) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: CustomFonts.regular.font(size: fontSize),
            NSAttributedString.Key.foregroundColor: UIColor.init(hexString: "#413D45"),
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributedString = NSMutableAttributedString(string: self, attributes: attributes)
        return attributedString
    }
    
    // trimming non-number charactors in string
    func trimPhoneNumber() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: " ", with: "")
    }
    
    func trimPhoneNumberSearch() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: " ", with: "")
    }
    
    func cleanPhoneNumber() -> String {
        let number = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        return number
    }
}

extension UIView {
    func setBackground(color: UIColor = UIColor.purple, duration: TimeInterval = 0.25) {
        UIView.animate(withDuration: duration, delay: 0.0, options:[.curveEaseOut], animations: {
            self.backgroundColor = color
        }, completion:nil)
    }
}

extension UISegmentedControl {
    
    func setTitleColor(_ color: UIColor, state: UIControl.State = .normal) {
        var attributes = self.titleTextAttributes(for: state) ?? [:]
        attributes[.foregroundColor] = color
        self.setTitleTextAttributes(attributes, for: state)
    }
    
    func setTitleFont(_ font: UIFont, state: UIControl.State = .normal) {
        var attributes = self.titleTextAttributes(for: state) ?? [:]
        attributes[.font] = font
        self.setTitleTextAttributes(attributes, for: state)
    }
    
}

extension UISwitch {
    
    func set(width: CGFloat, height: CGFloat) {
        
        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51
        
        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth
        
        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}

extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
}

extension UIViewController {
    func enablePopGesture(enable: Bool = false) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = enable
    }
}

extension MutableCollection {
    mutating func mapAlter<T>(_ keyPath: WritableKeyPath<Element, T>, _ value: T) {
        indices.forEach { self[$0][keyPath: keyPath] = value }
    }
}
extension String{
    func extractYoutubeId() -> String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/)|(?<=shorts/))([\\w-]++)"
        if let matchRange = self.range(of: pattern, options: .regularExpression) {
            return String(self[matchRange])
        } else {
            return .none
        }
    }
}
extension Data {
    var hexString: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}
///https://medium.com/@tate.pravin/swift-uiview-tapping-animation-extension-1f9a188b53b6
public extension UIView {
    func showTapAnimation(_ completionBlock: @escaping () -> Void) {
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
            self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
}
extension String {
    var fileName: String? {
        return self.components(separatedBy: "/").last
    }
}
