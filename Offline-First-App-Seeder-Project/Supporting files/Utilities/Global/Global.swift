//
//  Global.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 03/05/23.
//


import Foundation
import UIKit
import AVFoundation
import Network

var currentNetworkPath : NWPath?
private let appDelegate = UIApplication.shared.delegate as! AppDelegate

let ddMMMYYYY = "dd MMM YYYY"
let YYYYMMddTHHmmssSSSZ = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"
let MMMddYYYY = "MMM dd YYYY"
let ddMMYYYY = "dd/MM/YYYY"
let ddMMMyyyy = "dd MMM yyyy"
let ddMMYY = "dd/MM/YY"
let ddMMYYhMMss = "dd/MM/YY, h:mm:ss"
let ddMMMyy = "ddMMMyy"
let ddMMYYF = "dd/MM/YY"
let ddMMMyyHMM = "ddMMMyy, HH:mm"
let ddMMYYHMMF = "dd/MM/YY, HH:mm"
let MMddyyyy = "MM/dd/yyyy"

func isNetworkAvailable() -> Bool
{
    if currentNetworkPath?.status == .satisfied
    {
        return true
    }
    else
    {
        return false
    }
}

/// Converts the JSON object to data
/// - parameter json: JSON object that need to be converted
/// - returns: Converted data, if error occurs it'll return nil
func dataFromJSON(json : Any) -> Data?
{
    do
    {
        let data = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        return data
    }
    catch _
    {
        return nil
    }
}

func getStringFromDate(date:Date, format:String) -> String
{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let strDate = formatter.string(from: date)
    let yourDate = formatter.date(from: strDate)
    formatter.dateFormat = format
    let dateString = formatter.string(from: yourDate!)
    return dateString
}

func getStringFromStartDate(date:Date, format:String = ddMMMYYYY) -> String
{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let strDate = formatter.string(from: date)
    let yourDate = formatter.date(from: strDate)
    formatter.dateFormat = format
    let dateString = formatter.string(from: yourDate!)
    return dateString
}

func formatDate(withDate: String, outputFormat: String = ddMMMyyyy, skipCurrent: Bool = false) -> String
{
    var outputDateFormat = ""
    if outputFormat == ddMMMyyyy
    {
    }
    else
    {
        outputDateFormat = outputFormat
    }
    
    let dateFormatter = DateFormatter()
    var postedDate = ""
    dateFormatter.dateFormat = YYYYMMddTHHmmssSSSZ
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    if let date = dateFormatter.date(from: withDate)
    {
        dateFormatter.dateFormat = outputDateFormat
        if !skipCurrent {
            dateFormatter.timeZone = TimeZone.current
        }
        postedDate = dateFormatter.string(from: date)
    }
    
    return postedDate
}

func formatDateZip(withDate: String, outputFormat: String = "dMMMyy") -> String
{
    var outputDateFormat = ""
    if outputFormat == "dMMMyy"
    {
    } else if outputFormat == "ddMMMyy"
    {
    }
    else
    {
        outputDateFormat = outputFormat
    }
    
    let dateFormatter = DateFormatter()
    var postedDate = ""
    dateFormatter.dateFormat = YYYYMMddTHHmmssSSSZ
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    if let date = dateFormatter.date(from: withDate)
    {
        dateFormatter.dateFormat = outputDateFormat
        dateFormatter.timeZone = TimeZone.current
        postedDate = dateFormatter.string(from: date)
    }
    
    return postedDate
}

func formatDateLocalId(withDate: String, outputFormat: String = ddMMMYYYY) -> String
{
    var outputDateFormat = ""
    if outputFormat == ddMMMyyyy
    {
    }
    else
    {
        outputDateFormat = outputFormat
    }
    
    let dateFormatter = DateFormatter()
    var postedDate = ""
    dateFormatter.dateFormat = YYYYMMddTHHmmssSSSZ
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    if let date = dateFormatter.date(from: withDate)
    {
        dateFormatter.dateFormat = outputDateFormat
        dateFormatter.timeZone = TimeZone.current
        postedDate = dateFormatter.string(from: date)
    }
    
    return postedDate
}

func formatTime(withDate: String, outputFormat: String = "HH:mm:ss") -> String
{
    let dateFormatter = DateFormatter()
    var postedDate = ""
    dateFormatter.dateFormat = YYYYMMddTHHmmssSSSZ
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    if let date = dateFormatter.date(from: withDate)
    {
        dateFormatter.dateFormat = outputFormat
        dateFormatter.timeZone = TimeZone.current
        postedDate = dateFormatter.string(from: date)
    }
    
    return postedDate
}

func formatTimeHHMM(withDate: String, outputFormat: String = "HH:mm") -> String
{
    let dateFormatter = DateFormatter()
    var postedDate = ""
    dateFormatter.dateFormat = YYYYMMddTHHmmssSSSZ
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    if let date = dateFormatter.date(from: withDate)
    {
        dateFormatter.dateFormat = outputFormat
        dateFormatter.timeZone = TimeZone.current
        postedDate = dateFormatter.string(from: date)
    }
    
    return postedDate
}


func getDate(dateString:String,inputFormat: String = YYYYMMddTHHmmssSSSZ) -> Date {
    let dateFormatterInput = DateFormatter()
    dateFormatterInput.dateFormat = inputFormat
    if let date = dateFormatterInput.date(from: dateString) {
        return date
    }else {
        return Date()
    }
}

func getDateUTC(string:String,inputFormat: String = YYYYMMddTHHmmssSSSZ) -> Date {
    let dateFormatterInput = DateFormatter()
    dateFormatterInput.dateFormat = inputFormat
    dateFormatterInput.timeZone = TimeZone(abbreviation: "UTC")
    if let date = dateFormatterInput.date(from: string) {
        
        return date
    }else {
        return Date()
    }
}

