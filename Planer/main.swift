import Foundation



struct Stack<Element> {
    private var elements = [Element]()
    
    mutating func push(_ element: Element) {
        elements.append(element)
    }
    
    mutating func pop() -> Element? {
        return elements.popLast()
    }
    
    func peek() -> Element? {
        return elements.last
    }
    
    func isEmpty() -> Bool {
        return elements.isEmpty
    }
    
    func count() -> Int {
        return elements.count
    }
}


struct Task {
    enum TaskType {
        case general
        case technical
    }
    
    let title: String
    let dueDate: Date
    let type: TaskType
}


class TaskPlanner {
    
    private var tasks = Stack<Task>()
    private let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
    }
    
    func addTask(_ task: Task) {
        tasks.push(task)
        print("Додано задачу: \(task.title)")
    }
    
    
    func listTasks() {
        
        print("\nСписок задач:\n")
        
        var reversedStack = Stack<Task>()
        
        while let task = tasks.pop() {
            reversedStack.push(task)
        }
        while let task = reversedStack.pop() {
            let formatDate = dateFormatter.string(from: task.dueDate)
            print("\(task.title) - \(formatDate) - \(task.type)")
            tasks.push(task)
        }
    }
    
    
    func processTask() -> Task? {
        guard let lastTask = tasks.pop()
        else {
            
            print("Планер порожній")
            
            return nil
        }
        
        print("\nВзято в роботу: \(lastTask.title)\n")
        
        return lastTask
    }
}


var planner = TaskPlanner()

let task1 = Task( title: "Налаштувати пошту", dueDate: Date(), type: .technical)
let task2 = Task(title: "Підготувати звіт", dueDate: Date(), type: .general)
let task3 = Task(title: "Перевірити виправлення помилок", dueDate: Date(), type: .technical)

planner.addTask(task1)
planner.addTask(task2)
planner.addTask(task3)

planner.listTasks()



if let currentTask = planner.processTask() {
    print("Поточна задача: \(currentTask.title)")
    
} else {
    
    print("Немає доступних задач")
}

planner.listTasks()
