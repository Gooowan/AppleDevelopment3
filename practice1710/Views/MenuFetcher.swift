final class MenuFetcher {
    
    static let shared = MenuFetcher()
    
    private init() { }
    
    func fetchMenu() -> [Drink] {
        [
            .init(name: "Latte", price: 90, ingredients: "Coffee, milk", portionSize: 300),
            .init(name: "Cappuccino", price: 80, ingredients: "Coffee, milk, foam", portionSize: 300),
            .init(name: "Espresso", price: 70, ingredients: "Coffee", portionSize: 30),
            .init(name: "Americano", price: 75, ingredients: "Coffee, water", portionSize: 300),
            .init(name: "Mocha", price: 100, ingredients: "Coffee, milk, chocolate", portionSize: 300),
            .init(name: "Macchiato", price: 100, ingredients: "Coffee, milk foam", portionSize: 60),
            .init(name: "Flat White", price: 110, ingredients: "Coffee, milk", portionSize: 300),
            .init(name: "Affogato", price: 120, ingredients: "Coffee, ice cream", portionSize: 200),
            .init(name: "Raf", price: 120, ingredients: "Coffee, milk, vanilla syrup", portionSize: 300),
        ]
    }
    
}