func formatInputDate(withDate: String, inputFormat: String = MMMddYYYY) -> String
{
    let dateFormatter = DateFormatter()
    var postedDate = ""
    dateFormatter.dateFormat = YYYYMMddTHHmmssSSSZ
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    if let date = dateFormatter.date(from: withDate)
    {
        dateFormatter.dateFormat = inputFormat
        dateFormatter.timeZone = TimeZone.current
        postedDate = dateFormatter.string(from: date)
    }
    
    return postedDate
}


func convertDateFormat(strDate : String!) -> String
{
    let dateFormatter = DateFormatter()
    var postedDate = ""
    dateFormatter.dateFormat = YYYYMMddTHHmmssSSSZ
    if let date = dateFormatter.date(from: strDate)
    {
        dateFormatter.dateFormat = ddMMMYYYY
        postedDate = dateFormatter.string(from: date)
    }
    
    return postedDate
}

func formatDateForMessageTitle(withDate : String) -> String {
    let dateFormatter = DateFormatter()
    var postedDate = ""
    dateFormatter.dateFormat = YYYYMMddTHHmmssSSSZ
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    if let date = dateFormatter.date(from: withDate)
    {
        dateFormatter.dateFormat = "MMMM dd YYYY"
        dateFormatter.timeZone = TimeZone.current
        postedDate = dateFormatter.string(from: date)
    }
    return postedDate
}

func stringToDate(withString : String) -> Date
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = YYYYMMddTHHmmssSSSZ
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    let date = dateFormatter.date(from:withString) ?? Date()
    return date
}


func createJson(from object:Any) -> String? {
    guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
        return nil
    }
    
    
    return String(data: data, encoding: .utf8)
}


func getJSON(fromData data : Data) -> Any? {
    var json : Any?
    do
    {
        json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
    }
    catch _
    {
        json = nil
    }
    return json
}

func getStringFromData(data: Data?) -> String {
    var message = ""
    if let error = getJSON(fromData: data!) as? [String : Any]
    {
        if message == "Unauthorized"{
            message = ""
        }
    }
    return message
}

func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / image.size.width
    let heightRatio = targetSize.height / image.size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio, height: size.width * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
}

func jsonToDictionary(text: String) -> [String: Any]?
{
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            //            print(error.localizedDescription)
        }
    }
    return nil
}

func getTableItems(count:Int, noItemsFoundMessage:String, tableView:UITableView) -> Int
{
    if count > 0
    {
        tableView.backgroundView = nil
    }
    else
    {
        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noDataLabel.text          = noItemsFoundMessage
        noDataLabel.font = UIFont(name: "Nunito Sans", size: 14)
        noDataLabel.textColor     = UIColor.white
        noDataLabel.textAlignment = .center
        tableView.backgroundColor  = UIColor(hexString: "#216EFB")
        tableView.backgroundView  = noDataLabel
    }
    return count
}

func animatedTransition(nav: UINavigationController, timingFunction: Bool = false, duration: CGFloat, type: CATransitionType, subType: CATransitionSubtype?) {
    
    let transition = CATransition()
    transition.duration = CFTimeInterval(duration)
    
    if timingFunction {
        transition.type = type
        transition.subtype = subType
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        nav.view.layer.add(transition, forKey: kCATransition)
    }else{
        transition.type = type
        nav.view.layer.add(transition, forKey: nil)
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}


func returnIncrementedUTCTime(increment: Int) -> String {
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .minute, value: increment, to: Date())
    let utcDateFormatter = DateFormatter()
    utcDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    utcDateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
    let dateString = utcDateFormatter.string(from: date!)
    return dateString
}

func getMinutesFromDate(date: String) -> String {
    
    let dateFormatter = DateFormatter()
    // Set Date Format
    dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
    // Convert String to Date
    let stringToDate =   dateFormatter.date(from: date)
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "mm"
    let dateString = formatter.string(from: stringToDate ?? Date())
    //    print(dateString)
    return dateString
    
    
}

func queryParameters(from url: URL) -> [String: String]
{
    let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
    var queryParams   = [String: String]()
    for queryItem: URLQueryItem in (urlComponents?.queryItems)!
    {
        if queryItem.value == nil
        {
            continue
        }
        queryParams[queryItem.name] = queryItem.value
    }
    return queryParams
}

func stringToBytes(_ string: String) -> [UInt8]? {
    let length = string.count
    if length & 1 != 0 {
        return nil
    }
    var bytes = [UInt8]()
    bytes.reserveCapacity(length/2)
    var index = string.startIndex
    for _ in 0..<length/2 {
        let nextIndex = string.index(index, offsetBy: 2)
        if let b = UInt8(string[index..<nextIndex], radix: 16) {
            bytes.append(b)
        } else {
            return nil
        }
        index = nextIndex
    }
    return bytes
}


func convertLocalToUTC(date:String, fromFormat: String, toFormat: String = "YYYY-MM-dd'T'HH:mm:ss.SSSZ") -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = fromFormat
    dateFormatter.calendar = NSCalendar.current
    dateFormatter.timeZone = TimeZone.current
    if let dt = dateFormatter.date(from: date){
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: dt)
    }
    return nil
}

func convertUTCToLocal(date:String, fromFormat: String = "YYYY-MM-dd'T'HH:mm:ss.SSSZ", toFormat: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = fromFormat
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    if let dt = dateFormatter.date(from: date){
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: dt)
    }
    return nil
}

