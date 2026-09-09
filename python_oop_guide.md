<div align="center">

# 🐍 Complete Object-Oriented Programming with Python

### *From your very first class to professional software design*

**_By Gehan Fernando_**

</div>

---

> [!NOTE]
> **👥 Who this is for:** students, self-learners, junior developers, professionals refreshing their Python OOP, and instructors.
> **🎯 Goal:** learn object-oriented programming from beginner syntax all the way to professional Python design — even if you have *never* written a class before.
> **🧰 Recommended setup:** Python 3.11 or newer, Visual Studio Code or PyCharm, plus `uv`, `pip`, `venv`, `pytest`, and `mypy` or `pyright` for optional type checking.
> **🗓️ Last updated:** 2026-06-25.

---

## 🗺️ How to read this guide (please read this first!)

> [!IMPORTANT]
> **Do not read this like a novel. Use it like a lab manual.** 🔬
> You learn OOP with your *fingers*, not just your eyes.

For **every** topic, follow this 7-step loop:

| Step | Action | Why it matters |
|:---:|---|---|
| 1️⃣ | **Read** the concept | Understand the idea |
| 2️⃣ | **Type** the example by hand | Muscle memory beats copy-paste |
| 3️⃣ | **Run** it | See it actually work |
| 4️⃣ | **Break** it on purpose | Errors are your best teacher |
| 5️⃣ | **Fix** it | Learn how it fails and recovers |
| 6️⃣ | **Modify** it into your own version | Make the idea yours |
| 7️⃣ | **Add** a small test or exercise | Prove you understood it |

By the end, you should be able to **design, implement, test, and refactor** object-oriented Python applications using modern Python practices. 🚀

---

## 🎨 How to read the colored boxes (your legend)

Throughout this guide you'll see the same friendly icons. Here's what each one means:

| Icon | Label | What it gives you |
|:---:|---|---|
| 📌 | **In plain words** | The idea explained with zero jargon |
| 🌍 | **Real-world analogy** | A everyday-life comparison |
| 🛠️ | **How to use it** | The actual code / steps |
| 🎯 | **When to use it** | The right situations |
| ⚠️ | **When to avoid it** | The traps and wrong situations |
| 💡 | **Pro tip** | A shortcut experts know |
| 🧪 | **Try it yourself** | A hands-on exercise |

---

## 📚 Table of contents

<details>
<summary><b>Click to expand the full 39-topic map</b></summary>

