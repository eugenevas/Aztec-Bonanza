
import SpriteKit

let numberOfBlocks: UInt32 = 8

enum BlockColor: Int, CustomStringConvertible {
    
    //    case unknown = 0, blue, green, orange, pink, purple, red, sea, yellow
    case blue = 0, green, orange, pink, purple, red, sea, yellow
    
    
    var spriteName: String {
        
        //        let spriteNames = [
        //        "blue",
        //        "green",
        //        "orange",
        //        "pink",
        //        "purple",
        //        "red",
        //        "sea",
        //        "yellow"]
        
        
        //        return spriteNames[rawValue - 1]
        //        return spriteNames[rawValue]
        
        switch self {
        case .blue:
            return "blue"
            
        case .green:
            return "green"
        case .orange:
            return "orange"
        case .pink:
            return "pink"
        case .purple:
            return "purple"
        case .red:
            return "red"
        case .sea:
            return "sea"
        case .yellow:
            return "yellow"
        }
        
        
        
        
    }
    
    var description: String {
        return self.spriteName
    }
    
    static func random() -> BlockColor {
        return BlockColor(rawValue:Int(arc4random_uniform(numberOfBlocks)))!
    }
}


class Block: Hashable, CustomStringConvertible {
    
    let color: BlockColor
    var column: Int
    var row: Int
    var sprite: SKSpriteNode?
    
    var spriteName: String {
        return color.spriteName
    }
    
    var hashValue: Int {
        return self.column ^ self.row
    }
    
    var description: String {
        return "\(color): [\(column), \(row)]"
    }
    
    init(column:Int, row:Int, color: BlockColor) {
        self.column = column
        self.row = row
        self.color = color
    }
}

func == (lhs: Block, rhs: Block) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row && lhs.color.rawValue == rhs.color.rawValue
}

