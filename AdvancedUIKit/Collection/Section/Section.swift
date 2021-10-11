/// Section presents a group of rows
///
/// - version: 1.8.0
/// - date: 08/10/21
/// - author: Adamas
open class Section: SectionType {

    public let header: String?
    public let footer: String?
    public let rows: [RowType]

    /// Initialize a section
    /// - Parameters:
    ///   - header: The header of the section.
    ///   - footer: The footer of the section.
    ///   - rows: Rows within the section.
    public init(header: String? = nil,
         footer: String? = nil,
         rows: [RowType]) {
        self.header = header
        self.footer = footer
        self.rows = rows
    }
}

/// The protocol of a section
public protocol SectionType {

    /// The header of the section.
    var header: String? { get }

    /// The footer of the section.
    var footer: String? { get }

    /// Rows contained in the section
    var rows: [RowType] { get }
}