1. [Prerequisites and setup](#1-prerequisites-and-setup)
2. [What OOP means](#2-what-oop-means)
3. [The four pillars of OOP](#3-the-four-pillars-of-oop)
4. [Classes and objects](#4-classes-and-objects)
5. [Attributes, properties, and methods](#5-attributes-properties-and-methods)
6. [Constructors and object initialization](#6-constructors-and-object-initialization)
7. [Access conventions](#7-access-conventions)
8. [Object lifecycle and resource management](#8-object-lifecycle-and-resource-management)
9. [Encapsulation](#9-encapsulation)
10. [Abstraction](#10-abstraction)
11. [Inheritance](#11-inheritance)
12. [Polymorphism](#12-polymorphism)
13. [Protocols and interfaces](#13-protocols-and-interfaces)
14. [Abstract base classes vs protocols](#14-abstract-base-classes-vs-protocols)
15. [Composition and object relationships](#15-composition-and-object-relationships)
16. [Generics with OOP](#16-generics-with-oop)
17. [Collections and object queries](#17-collections-and-object-queries)
18. [Equality and object comparison](#18-equality-and-object-comparison)
19. [Classes, dataclasses, named tuples, and immutability](#19-classes-dataclasses-named-tuples-and-immutability)
20. [None safety and optional values](#20-none-safety-and-optional-values)
21. [Exceptions and custom domain errors](#21-exceptions-and-custom-domain-errors)
22. [Class attributes, constants, static methods, and utility modules](#22-class-attributes-constants-static-methods-and-utility-modules)
23. [Callbacks, events, and observer-style design](#23-callbacks-events-and-observer-style-design)
24. [Extension-style techniques](#24-extension-style-techniques)
25. [Special methods, operators, nested classes, and code organization](#25-special-methods-operators-nested-classes-and-code-organization)
26. [Modules, packages, environments, and project structure](#26-modules-packages-environments-and-project-structure)
27. [SOLID principles](#27-solid-principles)
28. [Dependency injection](#28-dependency-injection)
29. [Design patterns for Python OOP](#29-design-patterns-for-python-oop)
30. [Domain modeling and architecture](#30-domain-modeling-and-architecture)
31. [Unit testing OOP code](#31-unit-testing-oop-code)
32. [Refactoring OOP code](#32-refactoring-oop-code)
33. [Common OOP mistakes](#33-common-oop-mistakes)
34. [Hands-on projects](#34-hands-on-projects)
35. [Complete capstone project: Library Management System](#35-complete-capstone-project-library-management-system)
36. [Professional checklist](#36-professional-checklist)
37. [30-day learning plan](#37-30-day-learning-plan)
38. [Glossary](#38-glossary)
39. [Reference links](#39-reference-links)

</details>

---

# 1. Prerequisites and setup

> 📌 **In plain words:** Before building with OOP "LEGO bricks," you need to know what a brick is. This section makes sure you have the basics and a working Python playground.

## 1.1 ✅ What you should know first

Before OOP, you should be comfortable with these building blocks:

- Variables
- Data types
- Operators
- `if`, `elif`, `else`
- `match` basics (if using Python 3.10 or newer)
- Loops
- Lists, tuples, dictionaries, and sets
- Basic functions
- Basic input/output
- Basic debugging
- Importing modules

> [!TIP]
> **You do NOT need** Django, Flask, FastAPI, databases, cloud knowledge, or advanced data science to start OOP. Those come later. OOP is a *foundation*, not an advanced topic.

## 1.2 ⬇️ Install Python

Install Python from the official site:

- https://www.python.org/downloads/

Check your installation:

```bash
python --version
```

Depending on your operating system, you may need:

```bash
python3 --version
```

🛠️ **Create a project folder and a virtual environment (your isolated sandbox):**

```bash
mkdir oop_practice
cd oop_practice
python -m venv .venv
```

Activate the virtual environment:

```bash
# Windows PowerShell
.venv\Scripts\Activate.ps1

# macOS/Linux
source .venv/bin/activate
```

Create your first Python file and run it:

```bash
touch main.py
python main.py
```

Install useful development tools:

```bash
pip install pytest mypy ruff
```

> 🌍 **Real-world analogy:** A virtual environment (`.venv`) is like a **separate toolbox for each project**. Tools in one toolbox never get mixed up with another project's tools, so nothing breaks unexpectedly.

📁 **Recommended simple project layout:**

```text
oop_practice/
├── .venv/
├── src/
│   └── oop_practice/
│       ├── __init__.py
│       └── main.py
├── tests/
│   └── test_examples.py
└── pyproject.toml
```

---

# 2. What OOP means

> 📌 **In plain words:** Object-Oriented Programming is a way of designing software around **objects** — self-contained "things" that bundle their data and the actions you can perform on that data, all in one place.

> 🌍 **Real-world analogy:** Think of a **vending machine**. It has *data* (how much money you inserted, what's in stock) and *behavior* (accept coins, dispense a snack, give change). You don't reach inside and rearrange the wiring — you press the buttons it *offers* you. An object works exactly the same way.

An object combines four things:

| Ingredient | Meaning | Vending-machine example |
|---|---|---|
| 🧾 **Data** | attributes | money inserted, stock count |
| ⚙️ **Behavior** | methods | dispense snack, give change |
| 📏 **Rules** | validation & business logic | "no snack unless enough money" |
| 🆔 **Identity** | what makes this object unique | *this* machine vs. the one next door |

🛠️ **Example — a bank account modeled as an object:**

```python
class BankAccount:
    def __init__(self, account_number: str, opening_balance: float) -> None:
        if opening_balance < 0:
            raise ValueError("Opening balance cannot be negative.")

        self.account_number = account_number
        self._balance = opening_balance

    def deposit(self, amount: float) -> None:
        if amount <= 0:
            raise ValueError("Amount must be positive.")

        self._balance += amount

    def get_balance(self) -> float:
        return self._balance
```

**Usage:**

```python
account = BankAccount("ACC-1001", 100.0)
account.deposit(50.0)
print(account.get_balance())
```

This class represents a real concept: a bank account. It holds money (data), lets you deposit (behavior), and refuses negative balances (rules).

> 🎯 **When to use OOP:** whenever you're modeling "things" that have both data *and* rules about that data — accounts, orders, users, products, documents. If you find yourself passing the same bundle of variables into many functions, that bundle probably wants to be an object.

> [!NOTE]
> **🐍 Python style notes:**
> - Python uses `self` to refer to the current object.
> - Python usually uses `snake_case` for methods and attributes.
> - Python relies on **conventions** more than strict access modifiers.
> - Type hints (like `: float`) are optional at runtime, but very useful for readability and tools.

---

# 3. The four pillars of OOP

> 📌 **In plain words:** All of OOP rests on four big ideas. Learn these names — every job interview and every codebase uses them.

| 🏛️ Pillar | Meaning | Python tools |
|---|---|---|
| **Encapsulation** | Protect data and expose safe operations | naming conventions, properties, methods |
| **Abstraction** | Show what matters, hide the details | abstract base classes, protocols, duck typing |
| **Inheritance** | Create specialized types from base types | subclassing, `super()`, method overriding |
| **Polymorphism** | Use one abstraction with many implementations | duck typing, protocols, ABCs, overriding |

💡 **Simple memory rule:**

- 🔒 **Encapsulation** *protects.*
- 🎭 **Abstraction** *simplifies.*
- 🧬 **Inheritance** *reuses and specializes.*
- 🔀 **Polymorphism** *makes code flexible.*

> 🌍 **Real-world analogy for all four (a car):**
> - **Encapsulation** 🔒 — you use the pedals, not the raw fuel injectors.
> - **Abstraction** 🎭 — the dashboard shows speed, not engine physics.
> - **Inheritance** 🧬 — a *sports car* is a *car* with extra abilities.
> - **Polymorphism** 🔀 — every car has a "brake," but each brakes in its own way.

### 🦆 Python's bonus idea: duck typing

Python adds an important idea: **duck typing**.

> "If it walks like a duck and quacks like a duck, it's a duck." 🦆

If an object *behaves* like what your code needs, Python often does not care about its exact class.

```python
class PdfReport:
    def print_report(self) -> None:
        print("Printing PDF report.")

class ExcelReport:
    def print_report(self) -> None:
        print("Printing Excel report.")

def print_any_report(report) -> None:
    report.print_report()

print_any_report(PdfReport())
print_any_report(ExcelReport())
```

> 🎯 **When it helps:** `print_any_report` doesn't care *what* the object is — only that it can `print_report()`. This keeps code flexible and short.

---

# 4. Classes and objects

> 📌 **In plain words:** A **class** is the recipe. An **object** is the cake you bake from it. One recipe → many cakes.

## 4.1 🏗️ Class — the blueprint

A class is a blueprint.

```python
class Car:
    def __init__(self, brand: str, model: str, year: int) -> None:
        self.brand = brand
        self.model = model
        self.year = year

    def start(self) -> None:
        print(f"{self.brand} {self.model} is starting.")
```

> 🌍 **Analogy:** The `Car` class is like the **architect's drawing** of a house. No one lives in a drawing — but you can build many houses from it.

## 4.2 🚗 Object — an instance of a class

An object is an instance of a class.

```python
car = Car("Toyota", "Corolla", 2024)
car.start()
```

> 🎯 **When to use:** Create a new object every time you need a new, independent "thing" with its own data.

## 4.3 🧾 Object attributes

Attributes are values stored on an object.

```python
print(car.brand)
print(car.model)
print(car.year)
```

## 4.4 🏷️ Object creation with keyword arguments

Keyword arguments make object creation clearer and safer — you can *see* what each value means.

```python
car = Car(
    brand="Toyota",
    model="Corolla",
    year=2024,
)
```

> 💡 **Pro tip:** Prefer keyword arguments when a constructor has several parameters. `Car("Toyota", "Corolla", 2024)` is easy to get wrong; `Car(brand=..., model=..., year=...)` is self-documenting.

## 4.5 ⚡ Dataclass option — less typing

For simple data containers, Python's `dataclasses` module can reduce boilerplate (it writes `__init__` for you).

```python
from dataclasses import dataclass

@dataclass
class Car:
    brand: str
    model: str
    year: int

    def start(self) -> None:
        print(f"{self.brand} {self.model} is starting.")
```

> 🎯 **When to use a dataclass:** when the class mostly *holds data*. (Deep dive in [Section 19](#19-classes-dataclasses-named-tuples-and-immutability).)

## 4.6 🧪 Hands-on exercise

Create a `Student` class with:

- `name`
- `age`
- `grade`
- `display_info()`

**Expected result:**

```text
Name: Anna
Age: 22
Grade: A
```

**Starter code:**

```python
class Student:
    def __init__(self, name: str, age: int, grade: str) -> None:
        self.name = name
        self.age = age
        self.grade = grade

    def display_info(self) -> None:
        print(f"Name: {self.name}")
        print(f"Age: {self.age}")
        print(f"Grade: {self.grade}")

student = Student("Anna", 22, "A")
student.display_info()
```

---

# 5. Attributes, properties, and methods

> 📌 **In plain words:** **Attributes** are what an object *knows*. **Methods** are what an object *does*. **Properties** are attributes with a bouncer at the door — checking values before letting them in.

## 5.1 Attributes

Attributes store data inside an object.

```python
class Product:
    def __init__(self) -> None:
        self._price = 0.0
```

> [!NOTE]
> Python has no truly private fields like some other languages. A leading underscore (`_price`) means: **"internal detail; please don't touch this directly from outside."** It's a polite sign, not a locked door.

## 5.2 🌐 Public attributes

For simple data, public attributes are perfectly normal in Python.

```python
class Product:
    def __init__(self, name: str, price: float) -> None:
        self.name = name
        self.price = price
```

**Usage:**

```python
product = Product("Mouse", 25.0)
print(product.name)
print(product.price)
```

> 🎯 **When to use plain public attributes:** when there are no rules to enforce — any value is acceptable.

## 5.3 🛡️ Property with validation

Use `@property` when you need validation or computed behavior.

```python
class Product:
    def __init__(self, name: str, price: float) -> None:
        self.name = name
        self._price = 0.0
        self.price = price

    @property
    def price(self) -> float:
        return self._price

    @price.setter
    def price(self, value: float) -> None:
        if value < 0:
            raise ValueError("Price cannot be negative.")

        self._price = value
```

**Usage:**

```python
product = Product("Keyboard", 50.0)
product.price = 60.0
```

> 🌍 **Analogy:** A property is a **security guard at a nightclub door**. To the outside, `product.price` looks like an ordinary attribute — but every time you set it, the guard (`setter`) checks the value first and rejects anything invalid.

> 🎯 **When to use:** when setting/reading a value needs a rule, a calculation, or logging — but you still want the clean `object.attribute` syntax.

## 5.4 🔒 Read-only property

A read-only property has a getter but no setter — the outside world can look, but not change.

```python
from datetime import datetime, timezone

class Order:
    def __init__(self) -> None:
        self._created_at = datetime.now(timezone.utc)

    @property
    def created_at(self) -> datetime:
        return self._created_at
```

> 🎯 **When to use:** for values that should never change after creation, like a "created at" timestamp or an ID.

## 5.5 🚪 Private setter style

Python does not have private setters, but you can expose a read-only property and update it only through methods.

```python
class BankAccount:
    def __init__(self) -> None:
        self._balance = 0.0

    @property
    def balance(self) -> float:
        return self._balance

    def deposit(self, amount: float) -> None:
        if amount <= 0:
            raise ValueError("Amount must be positive.")
        self._balance += amount
```

> 💡 **Pro tip:** This is the classic "you can *read* the balance, but you can only *change* it through `deposit()`/`withdraw()`" pattern — the heart of safe money handling.

## 5.6 🧮 Computed property

A property can *calculate* its value on the fly instead of storing it.

```python
class OrderLine:
    def __init__(self, unit_price: float, quantity: int) -> None:
        self.unit_price = unit_price
        self.quantity = quantity

    @property
    def total(self) -> float:
        return self.unit_price * self.quantity
```

> 🎯 **When to use:** when a value is *derived* from other values (`total = price × quantity`). Storing it separately risks the two getting out of sync.

## 5.7 ⚙️ Methods

Methods define behavior.

```python
class Calculator:
    def add(self, a: int, b: int) -> int:
        return a + b
```

**Usage:**

```python
calculator = Calculator()
print(calculator.add(2, 3))
```

## 5.8 🔤 Method naming

Common Python convention (verbs, lowercase, underscores):

```text
calculate_total
send_email
get_by_id
is_available
```

> ⚠️ **Avoid** C#/Java style names such as `CalculateTotal` in normal Python code. Python uses `snake_case`.

## 5.9 🔁 Method overloading in Python

> 📌 **In plain words:** Some languages let you define the *same method name* several times with different parameters. Python does **not** — the last definition simply wins.

If you define the same method name twice, the second definition replaces the first. Instead, Python offers three clean alternatives:

**Option 1 — Default arguments:**

```python
class Calculator:
    def add(self, a: float, b: float, c: float = 0) -> float:
        return a + b + c
```

**Option 2 — Variable arguments:**

```python
class Calculator:
    def add(self, *numbers: float) -> float:
        return sum(numbers)
```

**Option 3 — `functools.singledispatchmethod`** (only when you truly need type-based dispatch):

```python
from functools import singledispatchmethod

class Printer:
    @singledispatchmethod
    def print_value(self, value) -> None:
        print(value)

    @print_value.register
    def _(self, value: int) -> None:
        print(f"Integer: {value}")

    @print_value.register
    def _(self, value: str) -> None:
        print(f"String: {value}")
```

> 🎯 **When to use which:** reach for **default arguments** first (simplest), **`*args`** when the count varies, and **`singledispatchmethod`** only when behavior genuinely depends on the *type* of the argument.

---

# 6. Constructors and object initialization

> 📌 **In plain words:** A **constructor** is the setup routine that runs the moment an object is born. In Python it's the `__init__` method — it fills in the object's starting data.

> 🌍 **Analogy:** Buying a new phone. The constructor is the **first-time setup wizard**: choose language, sign in, set a name. After it finishes, the phone (object) is ready to use.

In Python, `__init__` initializes an object *after* it is created.

## 6.1 Basic constructor

```python
class Student:
    def __init__(self, name: str, age: int) -> None:
        self.name = name
        self.age = age
```

**Usage:**

```python
student = Student("Anna", 22)
```

## 6.2 🎚️ Default values

Give parameters defaults so callers can skip them.

```python
class Student:
    def __init__(self, name: str = "Unknown") -> None:
        self.name = name
```

**Usage:**

```python
student = Student()
```

> 🎯 **When to use:** when a sensible fallback exists (e.g., `quantity=1`, `country="US"`).

## 6.3 🏭 Constructor alternatives with class methods

Python does not support multiple `__init__` methods. Use **class methods as named constructors** ("factory methods").

```python
class Product:
    def __init__(self, name: str, price: float) -> None:
        self.name = name
        self.price = price

    @classmethod
    def free(cls, name: str) -> "Product":
        return cls(name, 0.0)
```

**Usage:**

```python
product = Product.free("Sample")
```

> 🌍 **Analogy:** A coffee shop has one machine (`__init__`) but named buttons on top of it — "Espresso," "Latte," "Free Sample." `Product.free(...)` is a friendly button that pre-fills the details for you.

> 🎯 **When to use:** when you want several clear, well-named ways to build the same object.

## 6.4 ✅ Constructor validation

Reject bad data at the moment of creation — never let an invalid object exist.

```python
class Product:
    def __init__(self, name: str, price: float) -> None:
        if not name.strip():
            raise ValueError("Name is required.")
        if price < 0:
            raise ValueError("Price cannot be negative.")

        self.name = name
        self.price = price
```

> 💡 **Pro tip:** "Fail fast." If an object can't be valid, refuse to build it. This prevents mysterious bugs much later.

## 6.5 🧬 Base constructor with `super()`

When a class inherits from another, call the parent's constructor with `super()`.

```python
class Person:
    def __init__(self, name: str) -> None:
        self.name = name

class Student(Person):
    def __init__(self, name: str, grade: str) -> None:
        super().__init__(name)
        self.grade = grade
```

> 🌍 **Analogy:** Filling out a form. `super().__init__(name)` fills in the general "Person" section; then the `Student` adds its own extra fields.

## 6.6 🔐 Private constructor style

Python cannot make constructors truly private, but you can *signal intent* and provide factory methods.

```python
class AppSettings:
    def __init__(self, environment: str) -> None:
        self.environment = environment

    @classmethod
    def create_development(cls) -> "AppSettings":
        return cls("Development")
```

If you need stricter control, validate inside `__init__` or use a factory function.

## 6.7 🧱 `__new__`

> 📌 **In plain words:** `__new__` *creates* the object; `__init__` *fills it in*. You rarely touch `__new__` in everyday code.

Common uses:

- Immutable types
- Singleton-like behavior
- Subclassing built-in immutable types

```python
class UppercaseString(str):
    def __new__(cls, value: str):
        return super().__new__(cls, value.upper())
```

> ⚠️ **When to avoid:** almost always. If you're reaching for `__new__` in application code, pause and check whether `__init__` or a factory method would be clearer.

## 6.8 ⚡ Dataclass initialization

```python
from dataclasses import dataclass

@dataclass
class Person:
    name: str
    age: int
```

**Usage:**

```python
person = Person("Anna", 22)
```

## 6.9 🩺 Dataclass post-initialization

Use `__post_init__` for validation *after* dataclass initialization.

```python
from dataclasses import dataclass

@dataclass
class Product:
    name: str
    price: float

    def __post_init__(self) -> None:
        if not self.name.strip():
            raise ValueError("Name is required.")
        if self.price < 0:
            raise ValueError("Price cannot be negative.")
```

> 🎯 **When to use:** you love the auto-generated `__init__` of a dataclass but still need validation rules.

## 6.10 🧪 Hands-on exercise

Create a `BankAccount` with:

- `account_holder`
- `balance`
- constructor
- `deposit`
- `withdraw`
- a minimum balance rule

---

# 7. Access conventions

> 📌 **In plain words:** Python doesn't lock doors — it puts up *signs*. There's no `public`/`private`/`protected` keyword. Instead, **underscores signal how you should treat a name.**

Python does not have C#-style access modifiers such as `public`, `private`, and `protected`. Instead, Python uses naming conventions.

| Convention | Meaning |
|---|---|
| `name` | 🌐 Public API — use freely |
| `_name` | 🔧 Internal/protected-like detail; use with care outside the class/module |
| `__name` | 🚧 Name-mangled to reduce accidental subclass conflicts |
| `__name__` | ✨ Special method or attribute controlled by Python |

> 🌍 **Analogy:** It's like signs in an office. `name` = **"Reception, welcome!"**. `_name` = **"Staff only"** (you *can* walk in, but you shouldn't). `__name__` = **"Building systems, controlled by management."**

**Example:**

```python
class BankAccount:
    def __init__(self, opening_balance: float) -> None:
        self._balance = opening_balance

    def get_balance(self) -> float:
        return self._balance

    def _apply_interest(self, rate: float) -> None:
        self._balance += self._balance * rate
```

> [!IMPORTANT]
> **Professional rule:** Start with a small public API. Treat everything else as an implementation detail.

## 7.1 🚧 Name mangling

Double-leading-underscore names are *name-mangled*.

```python
class Example:
    def __init__(self) -> None:
        self.__secret = "hidden-ish"
```

Python changes `__secret` internally to something like `_Example__secret`.

> ⚠️ **Reality check:** This is **not** real security. It mainly prevents accidental name clashes in subclasses. Anyone determined can still access it.

## 7.2 📦 Module-level privacy

A leading underscore on a module-level function or class means "internal."

```python
def _helper_function() -> None:
    pass
```

You can also control wildcard imports with `__all__`:

```python
__all__ = ["BankAccount"]
```

> 🎯 **When to use `__all__`:** when you publish a module/package and want to declare its official, supported public names.

---

# 8. Object lifecycle and resource management

> 📌 **In plain words:** Objects are born, get used, and eventually cleaned up. Most cleanup is automatic — but some resources (files, connections) must be closed *promptly*, and that's your job.

## 8.1 👶 Object creation

```python
customer = Customer("Anna")
```

Python creates the object, then calls `__init__`.

## 8.2 🔗 Object references

Most Python variables hold **references** to objects — like two remote controls pointing at the same TV.

```python
class Customer:
    def __init__(self, name: str) -> None:
        self.name = name

customer_a = Customer("Anna")
customer_b = customer_a

customer_b.name = "Maria"

print(customer_a.name)  # Maria
```

Both variables point to the **same** object, so changing one changes "both."

> ⚠️ **Common beginner surprise:** `customer_b = customer_a` does **not** make a copy. It makes a second label for the same object.

## 8.3 🗑️ Garbage collection basics

Python automatically manages memory. CPython uses **reference counting** plus a **cycle detector**. You normally do not manually free memory.

> 🌍 **Analogy:** Like a hotel housekeeping service — once nobody is "using a room" (no references), it gets cleaned up automatically.

## 8.4 🔌 Resources that must be closed

Some resources should be released promptly:

- 📄 Files
- 🌐 Network connections
- 🗄️ Database connections
- 🔒 Locks
- 📁 Temporary directories
- 🔌 Sockets

Use **context managers** (the `with` statement):

```python
with open("report.txt", "w", encoding="utf-8") as file:
    file.write("Hello\n")
```

The file is closed automatically when the block exits — even if an error happens.

> 🌍 **Analogy:** `with` is like a **self-closing door**. You walk through, do your thing, and it shuts behind you automatically — you can never forget to close it.

## 8.5 🛠️ Custom context manager class

```python
class ReportWriter:
    def __init__(self, path: str) -> None:
        self.path = path
        self._file = None

    def __enter__(self) -> "ReportWriter":
        self._file = open(self.path, "w", encoding="utf-8")
        return self

    def write(self, text: str) -> None:
        if self._file is None:
            raise RuntimeError("Writer is not open.")
        self._file.write(text + "\n")

    def __exit__(self, exc_type, exc_value, traceback) -> None:
        if self._file is not None:
            self._file.close()
```

**Usage:**

```python
with ReportWriter("report.txt") as writer:
    writer.write("Hello")
```

## 8.6 🎀 Context manager with decorator

A shorter way, using `@contextmanager`:

```python
from contextlib import contextmanager

@contextmanager
def report_writer(path: str):
    file = open(path, "w", encoding="utf-8")
    try:
        yield file
    finally:
        file.close()
```

**Usage:**

```python
with report_writer("report.txt") as file:
    file.write("Hello\n")
```

> 🎯 **When to use which:** the `@contextmanager` decorator is quicker for simple cases; a full class is better when the resource needs extra methods or state.

## 8.7 ⚰️ Destructors with `__del__`

`__del__` is rarely needed and can be unpredictable (you can't reliably know *when* it runs).

```python
class NativeResourceWrapper:
    def __del__(self) -> None:
        # Cleanup fallback only.
        pass
```

> ⚠️ **When to avoid:** almost always. **Prefer context managers over `__del__` for resource cleanup.** Treat `__del__` as a last-resort safety net, never your main plan.

---

# 9. Encapsulation

> 📌 **In plain words:** Encapsulation means **protecting an object's internal state** and only allowing changes through valid, controlled operations. The object guards its own data.

> 🌍 **Analogy:** An **ATM**. You can't reach inside and rewrite your balance to a billion dollars. You can only `deposit` or `withdraw` through approved buttons — each with rules. The cash and the balance are *encapsulated*.

## 9.1 ❌ Bad encapsulation

```python
class BankAccount:
    def __init__(self) -> None:
        self.balance = 0.0
```

**Problem:**

```python
account = BankAccount()
account.balance = -999999
```

The object happily allows **invalid state**. Nothing stops a negative balance.

## 9.2 ✅ Better encapsulation

```python
class BankAccount:
    def __init__(self, account_holder: str, opening_balance: float) -> None:
        if opening_balance < 0:
            raise ValueError("Opening balance cannot be negative.")

        self.account_holder = account_holder
        self._balance = opening_balance

    @property
    def balance(self) -> float:
        return self._balance

    def deposit(self, amount: float) -> None:
        if amount <= 0:
            raise ValueError("Deposit amount must be positive.")

        self._balance += amount

    def withdraw(self, amount: float) -> None:
        if amount <= 0:
            raise ValueError("Withdraw amount must be positive.")

        if amount > self._balance:
            raise ValueError("Insufficient balance.")

        self._balance -= amount
```

> 🎯 **When to encapsulate:** whenever invalid data would cause bugs or break business rules — which is *most* of the time for real objects.

## 9.3 📦 Protecting collections

**Bad — the internal list is exposed and mutable:**

```python
class Order:
    def __init__(self) -> None:
        self.items = []
```

External code can freely mutate the list, bypassing all your rules.

**Better — hand out a read-only copy:**

```python
class Order:
    def __init__(self) -> None:
        self._items: list[OrderItem] = []

    @property
    def items(self) -> tuple[OrderItem, ...]:
        return tuple(self._items)

    def add_item(self, item: "OrderItem") -> None:
        if item is None:
            raise ValueError("Item is required.")

        self._items.append(item)
```

> 💡 **Pro tip:** Returning a `tuple` prevents callers from accidentally modifying your internal list. They get a snapshot, not the keys to your house.

## 9.4 🧷 Invariants

An **invariant** is a rule that must *always* be true for an object.

Examples:

- 💰 Bank balance cannot be below the minimum.
- 🛒 Order cannot be completed without items.
- 📧 Email address cannot be empty.
- 🏷️ Product price cannot be negative.

> [!IMPORTANT]
> OOP design should **protect invariants inside the object** — not scatter the checks across the whole program. The object is the single source of truth for its own rules.

---

# 10. Abstraction

> 📌 **In plain words:** Abstraction means showing the **essential idea** and hiding the messy details. You expose *what* something does, not *how* it does it.

> 🌍 **Analogy:** A **TV remote**. You press "volume up." You have no idea about the electrical signals, infrared codes, or circuitry — and you don't need to. The remote *abstracts* all that away.

Python supports abstraction through:

- 🦆 Duck typing
- 🏛️ Abstract base classes
- 📐 Protocols
- 🎯 Clear public APIs

## 10.1 🏛️ Abstract base class

```python
from abc import ABC, abstractmethod

class Shape(ABC):
    @abstractmethod
    def calculate_area(self) -> float:
        pass

    def display_area(self) -> None:
        print(f"Area: {self.calculate_area()}")
```

```python
import math

class Circle(Shape):
    def __init__(self, radius: float) -> None:
        self.radius = radius

    def calculate_area(self) -> float:
        return math.pi * self.radius * self.radius
```

**Usage:**

```python
shape: Shape = Circle(5)
shape.display_area()
```

> 🌍 **Analogy:** `Shape` is a **job description** that says "every shape MUST know how to calculate its area." It refuses to hire (instantiate) any shape that can't.

## 10.2 📝 Abstract methods

```python
from abc import ABC, abstractmethod

class Payment(ABC):
    @abstractmethod
    def pay(self, amount: float) -> None:
        pass
```

> 🎯 A subclass **must** implement `pay` before it can be instantiated. This enforces the contract at runtime.

## 10.3 🔄 Regular overridable methods

Any normal Python method can be overridden.

```python
class Report:
    def print_report(self) -> None:
        print("Printing report.")

class PdfReport(Report):
    def print_report(self) -> None:
        print("Printing PDF report.")
```

## 10.4 🧩 Template method style

An abstract class can define a *workflow* and leave specific steps to subclasses.

```python
from abc import ABC, abstractmethod

class DataImporter(ABC):
    def import_data(self) -> None:
        data = self.read_data()
        cleaned = self.clean_data(data)
        self.save_data(cleaned)

    @abstractmethod
    def read_data(self) -> list[str]:
        pass

    def clean_data(self, data: list[str]) -> list[str]:
        return [line.strip() for line in data]

    @abstractmethod
    def save_data(self, data: list[str]) -> None:
        pass
```

> 🌍 **Analogy:** A **recipe template**: "read ingredients → clean them → cook." The overall steps are fixed, but *how* you read and save is filled in by each specific importer (CSV, database, API).

> 🎯 **When to use the template method:** when several classes share the *same overall process* but differ in a few steps.

---

# 11. Inheritance

> 📌 **In plain words:** Inheritance lets a new class **reuse and extend** an existing class. The child gets everything the parent has, plus its own extras.

> 🌍 **Analogy:** A **child inheriting traits** from a parent — same eye color and last name (reused), but with their own personality (extended).

## 11.1 Basic inheritance

```python
class Employee:
    def __init__(self, name: str, salary: float) -> None:
        self.name = name
        self.salary = salary

    def display(self) -> None:
        print(f"{self.name}: {self.salary}")

class Manager(Employee):
    def __init__(self, name: str, salary: float, department: str) -> None:
        super().__init__(name, salary)
        self.department = department
```

**Usage:**

```python
manager = Manager("Anna", 90000, "Engineering")
manager.display()          # inherited from Employee
print(manager.department)  # added by Manager
```

## 11.2 ✅ The `is-a` rule

> [!IMPORTANT]
> Use inheritance **only** when the derived type truly **is a** kind of the base type.

**✅ Good ("is-a" holds):**

```text
Dog is an Animal.
Manager is an Employee.
Circle is a Shape.
```

**❌ Bad (should be composition, not inheritance):**

```text
Car is an Engine.          ← A car HAS an engine, it isn't one.
Order is a DatabaseConnection.
Invoice is a Printer.
```

## 11.3 🔧 Method overriding

A child can replace a parent's behavior.

```python
class Animal:
    def make_sound(self) -> None:
        print("Some sound.")

class Dog(Animal):
    def make_sound(self) -> None:
        print("Dog barks.")
```

## 11.4 ⬆️ Calling base behavior with `super()`

Extend the parent's behavior instead of fully replacing it.

```python
class AuditedBankAccount(BankAccount):
    def deposit(self, amount: float) -> None:
        print(f"Deposit requested: {amount}")
        super().deposit(amount)
        print("Deposit completed.")
```

> 🎯 **When to use `super()`:** when you want to *add* something around existing behavior (like logging), not throw it away.

## 11.5 🚫 Preventing inheritance

Python does not enforce `sealed` classes at runtime like C#, but type checkers understand `@final`.

```python
from typing import final

@final
class SecurityToken:
    pass
```

> 🎯 This is mainly for **static type checking** — a signal to tools and readers: "do not subclass this."

## 11.6 🧩 Multiple inheritance

Python supports inheriting from more than one class.

```python
class Printable:
    def print_info(self) -> None:
        print("Printable")

class Serializable:
    def serialize(self) -> dict:
        return {}

class Invoice(Printable, Serializable):
    pass
```

> ⚠️ **Use with care.** Multiple inheritance can get confusing fast. Prefer small, focused **mixins** when it genuinely improves clarity.

## 11.7 🏚️ The fragile base class problem

> [!WARNING]
> Inheritance creates **tight coupling**. A change in a base class can silently break every derived class.

> [!IMPORTANT]
> **Professional rule:** Use inheritance for *true specialization*, not just to avoid retyping code. When in doubt, prefer **composition** ([Section 15](#15-composition-and-object-relationships)).

---

# 12. Polymorphism

> 📌 **In plain words:** Polymorphism ("many forms") means one instruction can work with many different types — each responding in its own way.

> 🌍 **Analogy:** You say **"make a sound"** to a dog, a cat, and a cow. Same command, three different results: *bark*, *meow*, *moo*. That's polymorphism.

## 12.1 🧬 Runtime polymorphism with inheritance

```python
from abc import ABC, abstractmethod

class Animal(ABC):
    @abstractmethod
    def make_sound(self) -> None:
        pass

class Dog(Animal):
    def make_sound(self) -> None:
        print("Dog barks.")

class Cat(Animal):
    def make_sound(self) -> None:
        print("Cat meows.")
```

**Usage:**

```python
animals: list[Animal] = [Dog(), Cat()]

for animal in animals:
    animal.make_sound()
```

> 🎯 The loop doesn't care *which* animal it holds — it just says "make your sound," and each one responds correctly.

## 12.2 🦆 Duck typing polymorphism

Python often does not require a shared base class at all.

```python
class EmailSender:
    def send(self, message: str) -> None:
        print(f"Email: {message}")

class SmsSender:
    def send(self, message: str) -> None:
        print(f"SMS: {message}")

def notify(sender, message: str) -> None:
    sender.send(message)

notify(EmailSender(), "Welcome")
notify(SmsSender(), "Welcome")
```

> 💡 As long as the object *has* a `send` method, `notify` is happy. No inheritance needed.

## 12.3 📐 Protocol polymorphism

Protocols make duck typing **explicit** for type checkers (best of both worlds).

```python
from typing import Protocol

class PaymentProcessor(Protocol):
    def process(self, amount: float) -> None:
        ...

class CardPaymentProcessor:
    def process(self, amount: float) -> None:
        print(f"Card payment: {amount}")

class PayPalPaymentProcessor:
    def process(self, amount: float) -> None:
        print(f"PayPal payment: {amount}")

def checkout(processor: PaymentProcessor, amount: float) -> None:
    processor.process(amount)
```

## 12.4 🔀 Replace conditional with polymorphism

This is one of the most valuable refactorings in all of OOP.

**❌ Bad — a growing pile of `if`s:**

```python
def calculate_discount(customer_type: str) -> float:
    if customer_type == "regular":
        return 0.05
    if customer_type == "premium":
        return 0.10
    return 0.0
```

**✅ Better — each type owns its own behavior:**

```python
from typing import Protocol

class DiscountPolicy(Protocol):
    def get_discount(self) -> float:
        ...

class RegularDiscountPolicy:
    def get_discount(self) -> float:
        return 0.05

class PremiumDiscountPolicy:
    def get_discount(self) -> float:
        return 0.10
```

**Usage:**

```python
def calculate_discount(policy: DiscountPolicy) -> float:
    return policy.get_discount()
```

> 🎯 **When to use this:** when you see a big `if/elif` or `match` that branches on a "type" string. Adding a new customer type should mean adding a *class*, not editing old logic.

---

# 13. Protocols and interfaces

> 📌 **In plain words:** A **protocol** describes a *capability* — a list of methods an object must have — without caring about its class. It's a contract based on behavior, not family tree.

Python does not have a dedicated `interface` keyword. The closest tools are:

- 📐 Protocols from `typing`
- 🏛️ Abstract base classes from `abc`
- 🦆 Duck typing

> 🌍 **Analogy:** A **power socket standard**. Any device with the right plug shape fits — the socket doesn't care who made the device. The plug shape *is* the protocol.

## 13.1 Basic protocol

```python
from typing import Protocol

class Printable(Protocol):
    def print_item(self) -> None:
        ...
```

```python
class Invoice:
    def print_item(self) -> None:
        print("Printing invoice.")
```

**Usage:**

```python
def print_document(document: Printable) -> None:
    document.print_item()

print_document(Invoice())
```

> 💡 `Invoice` does **not** need to inherit from `Printable`. It only needs to *have* the required method. This is "structural typing."

## 13.2 🧰 Multiple capabilities

```python
from typing import Protocol

class Printer(Protocol):
    def print_item(self) -> None:
        ...

class Scanner(Protocol):
    def scan(self) -> None:
        ...

class MultiFunctionDevice:
    def print_item(self) -> None:
        print("Printing.")

    def scan(self) -> None:
        print("Scanning.")
```

## 13.3 🏷️ Protocol properties

```python
from typing import Protocol

class Entity(Protocol):
    @property
    def id(self) -> int:
        ...
```

## 13.4 🔍 Runtime-checkable protocols

Protocols are mainly for static type checking. Use `@runtime_checkable` when you need `isinstance` checks.

```python
from typing import Protocol, runtime_checkable

@runtime_checkable
class Printable(Protocol):
    def print_item(self) -> None:
        ...

invoice = Invoice()
print(isinstance(invoice, Printable))
```

> ⚠️ Only simple structural checks are supported at runtime (it checks *method names* exist, not their signatures).

## 13.5 🧱 Generic protocol

```python
from typing import Protocol, TypeVar

T = TypeVar("T")

class Repository(Protocol[T]):
    def add(self, item: T) -> None:
        ...

    def get_by_id(self, item_id: int) -> T | None:
        ...

    def get_all(self) -> list[T]:
        ...
```

## 13.6 🔤 Naming conventions

Python protocols often use descriptive names **without** an `I` prefix.

**Common names:**

```text
Repository
Validator
CommandHandler
NotificationSender
PaymentProcessor
```

> 💡 Some teams still use names like `IRepository`, but that is less Pythonic. Prefer plain, descriptive names.

---

# 14. Abstract base classes vs protocols

> 📌 **In plain words:** Both describe contracts, but they answer different questions. **ABC:** "*what IS this?*" (identity + shared code). **Protocol:** "*what can this DO?*" (capability, no family ties).

## 14.1 🏛️ Use an abstract base class when...

- ✅ You need shared implementation.
- ✅ You need shared state.
- ✅ There is a strong `is-a` relationship.
- ✅ You want runtime enforcement that subclasses implement required methods.
- ✅ You want a base identity.

**Example:**

```python
from abc import ABC, abstractmethod

class Employee(ABC):
    def __init__(self, name: str) -> None:
        self.name = name

    @abstractmethod
    def calculate_pay(self) -> float:
        pass
```

## 14.2 📐 Use a protocol when...

- ✅ You need a capability or contract.
- ✅ Types may be unrelated.
- ✅ You want loose coupling.
- ✅ You want structural typing.
- ✅ You want easy testing and substitution.

**Example:**

```python
from typing import Protocol

class EmailSender(Protocol):
    def send(self, to: str, subject: str, body: str) -> None:
        ...
```

## 14.3 📏 Professional rule

> [!IMPORTANT]
> **Abstract base classes model _identity_. Protocols model _capability_.**

| Statement | Use |
|---|---|
| Manager **is an** Employee | 🏛️ ABC / base class |
| Manager **can approve** expenses | 📐 Protocol |
| Invoice **can be** printed | 📐 Protocol |
| Dog **is an** Animal | 🏛️ ABC / base class |

## 14.4 ⚠️ Avoid unnecessary abstractions

> [!WARNING]
> Do **not** create a protocol or abstract base class for *every* class. That's over-engineering.

Create abstractions only when you need:

- 🔁 Multiple implementations
- 🧪 Testing substitution
- 🔄 Dependency inversion
- 🧱 A stable boundary between layers
- 🔌 Plugin-like behavior

---

# 15. Composition and object relationships

> 📌 **In plain words:** Composition means **building objects out of other objects** — "has-a" instead of "is-a." It's usually more flexible than inheritance.

> [!TIP]
> **Professional OOP relies heavily on composition.** When you're unsure between inheritance and composition, composition is usually the safer bet.

> 🌍 **Analogy:** A **car HAS an engine, HAS wheels, HAS seats**. You can swap the engine without rebuilding the whole car. That flexibility is why composition wins so often.

## 15.1 🧩 Composition example

```python
class Engine:
    def start(self) -> None:
        print("Engine started.")

class Car:
    def __init__(self, engine: Engine) -> None:
        self._engine = engine

    def start(self) -> None:
        self._engine.start()
        print("Car started.")
```

A car **has an** engine.

## 15.2 ⚖️ Inheritance vs composition

| Relationship | Prefer |
|---|---|
| Dog **is an** Animal | 🧬 Inheritance |
| Car **has an** Engine | 🧩 Composition |
| Order **has** OrderItems | 🧩 Composition |
| Customer **has** Address | 🧩 Composition |
| Report **can be** exported | 📐 Protocol / composition |

## 15.3 🤝 Association

A general relationship between objects.

```text
Teacher teaches Student.
Customer places Order.
```

```python
class Teacher:
    def teach(self, student: "Student") -> None:
        print(f"Teaching {student.name}")
```

## 15.4 🪶 Aggregation

A **weak** whole-part relationship. The part can live without the whole.

```text
Department has Employees.
Team has Players.
```

```python
class Department:
    def __init__(self, employees: list["Employee"]) -> None:
        self.employees = employees
```

> 💡 Employees can exist outside the department — if the department closes, the employees still exist.

## 15.5 🔗 Composition (strong)

A **strong** whole-part relationship. The part belongs to the whole.

```text
Order has OrderItems.
House has Rooms.
```

```python
class Order:
    def __init__(self) -> None:
        self._items: list[OrderItem] = []

    def add_item(self, product_id: int, quantity: int, unit_price: float) -> None:
        self._items.append(OrderItem(product_id, quantity, unit_price))
```

> 💡 **Aggregation vs composition:** if the "whole" is destroyed, do the parts still make sense? Employees survive a closed department (aggregation). Order items don't survive a deleted order (composition).

## 15.6 📎 Dependency

One class uses another *temporarily* (passed in, not stored long-term).

```python
from typing import Protocol

class FileWriter(Protocol):
    def write(self, text: str) -> None:
        ...

class ReportService:
    def export(self, report: "Report", writer: FileWriter) -> None:
        writer.write(report.content)
```

## 15.7 🔢 Multiplicity

Common relationships:

```text
One-to-one:   Customer has Profile.
One-to-many:  Customer has Orders.
Many-to-many: Student has Courses, Course has Students.
```

---

# 16. Generics with OOP

> 📌 **In plain words:** Generics let you write **one class or function that works with many types** while keeping type-checker safety. Write it once, reuse it for `Product`, `Customer`, anything.

> 🌍 **Analogy:** A **shipping box** 📦. The same box design holds books, shoes, or mugs. A generic `Box[T]` is that reusable box — `T` is a label saying "whatever you put in, that's what comes out."

> [!NOTE]
> Python generics are mainly for **static type checkers**. At runtime, Python remains dynamic.

## 16.1 📦 Generic class

```python
from typing import Generic, TypeVar

T = TypeVar("T")

class Box(Generic[T]):
    def __init__(self, value: T) -> None:
        self.value = value
```

**Usage:**

```python
number_box = Box[int](100)
text_box = Box[str]("Hello")
```

## 16.2 🔧 Generic function

```python
from typing import TypeVar

T = TypeVar("T")

def first(items: list[T]) -> T:
    if not items:
        raise ValueError("List cannot be empty.")
    return items[0]
```

**Usage:**

```python
name = first(["Anna", "Maria"])   # returns a str
number = first([1, 2, 3])          # returns an int
```

## 16.3 📐 Generic protocol

```python
from typing import Protocol, TypeVar

T = TypeVar("T")

class Repository(Protocol[T]):
    def add(self, item: T) -> None:
        ...

    def get_all(self) -> list[T]:
        ...
```

## 16.4 🆔 Base entity

```python
class Entity:
    def __init__(self, entity_id: int) -> None:
        self.id = entity_id
```

## 16.5 🗃️ Generic repository with a bound

```python
from typing import Generic, TypeVar

TEntity = TypeVar("TEntity", bound=Entity)

class InMemoryRepository(Generic[TEntity]):
    def __init__(self) -> None:
        self._items: list[TEntity] = []

    def add(self, item: TEntity) -> None:
        self._items.append(item)

    def get_by_id(self, item_id: int) -> TEntity | None:
        return next((item for item in self._items if item.id == item_id), None)

    def get_all(self) -> list[TEntity]:
        return list(self._items)
```

> 🎯 **When to use a generic repository:** when you need the *same* storage logic (add / get / list) for many entity types without copy-pasting it per type.

## 16.6 🎚️ TypeVar constraints and bounds

A **bound** means the type must be a subtype of a given base type.

```python
TEntity = TypeVar("TEntity", bound=Entity)
```

**Constraints** mean the type must be one of a specific set.

```python
Number = TypeVar("Number", int, float)

def double(value: Number) -> Number:
    return value * 2
```

> 💡 **Bound vs constraint:** a *bound* says "anything that IS-A Entity"; a *constraint* says "exactly `int` OR exactly `float`, nothing else."

## 16.7 📨 Generic service with protocol constraint

```python
from typing import Protocol, TypeVar, Generic

class NotificationSender(Protocol):
    def send(self, message: str) -> None:
        ...

TSender = TypeVar("TSender", bound=NotificationSender)

class NotificationService(Generic[TSender]):
    def __init__(self, sender: TSender) -> None:
        self._sender = sender

    def notify(self, message: str) -> None:
        self._sender.send(message)
```

## 16.8 🔗 Callable generics

```python
from collections.abc import Callable

Transformer = Callable[[str], int]

length_transformer: Transformer = lambda text: len(text)
print(length_transformer("Hello"))
```

## 16.9 🔀 Variance: covariance and contravariance

> 📌 **In plain words:** Variance is about *when* a "list/producer of dogs" may stand in for a "list/producer of animals." It matters mostly to static type checkers.

**Covariance** — a producer of `Dog` can be used where a producer of `Animal` is expected.

```python
from typing import Generic, TypeVar

T_co = TypeVar("T_co", covariant=True)

class Producer(Generic[T_co]):
    def __init__(self, value: T_co) -> None:
        self._value = value

    def produce(self) -> T_co:
        return self._value
```

**Contravariance** — a consumer of `Animal` can be used where a consumer of `Dog` is expected.

```python
T_contra = TypeVar("T_contra", contravariant=True)

class Consumer(Generic[T_contra]):
    def consume(self, item: T_contra) -> None:
        print(item)
```

## 16.10 🔒 Invariance

Most mutable generic containers are **invariant**.

```python
animals: list[Animal] = []
dogs: list[Dog] = []

# A type checker should reject this:
# animals = dogs
```

> 💡 **Why?** If it were allowed, you could add a `Cat` to a `list[Dog]` through the `list[Animal]` reference — a disaster waiting to happen.

## 16.11 🌍 Generics in real Python code

You'll use these constantly:

```python
list[Student]
dict[int, Product]
set[str]
Iterable[Order]
Repository[Customer]
Callable[[Order], bool]
```

## 16.12 🧪 Generics hands-on exercise

Build:

- `Entity`
- `Product(Entity)`
- `Customer(Entity)`
- `InMemoryRepository[TEntity]`
- `add`
- `get_by_id`
- `get_all`
- `remove`

Then use the **same** repository for both `Product` and `Customer`.

---

# 17. Collections and object queries

> 📌 **In plain words:** Real apps rarely have *one* object — they have lists of orders, dictionaries of products, sets of tags. This section is about storing many objects and finding the ones you want.

## 17.1 📚 Common collections

| Collection | Use when |
|---|---|
| `list[T]` | Ordered, flexible list |
| `dict[K, V]` | Fast lookup by key 🔑 |
| `set[T]` | Unique items only |
| `tuple[T, ...]` | Immutable ordered sequence 🔒 |
| `deque[T]` | Efficient queue/stack operations |
| `Iterable[T]` | Something you can loop over |
| `Sequence[T]` | Ordered, read-only-ish abstraction |
| `Mapping[K, V]` | Dictionary-like, read-only abstraction |

> 🌍 **Analogy:** A `list` is a **shopping list** (ordered, duplicates allowed). A `set` is a **guest list** (no duplicates). A `dict` is a **phone book** (look up a number by name instantly).

## 17.2 📋 List of objects

```python
class Product:
    def __init__(self, product_id: int, name: str, price: float) -> None:
        self.id = product_id
        self.name = name
        self.price = price

products = [
    Product(1, "Laptop", 1200.0),
    Product(2, "Mouse", 25.0),
]
```

## 17.3 🔑 Dictionary

```python
products_by_id: dict[int, Product] = {}

products_by_id[1] = Product(1, "Laptop", 1200.0)

product = products_by_id[1]
```

Use `.get()` when the key **may not exist** (returns `None` instead of crashing):

```python
product = products_by_id.get(999)
```

> 🎯 **When to use a dict:** when you frequently look items up by a unique key (ID, email, username). Much faster than scanning a list.

## 17.4 🔎 Querying objects with comprehensions

Python has no LINQ, but list comprehensions, generator expressions, `sorted`, `filter`, `map`, and `itertools` cover most needs.

```python
expensive_products = [
    product
    for product in products
    if product.price > 100
]

expensive_products = sorted(expensive_products, key=lambda product: product.name)
```

> 💡 Read a comprehension as a sentence: *"give me each `product` from `products` **where** its price > 100."*

## 17.5 🌊 Generator expressions

Use generators when you don't need the whole list at once — they produce items lazily, saving memory.

```python
expensive_names = (
    product.name
    for product in products
    if product.price > 100
)

for name in expensive_names:
    print(name)
```

> 🎯 **When to use a generator:** processing large data streams, or when you only loop once. Note the `( )` instead of `[ ]`.

## 17.6 ➕ Aggregation

```python
total = sum(product.price for product in products)
```

## 17.7 🗂️ Grouping with dictionaries

```python
from collections import defaultdict

products_by_category: dict[str, list[Product]] = defaultdict(list)

for product in products:
    products_by_category[product.category].append(product)
```

> 💡 `defaultdict(list)` auto-creates an empty list the first time you touch a new key — no more "does this key exist yet?" checks.

## 17.8 🛡️ Expose collections safely

**Prefer:**

```python
@property
def items(self) -> tuple[OrderItem, ...]:
    return tuple(self._items)
```

> ⚠️ Avoid exposing mutable internal lists unless external mutation is truly intended (see [Section 9.3](#93-protecting-collections)).

---

# 18. Equality and object comparison

> 📌 **In plain words:** When are two objects "equal"? Same object in memory? Or just same values? Python lets you decide.

## 18.1 🪪 Identity equality (`is`)

Two variables reference the **same** object in memory.

```python
class Customer:
    def __init__(self, name: str) -> None:
        self.name = name

customer_a = Customer("Anna")
customer_b = customer_a

print(customer_a is customer_b)  # True
```

> 💡 Use `is` for identity checks and `is None` for None checks. Use `==` for value comparison.

> 🌍 **Analogy:** `is` asks *"are these the exact same physical object?"* — like two people pointing at the *same* car. `==` asks *"do these have the same value?"* — like two identical cars off the assembly line.

## 18.2 🟰 Value equality (`__eq__`)

Two *different* objects are considered equal because their values match.

```python
class Product:
    def __init__(self, product_id: int) -> None:
        self.id = product_id

    def __eq__(self, other: object) -> bool:
        if not isinstance(other, Product):
            return NotImplemented
        return self.id == other.id

    def __hash__(self) -> int:
        return hash(self.id)
```

## 18.3 #️⃣ Why `__hash__` matters

`set` and `dict` use **hash values** to organize items quickly.

> [!IMPORTANT]
> If you override `__eq__`, think carefully about `__hash__`.
> - 🔓 **Mutable** objects should usually **not** be hashable.
> - 🔒 **Immutable** value objects can usually be hashable.

## 18.4 ⚡ Dataclasses and equality

Dataclasses provide value-based equality **for free**.

```python
from dataclasses import dataclass

@dataclass
class Money:
    amount: float
    currency: str
```

**Usage:**

```python
money_a = Money(100, "USD")
money_b = Money(100, "USD")

print(money_a == money_b)  # True
```

> 💡 This is a big reason dataclasses are popular for value objects — no hand-written `__eq__` needed.

## 18.5 🔢 Ordering

Use `order=True` for dataclasses when ordering makes sense.

```python
from dataclasses import dataclass

@dataclass(order=True)
class PriorityTask:
    priority: int
    title: str
```

> ⚠️ Be careful: ordering should represent a **meaningful business concept**, not just "whatever field comes first."

---

# 19. Classes, dataclasses, named tuples, and immutability

> 📌 **In plain words:** Python gives you several "shapes" for holding data. This section helps you pick the right one for the job.

## 19.1 🏗️ Class

- Reference object
- Usually for domain entities and services
- Supports inheritance
- Can be mutable or immutable

```python
class Customer:
    def __init__(self, customer_id: int, name: str) -> None:
        self.id = customer_id
        self.name = name
```

## 19.2 ⚡ Dataclass

Good for data-focused classes (auto-generates `__init__`, `__eq__`, `__repr__`).

```python
from dataclasses import dataclass

@dataclass
class CustomerDto:
    id: int
    name: str
```

## 19.3 🧊 Frozen dataclass

Good for **immutable** value objects — once created, they can't be changed.

```python
from dataclasses import dataclass

@dataclass(frozen=True)
class Money:
    amount: float
    currency: str
```

> 🌍 **Analogy:** A frozen dataclass is like a **printed receipt** 🧾 — you can read it forever, but you can't edit the numbers on it.

## 19.4 📇 Named tuple

Useful for small immutable record-like values.

```python
from typing import NamedTuple

class Point(NamedTuple):
    x: float
    y: float
```

## 19.5 🔄 `replace` for immutable objects

Since you can't edit a frozen object, you make a *modified copy*.

```python
from dataclasses import replace

original = CustomerDto(1, "Anna")
changed = replace(original, name="Maria")
```

> 💡 For this to be safer, use a frozen dataclass.

## 19.6 🧊 Immutability

Immutable objects cannot be changed after creation.

**Benefits:**

- 🧠 Easier reasoning
- 🔀 Safer concurrency
- 🛡️ Fewer accidental side effects
- 📏 Stronger domain rules

**Example:**

```python
from dataclasses import dataclass

@dataclass(frozen=True)
class EmailAddress:
    value: str

    def __post_init__(self) -> None:
        if not self.value.strip():
            raise ValueError("Email is required.")
        if "@" not in self.value:
            raise ValueError("Email is invalid.")
```

> 🎯 **When to use immutability:** for values that represent a fact, not a thing that changes — money amounts, coordinates, email addresses, date ranges.

## 19.7 🎰 Slots

`slots=True` can reduce memory usage and prevent accidental new attributes.

```python
from dataclasses import dataclass

@dataclass(slots=True)
class Product:
    id: int
    name: str
    price: float
```

> 🎯 **When to use:** when you create *many* instances (memory matters) or want to catch typos like `product.pirce = 5`. Use it when helpful, not automatically.

---

# 20. None safety and optional values

> 📌 **In plain words:** `None` means "no value." Forgetting that a value *might* be `None` is one of the most common causes of crashes. Type hints make "might be missing" visible.

> 🌍 **Analogy:** `None` is an **empty mailbox** 📭. If you reach in expecting a letter and it's empty, you get an error. Always check before reaching in.

## 20.1 ❓ Optional and non-optional references

```python
name: str = "Anna"        # Should not be None
phone: str | None = None  # May be None
```

## 20.2 ✅ None check

```python
if phone is not None:
    print(len(phone))
```

## 20.3 🎚️ Default value

```python
display_phone = phone if phone is not None else "No phone number"
```

> ⚠️ Do **not** use `phone or "No phone number"` if an empty string `""` is a meaningful value — because `""` is "falsy" and would be wrongly replaced.

## 20.4 🧰 Safe helper method

```python
def display_length(text: str | None) -> int:
    if text is None:
        return 0
    return len(text)
```

## 20.5 🚨 Fail fast

Reject `None`/empty at the boundary so the rest of your code can trust the value.

```python
class Customer:
    def __init__(self, name: str) -> None:
        if name is None:
            raise ValueError("Name is required.")
        if not name.strip():
            raise ValueError("Name cannot be empty.")

        self.name = name
```

## 20.6 🔬 Use static analysis

Tools such as **mypy** and **pyright** can catch many optional-value mistakes *before* runtime.

```bash
mypy src
```

> 💡 **Pro tip:** Running a type checker in your editor is like having a spell-checker for `None` bugs.

---

# 21. Exceptions and custom domain errors

> 📌 **In plain words:** An **exception** is Python's way of shouting "something went wrong and I can't continue!" You can catch that shout, or raise your own.

> 🌍 **Analogy:** A **smoke alarm** 🚨. It interrupts everything to signal a problem. You can respond (catch it), or install your own custom alarms (custom exceptions) for specific dangers.

## 21.1 🧯 Basic try/except/finally

```python
try:
    number = int("abc")
except ValueError as error:
    print(f"Invalid number: {error}")
finally:
    print("Cleanup if needed.")
```

> 💡 `try` = attempt. `except` = handle a specific failure. `finally` = always runs, success or failure (great for cleanup).

## 21.2 🆙 Raise exceptions

```python
class BankAccount:
    def __init__(self, balance: float) -> None:
        self._balance = balance

    def withdraw(self, amount: float) -> None:
        if amount <= 0:
            raise ValueError("Amount must be positive.")

        if amount > self._balance:
            raise ValueError("Insufficient balance.")

        self._balance -= amount
```

## 21.3 🏷️ Custom exception

Make errors specific and meaningful.

```python
class InsufficientBalanceError(Exception):
    def __init__(self, balance: float, requested_amount: float) -> None:
        super().__init__(
            f"Balance {balance} is not enough for withdrawal {requested_amount}."
        )
```

**Usage:**

```python
raise InsufficientBalanceError(balance=100, requested_amount=200)
```

> 🎯 **When to use custom exceptions:** when calling code needs to react *differently* to different failures (e.g., "insufficient funds" vs. "account frozen").

## 21.4 🏛️ Domain exception

A base class for all your business-rule errors.

```python
class DomainError(Exception):
    pass
```

**Usage:**

```python
raise DomainError("Order cannot be shipped before payment.")
```

## 21.5 📏 Exception rules

- ✅ Raise when the method **cannot complete** its promised job.
- ❌ Do **not** use exceptions for normal flow control.
- ✅ Catch only exceptions you can actually handle.
- ✅ Prefer specific exception classes.
- ✅ Preserve tracebacks.
- ✅ Validate inputs early.
- ⚠️ Avoid bare `except:` unless doing controlled cleanup and re-raising.

## 21.6 🔗 Exception chaining

Keep the original cause visible using `from`.

```python
try:
    value = int("abc")
except ValueError as error:
    raise DomainError("Invalid customer input.") from error
```

> 💡 `from error` preserves the whole story — future-you debugging at 2 AM will be grateful.

---

# 22. Class attributes, constants, static methods, and utility modules

> 📌 **In plain words:** Some data belongs to *one object*; some belongs to *the whole class*. Some functions logically live on a class but don't need any object at all.

## 22.1 🧍 vs 👥 Instance attribute vs class attribute

**Instance attributes** belong to one object:

```python
class Customer:
    def __init__(self, name: str) -> None:
        self.name = name
```

**Class attributes** belong to the class and are shared by all instances:

```python
class AppInfo:
    name = "OOP Guide"
```

**Usage:**

```python
print(AppInfo.name)
```

> 🌍 **Analogy:** An instance attribute is *your* name badge. A class attribute is the *company logo on the wall* — shared by everyone.

## 22.2 🔤 Constants

Python does not enforce constants. Use UPPERCASE names by convention.

```python
VAT_RATE = 0.25
MAX_LOGIN_ATTEMPTS = 5
```

## 22.3 🔧 Static method

Belongs logically to the class but needs neither `self` nor `cls`.

```python
class MathHelper:
    @staticmethod
    def square(number: int) -> int:
        return number * number
```

**Usage:**

```python
result = MathHelper.square(5)
```

## 22.4 🏭 Class method

Receives the class itself as `cls` (great for alternative constructors).

```python
class AppSettings:
    def __init__(self, environment: str) -> None:
        self.environment = environment

    @classmethod
    def development(cls) -> "AppSettings":
        return cls("Development")
```

> 💡 **Static vs class method:** a *static* method ignores the class entirely; a *class* method knows about `cls` (useful for building instances).

## 22.5 📦 Utility modules

In Python, a **module with functions** is often better than a utility class.

**Good:**

```python
# math_helpers.py

def square(number: int) -> int:
    return number * number
```

**Usage:**

```python
from math_helpers import square

print(square(5))
```

> [!IMPORTANT]
> **Professional rule:** Do not create classes just to organize functions. A *module* may already be the right container.

## 22.6 ⚠️ Mutable class attribute warning

> [!WARNING]
> Be very careful with **mutable** class attributes — they're shared by *every* instance.

**❌ Bad:**

```python
class Team:
    members = []
```

All `Team` instances share the *same* list — add a member to one team, and it appears in all of them! 😱

**✅ Better:**

```python
class Team:
    def __init__(self) -> None:
        self.members: list[str] = []
```

---

# 23. Callbacks, events, and observer-style design

> 📌 **In plain words:** Sometimes you want to say "when X happens, run this code." A **callback** is a function you hand to another function to be called later.

> 🌍 **Analogy:** Leaving your number at a restaurant 📱. You don't stand at the counter waiting — they *call you back* when your table is ready. That "call me when it's done" function is a callback.

## 23.1 📞 Callback

A callback is a function passed into another function or object.

```python
from collections.abc import Callable

Operation = Callable[[int, int], int]

def calculate(a: int, b: int, operation: Operation) -> int:
    return operation(a, b)

def add(a: int, b: int) -> int:
    return a + b

print(calculate(2, 3, add))
```

## 23.2 λ Lambda callback

For tiny throwaway functions:

```python
result = calculate(2, 3, lambda a, b: a * b)
```

## 23.3 🖨️ Built-in callable types

```python
from collections.abc import Callable

Printer = Callable[[str], None]

printer: Printer = print
printer("Hello")
```

## 23.4 🔔 Event-style class

Let many listeners react to one action.

```python
from collections.abc import Callable

class Button:
    def __init__(self) -> None:
        self._clicked_handlers: list[Callable[[], None]] = []

    def on_clicked(self, handler: Callable[[], None]) -> None:
        self._clicked_handlers.append(handler)

    def click(self) -> None:
        for handler in self._clicked_handlers:
            handler()
```

**Usage:**

```python
button = Button()
button.on_clicked(lambda: print("Button clicked."))
button.click()
```

## 23.5 📨 Custom event data

Carry information about *what* happened.

```python
from dataclasses import dataclass
from collections.abc import Callable

@dataclass(frozen=True)
class OrderPlacedEvent:
    order_id: int

class OrderService:
    def __init__(self) -> None:
        self._order_placed_handlers: list[Callable[[OrderPlacedEvent], None]] = []

    def on_order_placed(self, handler: Callable[[OrderPlacedEvent], None]) -> None:
        self._order_placed_handlers.append(handler)

    def place_order(self, order_id: int) -> None:
        event = OrderPlacedEvent(order_id)
        for handler in self._order_placed_handlers:
            handler(event)
```

## 23.6 👀 Observer pattern

Use observer-style design when many objects need to react to something that happened.

> ⚠️ **When to avoid:** don't make *everything* event-driven. Events can make program flow harder to follow if overused. Use them when decoupling genuinely helps.

---

# 24. Extension-style techniques

> 📌 **In plain words:** How do you add behavior to types you can't or shouldn't modify? Python has several tools — some clean, one dangerous.

Python does not have C#-style extension methods. Common alternatives:

- 🆓 Free functions
- 🎁 Wrapper classes
- 🧩 Mixins
- 📐 Protocols
- 🎀 Decorators
- 🐒 Monkey patching (rarely, carefully)

## 24.1 🆓 Free function

```python
def is_longer_than(text: str, length: int) -> bool:
    return len(text) > length
```

**Usage:**

```python
result = is_longer_than("Hello World", 5)
```

> 💡 This is often the **most Pythonic** option. Don't overthink it — a plain function is frequently the best answer.

## 24.2 🧩 Mixin

A mixin adds reusable behavior to classes.

```python
class DisplayMixin:
    def display(self) -> None:
        print(self)

class Product(DisplayMixin):
    def __init__(self, name: str) -> None:
        self.name = name

    def __str__(self) -> str:
        return self.name
```

> 🎯 **When to use:** for small, focused, reusable behavior shared across unrelated classes.

## 24.3 🎀 Decorator

Decorators can extend function behavior without editing the function.

```python
from collections.abc import Callable
from functools import wraps


def log_call(func: Callable) -> Callable:
    @wraps(func)
    def wrapper(*args, **kwargs):
        print(f"Calling {func.__name__}")
        return func(*args, **kwargs)
    return wrapper

@log_call
def greet(name: str) -> None:
    print(f"Hello {name}")
```

> 🌍 **Analogy:** A decorator is **gift wrapping** 🎁 around a function — the gift is unchanged, but now it has a bow (logging, timing, caching) added around it.

## 24.4 🐒 Monkey patching warning

Python allows adding attributes to objects or classes at runtime.

```python
# Possible, but usually not recommended.
str.custom_method = lambda self: self.upper()
```

> [!WARNING]
> Monkey patching can **surprise other developers and break assumptions**. Prefer explicit functions, wrappers, or mixins. Reserve monkey patching for narrow cases like test mocking.

---

# 25. Special methods, operators, nested classes, and code organization

> 📌 **In plain words:** Python has special "dunder" methods (double-underscore, like `__len__`) that hook your objects into built-in syntax — so `len(myobject)` or `a + b` "just works."

> 🌍 **Analogy:** Dunder methods are **universal adapters** 🔌. Implement `__len__` and suddenly the built-in `len()` speaks your object's language.

## 25.1 🔢 Indexing with `__getitem__`

```python
class Classroom:
    def __init__(self) -> None:
        self._students: list[Student] = []

    def add(self, student: "Student") -> None:
        self._students.append(student)

    def __getitem__(self, index: int) -> "Student":
        return self._students[index]

    def __len__(self) -> int:
        return len(self._students)
```

**Usage:**

```python
first_student = classroom[0]
print(len(classroom))
```

## 25.2 ➕ Operator overloading

Useful for value objects — lets you write `money_a + money_b`.

```python
from dataclasses import dataclass

@dataclass(frozen=True)
class Money:
    amount: float
    currency: str

    def __add__(self, other: "Money") -> "Money":
        if self.currency != other.currency:
            raise ValueError("Currencies must match.")

        return Money(self.amount + other.amount, self.currency)
```

**Usage:**

```python
total = Money(10, "USD") + Money(15, "USD")
```

> 🎯 **When to use:** when `+`, `-`, `==` etc. have a *natural, obvious* meaning for your type (money, vectors, dates). Don't overload operators to do surprising things.

## 25.3 🖊️ String representation

```python
class Product:
    def __init__(self, name: str, price: float) -> None:
        self.name = name
        self.price = price

    def __str__(self) -> str:
        return f"{self.name}: {self.price}"

    def __repr__(self) -> str:
        return f"Product(name={self.name!r}, price={self.price!r})"
```

> 💡 Use `__str__` for **user-friendly** output and `__repr__` for **developer-friendly** debugging output.

## 25.4 📲 Callable objects

Make an object behave like a function with `__call__`.

```python
class DiscountCalculator:
    def __init__(self, rate: float) -> None:
        self.rate = rate

    def __call__(self, total: float) -> float:
        return total * self.rate
```

**Usage:**

```python
calculator = DiscountCalculator(0.10)
print(calculator(100))
```

## 25.5 🚪 Context manager special methods

```python
class ManagedResource:
    def __enter__(self):
        print("Acquire")
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        print("Release")
```

## 25.6 🪆 Nested classes

A class inside another class.

```python
class Invoice:
    class InvoiceLine:
        def __init__(self, product_name: str) -> None:
            self.product_name = product_name
```

> ⚠️ **When to avoid:** most of the time. Use nested classes only when the nested type *strongly* belongs to the outer type. In Python, module-level classes are usually clearer.

## 25.7 🧩 Partial classes equivalent

Python does not have partial classes. Alternatives:

- Split code into modules.
- Use composition.
- Use mixins carefully.
- Keep classes small.
- Use generated code in separate files.

---

# 26. Modules, packages, environments, and project structure

> 📌 **In plain words:** Good OOP isn't just about classes — it's about *organizing* them into files and folders so the project stays understandable as it grows.

> 🌍 **Analogy:** A **module** is a single drawer, a **package** is a filing cabinet, and your **project structure** is the whole well-organized office. 🗄️

## 26.1 📄 Module

A module is a `.py` file.

```text
customer.py
order.py
product.py
```

**Example:**

```python
# customer.py
class Customer:
    pass
```

## 26.2 📦 Package

A package is a folder containing Python modules. It commonly has an `__init__.py` file.

```text
my_app/
├── __init__.py
├── customers.py
├── orders.py
└── products.py
```

## 26.3 🧪 Virtual environment

Isolates project dependencies so projects never interfere with each other.

```bash
python -m venv .venv
source .venv/bin/activate
pip install pytest
```

## 26.4 ⚙️ `pyproject.toml`

Modern Python projects commonly use `pyproject.toml` for configuration.

**Minimal example:**

```toml
[project]
name = "my-app"
version = "0.1.0"
requires-python = ">=3.11"
dependencies = []

[tool.pytest.ini_options]
pythonpath = ["src"]
```

## 26.5 🏗️ Recommended structure

```text
my_app/
├── pyproject.toml
├── README.md
├── src/
│   └── my_app/
│       ├── __init__.py
│       ├── domain/
│       │   ├── __init__.py
│       │   ├── customers.py
│       │   ├── orders.py
│       │   └── products.py
│       ├── application/
│       │   ├── __init__.py
│       │   └── services.py
│       ├── infrastructure/
│       │   ├── __init__.py
│       │   └── persistence.py
│       └── cli.py
└── tests/
    ├── __init__.py
    └── test_orders.py
```

> 💡 Notice the layers: **domain** (business rules), **application** (use cases), **infrastructure** (technical details). This separation pays off as projects grow.

## 26.6 📥 Import style

Prefer clear, explicit imports.

```python
from my_app.domain.customers import Customer
```

Avoid wildcard imports in application code:

```python
# Avoid
from my_app.domain.customers import *
```

> ⚠️ Wildcard imports (`import *`) hide *where* names come from and can cause silent conflicts.

## 26.7 🔁 Python equivalent of assemblies and solutions

Coming from C#? Here's the translation:

| C# concept | Python equivalent |
|---|---|
| Source file | `.py` module |
| Namespace | package/module path |
| Project | Python package/distribution |
| Assembly | installed package/wheel, loosely speaking |
| Solution | repository/workspace with multiple packages/apps |

---

# 27. SOLID principles

> 📌 **In plain words:** **SOLID** is five famous rules that keep OOP systems flexible and maintainable. Learn them — they come up in nearly every serious code review and interview.

> 🌍 **Analogy:** SOLID is like the **building codes for software** 🏗️. You *can* build without them, but the structure will be shaky and painful to renovate.

| Letter | Principle | One-line summary |
|:---:|---|---|
| **S** | Single Responsibility | One class, one job |
| **O** | Open/Closed | Extend without editing |
| **L** | Liskov Substitution | Subtypes must behave like their base |
| **I** | Interface Segregation | Small, focused contracts |
| **D** | Dependency Inversion | Depend on abstractions |

## 27.1 🎯 S: Single Responsibility Principle

A class should have **one reason to change**.

**❌ Bad — this class does four unrelated things:**

```python
class InvoiceService:
    def calculate_total(self) -> float:
        return 0.0

    def save_to_database(self) -> None:
        pass

    def send_email(self) -> None:
        pass

    def print_invoice(self) -> None:
        pass
```

**✅ Better — one responsibility each:**

```python
class InvoiceCalculator:
    pass

class InvoiceRepository:
    pass

class InvoiceEmailSender:
    pass

class InvoicePrinter:
    pass
```

## 27.2 🚪 O: Open/Closed Principle

Software should be **open for extension** and **closed for modification**.

**❌ Bad — you must edit this function for every new type:**

```python
def get_discount(customer_type: str) -> float:
    if customer_type == "regular":
        return 0.05
    if customer_type == "premium":
        return 0.10
    return 0.0
```

**✅ Better — add new behavior by adding classes:**

```python
from typing import Protocol

class DiscountPolicy(Protocol):
    def get_discount(self) -> float:
        ...
```

> 🎯 Add new discount types by adding classes, **not** by editing old conditional logic (which risks breaking what already works).

## 27.3 🔄 L: Liskov Substitution Principle

A derived class should be usable **wherever** the base class is expected — without surprises.

**❌ Bad — a `Penguin` breaks the `Bird.fly()` promise:**

```python
class Bird:
    def fly(self) -> None:
        pass

class Penguin(Bird):
    def fly(self) -> None:
        raise NotImplementedError("Penguins cannot fly.")
```

**✅ Better — don't promise flight to non-fliers:**

```python
class Bird:
    pass

class FlyingBird(Protocol):
    def fly(self) -> None:
        ...
```

> 🌍 **Analogy:** If a recipe says "use any fruit," swapping in an apple shouldn't blow up the kitchen. A subtype that explodes when substituted violates Liskov.

## 27.4 ✂️ I: Interface Segregation Principle

Do not force classes to implement methods they don't need.

**❌ Bad — one fat contract:**

```python
class Machine(Protocol):
    def print_item(self) -> None:
        ...

    def scan(self) -> None:
        ...

    def fax(self) -> None:
        ...
```

**✅ Better — small, focused contracts:**

```python
class Printer(Protocol):
    def print_item(self) -> None:
        ...

class Scanner(Protocol):
    def scan(self) -> None:
        ...

class Fax(Protocol):
    def fax(self) -> None:
        ...
```

## 27.5 🔌 D: Dependency Inversion Principle

High-level code should depend on **abstractions**, not concrete details.

**❌ Bad — glued to a specific email class:**

```python
class OrderService:
    def __init__(self) -> None:
        self._email_sender = SmtpEmailSender()
```

**✅ Better — depends on an abstraction, injected from outside:**

```python
from typing import Protocol

class EmailSender(Protocol):
    def send(self, to: str, subject: str, body: str) -> None:
        ...

class OrderService:
    def __init__(self, email_sender: EmailSender) -> None:
        self._email_sender = email_sender
```

> 💡 This directly sets up the next topic: **Dependency Injection**.

---

# 28. Dependency injection

> 📌 **In plain words:** Dependency Injection (DI) means **giving an object its tools from the outside** instead of having it build them itself. This makes code flexible and testable.

> 🌍 **Analogy:** A chef who is *handed* ingredients (injected) can cook anything you bring. A chef who insists on *growing* their own vegetables (hard-coded dependency) can only make one dish and is impossible to test quickly. 👨‍🍳

Python often uses **simple constructor injection** without any framework.

## 28.1 🏗️ Constructor injection

```python
from typing import Protocol

class PaymentGateway(Protocol):
    def charge(self, amount: float) -> None:
        ...

class StripePaymentGateway:
    def charge(self, amount: float) -> None:
        print(f"Charging {amount}")

class OrderService:
    def __init__(self, payment_gateway: PaymentGateway) -> None:
        self._payment_gateway = payment_gateway

    def checkout(self, total: float) -> None:
        self._payment_gateway.charge(total)
```

**Usage:**

```python
gateway = StripePaymentGateway()
order_service = OrderService(gateway)
order_service.checkout(100.0)
```

> 🎯 In tests, you inject a *fake* gateway — no real charges. That's DI's superpower.

## 28.2 🔧 Function-based dependency injection

```python
def checkout(total: float, payment_gateway: PaymentGateway) -> None:
    payment_gateway.charge(total)
```

> 💡 This is often enough for small Python applications. Don't reach for a DI framework prematurely.

## 28.3 🌱 Composition root

Create objects in **one place** near application startup.

```python
def build_order_service() -> OrderService:
    gateway = StripePaymentGateway()
    return OrderService(gateway)
```

> 🌍 **Analogy:** The composition root is the **assembly line** where all parts are bolted together, once, at the start.

## 28.4 ⏳ Lifetimes in Python

Python doesn't have built-in DI lifetimes like some frameworks, but the ideas still apply.

| Lifetime idea | Meaning |
|---|---|
| New object each time | Create inside a factory when needed |
| Request/session scoped | Create once per request, job, CLI command, or transaction |
| Singleton-like | Create once at startup and reuse carefully |

**General guidance:**

- Use short-lived objects for stateful work.
- Reuse expensive thread-safe clients if the library recommends it.
- Avoid global mutable state.
- Keep infrastructure objects outside your domain model.

## 28.5 🎁 DI benefits

- 🔗 Loose coupling
- 🧪 Easier testing
- 🏛️ Cleaner architecture
- 🔄 Replaceable implementations
- 📦 Better separation of concerns

---

# 29. Design patterns for Python OOP

> 📌 **In plain words:** Design patterns are **proven, reusable solutions** to common design problems — like recipes other cooks already perfected.

> [!TIP]
> **Do not memorize patterns. Learn the _problem_ each one solves.** Python often needs less ceremony than C# or Java because functions, modules, decorators, and duck typing are first-class tools.

## 29.1 🏭 Factory Method

Creates objects without exposing the creation logic.

```python
from typing import Protocol

class NotificationSender(Protocol):
    def send(self, message: str) -> None:
        ...

class EmailSender:
    def send(self, message: str) -> None:
        print(f"Email: {message}")

class SmsSender:
    def send(self, message: str) -> None:
        print(f"SMS: {message}")

class NotificationSenderFactory:
    @staticmethod
    def create(sender_type: str) -> NotificationSender:
        match sender_type:
            case "email":
                return EmailSender()
            case "sms":
                return SmsSender()
            case _:
                raise ValueError("Unknown sender type.")
```

**Pythonic alternative (a dictionary):**

```python
def create_notification_sender(sender_type: str) -> NotificationSender:
    senders = {
        "email": EmailSender,
        "sms": SmsSender,
    }

    try:
        return senders[sender_type]()
    except KeyError as error:
        raise ValueError("Unknown sender type.") from error
```

> 🎯 **When to use:** when creating an object involves logic or choosing among types, and you want callers to stay blissfully unaware of the details.

## 29.2 🎛️ Strategy

Select behavior at runtime by swapping in different objects.

```python
from typing import Protocol

class ShippingCostStrategy(Protocol):
    def calculate(self, order_total: float) -> float:
        ...

class StandardShipping:
    def calculate(self, order_total: float) -> float:
        return 5.0

class ExpressShipping:
    def calculate(self, order_total: float) -> float:
        return 15.0

class CheckoutService:
    def __init__(self, shipping: ShippingCostStrategy) -> None:
        self._shipping = shipping

    def calculate_total(self, order_total: float) -> float:
        return order_total + self._shipping.calculate(order_total)
```

> 🌍 **Analogy:** Choosing "standard" vs "express" shipping at checkout — same checkout, swappable strategy.

## 29.3 🗃️ Repository

Abstracts data access so business code doesn't care where data lives.

```python
from typing import Protocol, TypeVar

T = TypeVar("T")

class Repository(Protocol[T]):
    def add(self, entity: T) -> None:
        ...

    def get_by_id(self, entity_id: int) -> T | None:
        ...

    def get_all(self) -> list[T]:
        ...
```

## 29.4 💼 Unit of Work

Coordinates multiple repository operations in one transaction (all-or-nothing).

```python
class UnitOfWork(Protocol):
    def commit(self) -> None:
        ...

    def rollback(self) -> None:
        ...
```

**Context manager style:**

```python
class SqlUnitOfWork:
    def __enter__(self) -> "SqlUnitOfWork":
        return self

    def __exit__(self, exc_type, exc_value, traceback) -> None:
        if exc_type is None:
            self.commit()
        else:
            self.rollback()

    def commit(self) -> None:
        pass

    def rollback(self) -> None:
        pass
```

## 29.5 👀 Observer

Objects subscribe to changes/events.

```python
from collections.abc import Callable

class EventBus:
    def __init__(self) -> None:
        self._handlers: dict[str, list[Callable]] = {}

    def subscribe(self, event_name: str, handler: Callable) -> None:
        self._handlers.setdefault(event_name, []).append(handler)

    def publish(self, event_name: str, event) -> None:
        for handler in self._handlers.get(event_name, []):
            handler(event)
```

> 🌍 **Analogy:** A newsletter 📰 — subscribers get notified whenever a new issue publishes, and the publisher doesn't need to know who they are.

## 29.6 🎀 Decorator (pattern)

Add behavior without changing the original object.

```python
class PaymentGateway(Protocol):
    def charge(self, amount: float) -> None:
        ...

class LoggingPaymentGateway:
    def __init__(self, inner: PaymentGateway) -> None:
        self._inner = inner

    def charge(self, amount: float) -> None:
        print(f"Charging started: {amount}")
        self._inner.charge(amount)
        print("Charging finished.")
```

> ⚠️ Do not confuse the **Decorator design pattern** with **Python decorator syntax** (`@something`). Related ideas, not identical.

## 29.7 🔌 Adapter

Make incompatible interfaces work together.

```python
class EmailSender(Protocol):
    def send_email(self, to: str, message: str) -> None:
        ...

class ThirdPartyMailer:
    def send(self, recipient: str, body: str) -> None:
        pass

class ThirdPartyMailerAdapter:
    def __init__(self, mailer: ThirdPartyMailer) -> None:
        self._mailer = mailer

    def send_email(self, to: str, message: str) -> None:
        self._mailer.send(to, message)
```

> 🌍 **Analogy:** A **travel plug adapter** 🔌 — lets your device fit a foreign socket without rewiring anything.

## 29.8 📜 Command

Encapsulate a request as an object.

```python
from typing import Protocol

class Command(Protocol):
    def execute(self) -> None:
        ...

class SendWelcomeEmailCommand:
    def __init__(self, email_sender: EmailSender, to: str) -> None:
        self._email_sender = email_sender
        self._to = to

    def execute(self) -> None:
        self._email_sender.send_email(self._to, "Welcome")
```

## 29.9 🧱 Builder

Construct complex objects step by step.

```python
class Report:
    def __init__(self, title: str, sections: list[str]) -> None:
        self.title = title
        self.sections = sections

class ReportBuilder:
    def __init__(self) -> None:
        self._title = ""
        self._sections: list[str] = []

    def with_title(self, title: str) -> "ReportBuilder":
        self._title = title
        return self

    def add_section(self, section: str) -> "ReportBuilder":
        self._sections.append(section)
        return self

    def build(self) -> Report:
        return Report(self._title, list(self._sections))
```

> 🎯 **When to use:** when an object needs many optional pieces assembled in steps. The `return self` trick enables fluent chaining: `builder.with_title(...).add_section(...).build()`.

## 29.10 1️⃣ Singleton

Ensures exactly one instance exists.

> ⚠️ **Use carefully.** In Python, **modules are already singletons** in many practical ways.

**Often better:**

```python
# app_config.py
APPLICATION_NAME = "OOP App"
```

> 💡 Avoid complex singleton classes unless there's a strong reason. A module-level value usually does the job.

---

# 30. Domain modeling and architecture

> 📌 **In plain words:** This is where OOP grows up. **Domain modeling** means turning real business concepts into well-organized objects, arranged in clean layers.

## 30.1 🆔 Entity

An entity has **identity** — it's the *same* thing even if its data changes.

```python
class Entity:
    def __init__(self, entity_id: int) -> None:
        self.id = entity_id
```

**Examples:** `Customer`, `Order`, `Product`, `Invoice`.

> 🌍 **Analogy:** *You* are an entity — change your name, address, or hairstyle, and you're still *you* (same ID).

## 30.2 💎 Value object

Defined by its **values**, not identity. Two with the same values are interchangeable.

```python
from dataclasses import dataclass

@dataclass(frozen=True)
class Money:
    amount: float
    currency: str
```

**Examples:** `Money`, `EmailAddress`, `Address`, `DateRange`, `Quantity`.

> 🌍 **Analogy:** A **$10 bill** — any $10 bill is as good as any other. They have no individual identity, just value.

## 30.3 🧩 Aggregate

An aggregate is a **consistency boundary** — one entity that controls a cluster of related objects and guards their rules.

```text
Order
 └── OrderItems
```

The `Order` controls adding/removing items and protects business rules.

```python
from dataclasses import dataclass

class DomainError(Exception):
    pass

@dataclass(frozen=True)
class OrderItem:
    product_id: int
    product_name: str
    quantity: int
    unit_price: float

    @property
    def total(self) -> float:
        return self.quantity * self.unit_price

class Order(Entity):
    def __init__(self, order_id: int) -> None:
        super().__init__(order_id)
        self._items: list[OrderItem] = []

    @property
    def items(self) -> tuple[OrderItem, ...]:
        return tuple(self._items)

    def add_item(self, product: "Product", quantity: int) -> None:
        if quantity <= 0:
            raise DomainError("Quantity must be positive.")

        self._items.append(
            OrderItem(product.id, product.name, quantity, product.price)
        )
```

## 30.4 🧠 Domain service

Use a domain service when business logic doesn't naturally belong to one entity or value object.

```python
class PricingService:
    def calculate_final_price(
        self,
        order: Order,
        discount_policy: DiscountPolicy,
    ) -> Money:
        total = sum(item.total for item in order.items)
        discount = discount_policy.get_discount()
        return Money(total - total * discount, "USD")
```

## 30.5 🎬 Application service

Coordinates use cases (the "orchestrator").

```python
class PlaceOrderService:
    def __init__(
        self,
        order_repository: Repository[Order],
        payment_gateway: PaymentGateway,
    ) -> None:
        self._order_repository = order_repository
        self._payment_gateway = payment_gateway

    def place_order(self, order: Order) -> None:
        self._payment_gateway.charge(order.total)
        self._order_repository.add(order)
```

## 30.6 🏭 Infrastructure

Infrastructure contains technical details:

- 🗄️ Database
- 📁 File system
- 📧 Email
- 🌐 External APIs
- 📨 Message queues
- 📝 Logging providers

## 30.7 🧭 Clean architecture dependency rule

A common professional structure:

```text
Presentation -> Application -> Domain
Infrastructure -> Application/Domain abstractions
```

> [!IMPORTANT]
> **Business logic should not depend directly on databases, UI, or external systems.** The domain sits at the center; everything else points *inward* toward it.

---

# 31. Unit testing OOP code

> 📌 **In plain words:** Unit tests are small automated checks that prove your code does what you think. They're your safety net when you change things later.

> 🌍 **Analogy:** Tests are the **smoke detectors of your codebase** 🔔. You hope they never go off — but when they do, they save you from disaster.

Python commonly uses `pytest` or the built-in `unittest` module.

## 31.1 🏗️ Create a test project

```bash
pip install pytest
mkdir tests
```

**Example structure:**

```text
src/
└── banking/
    ├── __init__.py
    └── bank_account.py
tests/
└── test_bank_account.py
```

Run tests:

```bash
pytest
```

## 31.2 ✅ Example test with pytest

```python
from banking.bank_account import BankAccount


def test_deposit_should_increase_balance() -> None:
    account = BankAccount("Anna", 100)

    account.deposit(50)

    assert account.balance == 150
```

> 💡 Notice the **Arrange, Act, Assert** rhythm: set up, do the thing, check the result.

## 31.3 💥 Test exceptions

```python
import pytest
from banking.bank_account import BankAccount


def test_withdraw_should_raise_when_amount_exceeds_balance() -> None:
    account = BankAccount("Anna", 100)

    with pytest.raises(ValueError):
        account.withdraw(200)
```

## 31.4 🎭 Fake dependency

Replace a real dependency with a simple stand-in you control.

```python
class FakeEmailSender:
    def __init__(self) -> None:
        self.sent_messages: list[str] = []

    def send(self, to: str, subject: str, body: str) -> None:
        self.sent_messages.append(body)
```

> 🎯 This is where **dependency injection** ([Section 28](#28-dependency-injection)) pays off — you inject the fake instead of the real email service.

## 31.5 🤖 Using unittest.mock

```python
from unittest.mock import Mock


def test_order_service_sends_email() -> None:
    email_sender = Mock()
    service = OrderService(email_sender)

    service.place_order(order_id=1)

    email_sender.send.assert_called_once()
```

## 31.6 📏 Testing principles

- ✅ Test **behavior**, not private implementation details.
- ✅ Prefer clear test names.
- ✅ Arrange, Act, Assert.
- ✅ Keep tests independent.
- ❌ Avoid testing everything through the UI.
- ❌ Avoid brittle tests.
- ✅ Use fake dependencies when needed.
- ✅ Mock **external systems**, not your domain model.

---

# 32. Refactoring OOP code

> 📌 **In plain words:** Refactoring means **improving the design without changing what the code does**. Same behavior, cleaner structure.

> 🌍 **Analogy:** Reorganizing a messy closet 🧹 — the same clothes, but now you can actually find things. Nothing new was bought or thrown away.

## 32.1 🧰 Common refactorings

| Refactoring | Use when |
|---|---|
| Extract Function | A function/method is too long |
| Extract Class | A class has too many responsibilities |
| Rename | A name is unclear |
| Move Method | A method belongs in another class |
| Introduce Protocol | You need substitution/testing |
| Replace Conditional with Polymorphism | Many `if`/`match` type checks |
| Replace Inheritance with Composition | Inheritance is forced |
| Encapsulate Collection | A public list is mutable |
| Introduce Value Object | Primitive values need rules |
| Split God Class | One class does everything |

## 32.2 💎 Example: primitive obsession

**❌ Bad — a raw string with no rules:**

```python
class Customer:
    def __init__(self, email: str) -> None:
        self.email = email
```

**✅ Better — a value object that guarantees validity:**

```python
from dataclasses import dataclass

@dataclass(frozen=True)
class EmailAddress:
    value: str

    def __post_init__(self) -> None:
        if not self.value.strip():
            raise ValueError("Email is required.")

        if "@" not in self.value:
            raise ValueError("Email is invalid.")
```

## 32.3 🔀 Example: replace conditional with polymorphism

**Before:**

```python
def calculate_shipping(method: str) -> float:
    match method:
        case "standard":
            return 5.0
        case "express":
            return 15.0
        case _:
            raise ValueError("Unknown method")
```

**After:**

```python
class ShippingMethod(Protocol):
    def calculate_cost(self) -> float:
        ...
```

## 32.4 🔁 Refactoring workflow

1. 🧪 Add tests around the current behavior.
2. 🔧 Make **one** small design change.
3. ✅ Run tests.
4. 🏷️ Rename for clarity.
5. 🔁 Repeat.

> [!IMPORTANT]
> **Never refactor without tests.** Tests are what let you change code confidently, knowing you didn't break anything.

---

# 33. Common OOP mistakes

> 📌 **In plain words:** Learn these traps *before* you fall into them. Recognizing an anti-pattern early saves days of pain later.

## 33.1 🦖 God class

One class does everything.

**Symptoms:**

- Many unrelated methods
- Too many dependencies
- Hard to test
- Hard to understand

## 33.2 🩸 Anemic domain model

Classes only have attributes, no behavior (all data, no rules).

**❌ Bad:**

```python
class Order:
    def __init__(self) -> None:
        self.items = []
        self.status = ""
```

**✅ Better — behavior and rules live with the data:**

```python
from enum import Enum

class OrderStatus(Enum):
    DRAFT = "draft"
    COMPLETED = "completed"

class Order:
    def __init__(self) -> None:
        self._items: list[OrderItem] = []
        self._status = OrderStatus.DRAFT

    @property
    def items(self) -> tuple[OrderItem, ...]:
        return tuple(self._items)

    @property
    def status(self) -> OrderStatus:
        return self._status

    def add_item(self, item: OrderItem) -> None:
        if self._status == OrderStatus.COMPLETED:
            raise DomainError("Cannot change completed order.")

        self._items.append(item)
```

## 33.3 🌳 Too much inheritance

If you have deep inheritance like:

```text
BaseEntity -> Person -> Employee -> Manager -> RegionalManager -> ...
```

> ⚠️ Pause and reconsider **composition**. Deep inheritance chains are fragile and hard to change.

## 33.4 📢 Public mutable state

Avoid exposing mutable internal lists and dictionaries unless external mutation is intended.

## 33.5 🔢 Primitive obsession

Using `str`, `int`, and `float` everywhere instead of meaningful types (see the `EmailAddress` fix in [32.2](#322-example-primitive-obsession)).

## 33.6 🔗 Tight coupling

Classes directly instantiate their dependencies.

**❌ Bad:**

```python
class OrderService:
    def __init__(self) -> None:
        self._sender = EmailSender()
```

**✅ Better — inject it:**

```python
class OrderService:
    def __init__(self, sender: EmailSenderProtocol) -> None:
        self._sender = sender
```

## 33.7 📐 Overusing protocols

Do not create protocols for every class automatically. Create protocols when you need:

- Multiple implementations
- Testing substitution
- Dependency inversion
- Plugin-like behavior
- A boundary between layers

## 33.8 🖱️ Business logic in the UI

**❌ Bad:**

```text
Button click handler calculates invoice discounts.
```

**✅ Better:**

```text
Button click handler calls InvoiceService.
InvoiceService contains business logic.
```

## 33.9 🗄️ Business logic in database/infrastructure only

Do not hide *all* rules inside SQL, stored procedures, or external services if your domain needs to enforce them.

## 33.10 📭 Ignoring None handling

Use type hints, explicit validation, and tests (see [Section 20](#20-none-safety-and-optional-values)).

## 33.11 ⚠️ Mutable default arguments

> [!WARNING]
> This is a famous Python gotcha. A mutable default is created **once** and shared across all calls!

**❌ Bad:**

```python
def add_item(item, items=[]):
    items.append(item)
    return items
```

**✅ Better:**

```python
def add_item(item, items=None):
    if items is None:
        items = []
    items.append(item)
    return items
```

**With classes, prefer:**

```python
class Order:
    def __init__(self) -> None:
        self.items = []
```

**For dataclasses, use `field(default_factory=...)`:**

```python
from dataclasses import dataclass, field

@dataclass
class Order:
    items: list[str] = field(default_factory=list)

---

# 34. Hands-on projects

> 📌 **In plain words:** Reading about OOP is like reading about swimming. These projects are where you jump in the water. 🏊 Pick one at your level and build it end to end.

## 34.1 🟢 Beginner projects

1. Student Management System
2. Bank Account System
3. Product Inventory System
4. Employee Salary Calculator
5. Shape Area Calculator
6. Notification Sender

## 34.2 🟡 Intermediate projects

1. Library Management System
2. Hotel Booking System
3. Restaurant Ordering System
4. Hospital Appointment System
5. Vehicle Rental System
6. Course Enrollment System

## 34.3 🔴 Advanced projects

1. E-Commerce Cart and Checkout
2. Payroll System
3. Learning Management System
4. Banking System
5. Support Ticket System
6. Event Booking Platform

## 34.4 ✅ What every project should practice

> [!TIP]
> Treat this as a checklist for *each* project. A project that hits all these is a real portfolio piece.

- [ ] Classes and objects
- [ ] Encapsulation
- [ ] Constructors
- [ ] Protocols or abstract base classes
- [ ] Inheritance only when appropriate
- [ ] Composition
- [ ] Generics/type hints
- [ ] Collections
- [ ] Exceptions
- [ ] None safety
- [ ] Unit tests
- [ ] At least one design pattern
- [ ] Refactoring

---

# 35. Complete capstone project: Library Management System

> 📌 **In plain words:** This is the grand finale — a single project that combines nearly *everything* in this guide into one working console app. Build it, and you've proven you can do professional Python OOP. 🎓

This capstone intentionally combines beginner and professional OOP ideas.

## 35.1 📋 Requirements

Build a console app with:

- 📚 Books
- 👤 Members
- 🧑‍💼 Librarians
- 📤 Borrowing
- 📥 Returning
- 🔢 Borrow limits
- 🔍 Search
- 🗃️ Generic repository
- 🚨 Domain exceptions
- 📐 Protocols
- 🧬 Inheritance
- 🧩 Composition
- 🧪 Unit tests

## 35.2 🏗️ Create project

```bash
mkdir library_management
cd library_management
python -m venv .venv
source .venv/bin/activate
pip install pytest
mkdir -p src/library_management/domain tests
```

**Suggested structure:**

```text
library_management/
├── pyproject.toml
├── src/
│   └── library_management/
│       ├── __init__.py
│       ├── console_app.py
│       └── domain/
│           ├── __init__.py
│           ├── exceptions.py
│           ├── entities.py
│           ├── books.py
│           ├── members.py
│           ├── repositories.py
│           └── services.py
└── tests/
    └── test_library.py
```

**Minimal `pyproject.toml`:**

```toml
[project]
name = "library-management"
version = "0.1.0"
requires-python = ">=3.11"
dependencies = []

[tool.pytest.ini_options]
pythonpath = ["src"]
```

## 35.3 🚨 Domain exception

```python
# src/library_management/domain/exceptions.py

class DomainError(Exception):
    pass
```

## 35.4 🆔 Entity base

```python
# src/library_management/domain/entities.py

class Entity:
    def __init__(self, entity_id: int) -> None:
        self.id = entity_id
```

## 35.5 📚 Book

```python
# src/library_management/domain/books.py

from library_management.domain.entities import Entity
from library_management.domain.exceptions import DomainError

class Book(Entity):
    def __init__(self, book_id: int, title: str, author: str) -> None:
        if not title.strip():
            raise ValueError("Title is required.")

        if not author.strip():
            raise ValueError("Author is required.")

        super().__init__(book_id)
        self.title = title
        self.author = author
        self._is_available = True

    @property
    def is_available(self) -> bool:
        return self._is_available

    def borrow(self) -> None:
        if not self._is_available:
            raise DomainError("Book is already borrowed.")

        self._is_available = False

    def return_book(self) -> None:
        if self._is_available:
            raise DomainError("Book is already available.")

        self._is_available = True
```

## 35.6 👤 Member abstraction

```python
# src/library_management/domain/members.py

from abc import ABC, abstractmethod

from library_management.domain.books import Book
from library_management.domain.entities import Entity
from library_management.domain.exceptions import DomainError

class Member(Entity, ABC):
    def __init__(self, member_id: int, name: str) -> None:
        if not name.strip():
            raise ValueError("Name is required.")

        super().__init__(member_id)
        self.name = name
        self._borrowed_books: list[Book] = []

    @property
    def borrowed_books(self) -> tuple[Book, ...]:
        return tuple(self._borrowed_books)

    @property
    @abstractmethod
    def borrow_limit(self) -> int:
        pass

    def borrow_book(self, book: Book) -> None:
        if len(self._borrowed_books) >= self.borrow_limit:
            raise DomainError("Borrow limit reached.")

        book.borrow()
        self._borrowed_books.append(book)

    def return_book(self, book: Book) -> None:
        if book not in self._borrowed_books:
            raise DomainError("This member did not borrow this book.")

        book.return_book()
        self._borrowed_books.remove(book)
```

> 💡 See how many concepts converge here: **inheritance** (`Entity`), **abstraction** (`ABC` + abstract `borrow_limit`), **encapsulation** (`_borrowed_books` + read-only `tuple`), and **domain rules** (borrow limit).

## 35.7 👥 Member types

```python
# src/library_management/domain/members.py continued

class RegularMember(Member):
    @property
    def borrow_limit(self) -> int:
        return 3

class PremiumMember(Member):
    @property
    def borrow_limit(self) -> int:
        return 10
```

> 🎯 This is **polymorphism** in action — `RegularMember` and `PremiumMember` differ only in their `borrow_limit`, and the shared `borrow_book` logic just works for both.

## 35.8 🧑‍💼 Librarian

```python
# src/library_management/domain/members.py continued

class Librarian(Entity):
    def __init__(self, librarian_id: int, name: str) -> None:
        if not name.strip():
            raise ValueError("Name is required.")

        super().__init__(librarian_id)
        self.name = name
```

## 35.9 🗃️ Generic repository

```python
# src/library_management/domain/repositories.py

from typing import Generic, Protocol, TypeVar

from library_management.domain.entities import Entity

TEntity = TypeVar("TEntity", bound=Entity)

class Repository(Protocol[TEntity]):
    def add(self, entity: TEntity) -> None:
        ...

    def get_by_id(self, entity_id: int) -> TEntity | None:
        ...

    def get_all(self) -> list[TEntity]:
        ...

class InMemoryRepository(Generic[TEntity]):
    def __init__(self) -> None:
        self._items: list[TEntity] = []

    def add(self, entity: TEntity) -> None:
        self._items.append(entity)

    def get_by_id(self, entity_id: int) -> TEntity | None:
        return next((item for item in self._items if item.id == entity_id), None)

    def get_all(self) -> list[TEntity]:
        return list(self._items)
```

## 35.10 📖 Library service

```python
# src/library_management/domain/services.py

from library_management.domain.books import Book
from library_management.domain.exceptions import DomainError
from library_management.domain.members import Member
from library_management.domain.repositories import Repository

class LibraryService:
    def __init__(
        self,
        book_repository: Repository[Book],
        member_repository: Repository[Member],
    ) -> None:
        self._book_repository = book_repository
        self._member_repository = member_repository

    def add_book(self, book: Book) -> None:
        self._book_repository.add(book)

    def add_member(self, member: Member) -> None:
        self._member_repository.add(member)

    def borrow_book(self, member_id: int, book_id: int) -> None:
        member = self._member_repository.get_by_id(member_id)
        if member is None:
            raise DomainError("Member not found.")

        book = self._book_repository.get_by_id(book_id)
        if book is None:
            raise DomainError("Book not found.")

        member.borrow_book(book)

    def return_book(self, member_id: int, book_id: int) -> None:
        member = self._member_repository.get_by_id(member_id)
        if member is None:
            raise DomainError("Member not found.")

        book = self._book_repository.get_by_id(book_id)
        if book is None:
            raise DomainError("Book not found.")

        member.return_book(book)

    def search_books(self, search_text: str) -> list[Book]:
        normalized = search_text.lower()

        return [
            book
            for book in self._book_repository.get_all()
            if normalized in book.title.lower() or normalized in book.author.lower()
        ]
```

> 💡 `LibraryService` uses **dependency injection** — it receives its repositories, so in tests you can hand it fakes.

## 35.11 🖥️ Console app

```python
# src/library_management/console_app.py

from library_management.domain.books import Book
from library_management.domain.members import Member, PremiumMember, RegularMember
from library_management.domain.repositories import InMemoryRepository
from library_management.domain.services import LibraryService

book_repository = InMemoryRepository[Book]()
member_repository = InMemoryRepository[Member]()

library = LibraryService(book_repository, member_repository)

library.add_book(Book(1, "Clean Code", "Robert C. Martin"))
library.add_book(Book(2, "Fluent Python", "Luciano Ramalho"))
library.add_book(Book(3, "The Pragmatic Programmer", "Andrew Hunt"))

library.add_member(RegularMember(1, "Gehan"))
library.add_member(PremiumMember(2, "Anna"))

library.borrow_book(member_id=1, book_id=1)

for book in library.search_books("code"):
    print(
        f"{book.id}: {book.title} by {book.author} "
        f"- Available: {book.is_available}"
    )
```

**Run:**

```bash
python -m library_management.console_app
```

## 35.12 🧪 Unit tests

```python
# tests/test_library.py

import pytest

from library_management.domain.books import Book
from library_management.domain.exceptions import DomainError
from library_management.domain.members import RegularMember


def test_borrow_book_should_mark_book_unavailable() -> None:
    book = Book(1, "Clean Code", "Robert C. Martin")
    member = RegularMember(1, "Anna")

    member.borrow_book(book)

    assert book.is_available is False
    assert book in member.borrowed_books


def test_borrow_book_should_raise_when_limit_reached() -> None:
    member = RegularMember(1, "Anna")

    member.borrow_book(Book(1, "Book 1", "Author"))
    member.borrow_book(Book(2, "Book 2", "Author"))
    member.borrow_book(Book(3, "Book 3", "Author"))

    with pytest.raises(DomainError):
        member.borrow_book(Book(4, "Book 4", "Author"))
```

**Run:**

```bash
pytest
```

## 35.13 🚀 Capstone extensions

Ready for more? Add:

- `Reservation`
- `FineCalculator`
- `BorrowPolicy` protocol
- `NotificationSender` protocol
- Email notification
- File persistence
- JSON export
- Dependency injection composition root
- More unit tests
- CLI menu
- FastAPI Web API version

---

# 36. Professional checklist

> 📌 **In plain words:** A self-assessment. When you can confidently check every box, you're ready for professional Python OOP work. ✅

## 36.1 🔤 Core syntax

- [ ] Class
- [ ] Object
- [ ] Attribute
- [ ] Property
- [ ] Method
- [ ] Constructor
- [ ] Access conventions
- [ ] Class attribute
- [ ] Static method
- [ ] Class method
- [ ] Protocol
- [ ] Abstract base class
- [ ] Inheritance
- [ ] Polymorphism
- [ ] Generics/type hints
- [ ] Collections

## 36.2 🏛️ Professional design

- [ ] Encapsulation with invariants
- [ ] Composition over inheritance
- [ ] Object relationships
- [ ] SOLID
- [ ] Dependency injection
- [ ] Domain services
- [ ] Value objects
- [ ] Entities
- [ ] Clean architecture basics
- [ ] Testing
- [ ] Refactoring

## 36.3 🐍 Python-specific features

- [ ] Type hints
- [ ] `Protocol`
- [ ] `ABC`
- [ ] `dataclass`
- [ ] `frozen=True`
- [ ] `slots=True`
- [ ] `property`
- [ ] Context managers
- [ ] Decorators
- [ ] Callable callbacks
- [ ] Special methods
- [ ] Operator overloading
- [ ] Modules and packages
- [ ] Virtual environments

## 36.4 🌍 Real-world readiness

- [ ] Can build a console OOP application.
- [ ] Can separate domain logic from UI.
- [ ] Can write unit tests.
- [ ] Can use dependency injection without unnecessary frameworks.
- [ ] Can avoid God classes.
- [ ] Can model entities and value objects.
- [ ] Can explain why composition is often better than inheritance.
- [ ] Can refactor duplicated conditional logic into polymorphism.
- [ ] Can use generics/type hints safely.
- [ ] Can design small services with clear responsibilities.

---

# 37. 30-day learning plan

> 📌 **In plain words:** A day-by-day roadmap. One month, one skill at a time, from zero to a full library system. 📅

## 📗 Week 1: Foundations

| Day | Focus |
|:---:|---|
| 1 | Classes, objects, attributes, properties |
| 2 | Methods, constructors, keyword arguments |
| 3 | Access conventions and encapsulation |
| 4 | Bank account exercise |
| 5 | Inheritance |
| 6 | Polymorphism |
| 7 | Abstract base classes and protocols |

🎁 **Deliverable:** shape calculator and bank account system.

## 📘 Week 2: Practical Python OOP

| Day | Focus |
|:---:|---|
| 8 | Composition |
| 9 | Object relationships |
| 10 | Type hints and generics |
| 11 | Generic repository |
| 12 | Collections |
| 13 | Object querying with comprehensions |
| 14 | None safety and exceptions |

🎁 **Deliverable:** inventory system.

## 📙 Week 3: Professional design

| Day | Focus |
|:---:|---|
| 15 | SOLID overview |
| 16 | Single Responsibility and Open/Closed |
| 17 | Liskov and Interface Segregation |
| 18 | Dependency Inversion and DI |
| 19 | Strategy pattern |
| 20 | Factory and Repository patterns |
| 21 | Refactoring practice |

🎁 **Deliverable:** checkout system with payment and shipping strategies.

## 📕 Week 4: Architecture and testing

| Day | Focus |
|:---:|---|
| 22 | Entities and value objects |
| 23 | Aggregates |
| 24 | Layered architecture |
| 25 | Unit testing with pytest |
| 26 | Fakes and mocks |
| 27 | Capstone part 1 |
| 28 | Capstone part 2 |
| 29 | Capstone tests |
| 30 | Review, refactor, document |

🎁 **Deliverable:** complete library management system.

---

# 38. Glossary

> 📌 A quick-reference dictionary of every key term in this guide.

| Term | Meaning |
|---|---|
| **Abstraction** | Hiding unnecessary details and exposing only what matters. |
| **Access convention** | A naming rule that signals intended visibility, such as `_internal_name`. |
| **Aggregate** | A group of domain objects treated as one consistency boundary. |
| **Association** | A relationship where one object knows about another. |
| **Attribute** | Data stored on an object or class. |
| **Class** | Blueprint for creating objects. |
| **Class attribute** | Attribute stored on the class and shared by instances. |
| **Class method** | Method that receives the class as `cls`. |
| **Composition** | Building one object from other objects. |
| **Constructor** | In Python, `__init__` initializes an object after creation. |
| **Context manager** | Object used with `with` to acquire and release resources safely. |
| **Dataclass** | A Python feature for creating data-focused classes with less boilerplate. |
| **Dependency injection** | Passing dependencies into a class instead of creating them inside. |
| **Duck typing** | Using an object based on what it can do, not only what class it belongs to. |
| **Encapsulation** | Protecting object state and exposing safe operations. |
| **Entity** | Domain object with identity. |
| **Generic** | A type or function that accepts type parameters for static type checking. |
| **Inheritance** | Creating specialized classes from a base class. |
| **Instance** | An object created from a class. |
| **Invariant** | A rule that must always remain true for an object. |
| **Method** | A function attached to a class or object. |
| **Mixin** | A small class used to add focused reusable behavior through inheritance. |
| **None** | Python's value for "no value". |
| **Object** | A runtime instance that combines data and behavior. |
| **Polymorphism** | Using one abstraction with many implementations. |
| **Protocol** | A structural interface used by type checkers to describe required behavior. |
| **Repository** | A pattern that abstracts data access. |
| **Static method** | Method placed on a class that does not receive `self` or `cls`. |
| **Value object** | Object defined by its values rather than identity. |

---

# 39. Reference links

> 📌 Use these official references when you want to dig deeper.

| Resource | Link |
|---|---|
| 🐍 Python documentation | https://docs.python.org/3/ |
| 📖 Python tutorial | https://docs.python.org/3/tutorial/ |
| 🏗️ Classes | https://docs.python.org/3/tutorial/classes.html |
| ⚡ Dataclasses | https://docs.python.org/3/library/dataclasses.html |
| 🏛️ abc module | https://docs.python.org/3/library/abc.html |
| 🏷️ typing module | https://docs.python.org/3/library/typing.html |
| 🧪 unittest | https://docs.python.org/3/library/unittest.html |
| ✅ pytest | https://docs.pytest.org/ |
| 🔬 mypy | https://mypy.readthedocs.io/ |
| ⚡ Ruff | https://docs.astral.sh/ruff/ |

---

<div align="center">

## 🎯 Final advice

</div>

> [!IMPORTANT]
> **Good Python OOP is _not_ about making everything a class.**

Good Python OOP means:

- 🧲 Put behavior **near the data** it protects.
- 🎯 Keep public APIs **small and clear**.
- 🧩 Prefer **composition** when inheritance feels forced.
- 📐 Use **protocols** for capabilities.
- ⚡ Use **dataclasses** for simple values.
- 🧪 Use **tests** to protect behavior.
- 🔁 **Refactor** when design starts to resist change.

> The goal is not to write the most object-oriented code possible.
> **The goal is to write code that is clear, safe, flexible, and easy to change.** 🚀

<div align="center">

---

*Happy coding! 🐍 Now go build something.*

</div>

---

<div align="center">

**Complete Object-Oriented Programming with Python**
*by Gehan Fernando*

*Read it once. Use it forever. Break things on purpose.*

</div>
