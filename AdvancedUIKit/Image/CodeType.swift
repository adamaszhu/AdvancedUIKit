/// The type of the code
///
/// - author: Adamas
/// - date: 15/09/2019
/// - version: 1.5.0
public enum CodeType: String {
    case code128 = "CICode128BarcodeGenerator"
    case pdf417 = "CIPDF417BarcodeGenerator"
    case aztec = "CIAztecCodeGenerator"
    case qr = "CIQRCodeGenerator"
}
