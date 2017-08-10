
import Foundation

// 1
struct Cheese {}
struct Vodka {}

// 2
protocol Animal {
  associatedtype Food
  associatedtype Supplement

  func eat(food: Food)
  func supplement(s: Supplement)
}

extension Animal {
  func eat(food: Food) {
    print("\(self)")
    print("eat \(food)")
  }

  func supplement(s: Supplement) {
    print("supplement \(s)")
  }
}

// 3
struct Rato: Animal {
  typealias Food = Cheese
  typealias Supplement = Vodka
}

struct AnyAnimal<F, S>: Animal {

  typealias Food = F
  typealias Supplement = S

  private let eat: (Food) -> Void
  private let supplement: (Supplement) -> Void

  init<A: Animal>(_ animal: A) where A.Food == Food, A.Supplement == Supplement {
    eat = { animal.eat(food: $0) }
    supplement = { animal.supplement(s: $0) }
  }

  func eat(food: Food) {
    eat(food)
  }

  func supplement(s: Supplement) {
    supplement(s)
  }
}

let animal = AnyAnimal(Rato())
animal.eat(food: Cheese())
print(animal)


