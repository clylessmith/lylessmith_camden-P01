//
//  LetterGrade.swift
//  HW03_solution
//
//  Created by Owen Hildreth on 2/1/22.
//


/// Letter Grade for the student.
enum LetterGrade: String {
    case A          = "A"
    case A_minus    = "A-"
    case B_plus     = "B+"
    case B          = "B"
    case B_minus    = "B-"
    case C_plus     = "C+"
    case C          = "C"
    case D          = "D"
    case E          = "E"
    case invalidGrade   = "Invalid Grade"
    
    
    /// Initializes the Letter Grade based upon the score.
    public init(withScore score: Double) {
        if score <= 0.0 {self = .E; return}
        if score > 100.0 {self = .A; return}
        
        switch score {
        case 0.0..<55.0: self = .E
        case 55.0..<65: self = .D
        case 65..<72: self = .C
        case 72..<75: self = .C_plus
        case 75..<78: self = .B_minus
        case 78..<81: self = .B
        case 81..<85: self = .B_plus
        case 85..<90: self = .A_minus
        case 90...100: self = .A
        default: self = .invalidGrade
        }
    }
}

extension LetterGrade: Comparable {
    func comparableInt() -> Int {
        switch self {
        case .A: 9
        case .A_minus: 8
        case .B_plus: 7
        case .B: 6
        case .B_minus: 5
        case .C_plus: 4
        case .C: 3
        case .D: 2
        case .E: 1
        case .invalidGrade: 0
        }
    }
    
    static func < (lhs: LetterGrade, rhs: LetterGrade) -> Bool {
        return lhs.comparableInt() < rhs.comparableInt()
    }
}
