<div align="center">

# 📖 The Complete Bible of Python Dunder Methods

### *Every single dunder method Python offers — explained so simply that even someone who has never coded before can master them.*

**_By Gehan Fernando_**

</div>

---

## 🎯 A Note Before You Begin

This is a long guide — but do not let that scare you. It is designed as a **reference bible**. You do not need to read it in one sitting. Bookmark it, come back to it, jump to the section you need.

Every dunder method in Python is here. Every single one gets:

- 🎨 **A real-world story** so you can picture what it does
- 🔍 **When to use it** — the practical situations where it matters
- 💻 **How to use it** — clear code you can run and modify
- ⚠️ **Warnings and tips** where they help

If you are new to programming, I promise: by the end of this guide, you will understand Python at a depth most working programmers never reach.

Let's begin.

---

## 📊 What's Inside

> **150+ dunder methods** covered across **23 parts**, with a story, a "when to use", a "how to use", and a code example for every one.

### 🚦 Difficulty Legend

Every dunder is tagged so you know how often you'll actually use it:

- 🟢 **Everyday** — Learn this early. You will use it constantly.
- 🟡 **Sometimes** — Good to know. Comes up in real projects.
- 🔴 **Rare / Advanced** — Framework territory. Safe to skim for now.

### 🗺️ Table of Contents

**🧠 Core Concepts**
- Part 1 — The One Big Idea

**📦 Class Dunders (methods on your objects)**
- Part A — Object Creation and Destruction
- Part B — String Representation
- Part C — Comparison Operators
- Part D — Arithmetic Operators
- Part E — Reflected Arithmetic (right-hand side)
- Part F — In-Place Operators (`+=`, `-=`, etc.)
- Part G — Unary and Sign Operators
- Part H — Bitwise Operators
- Part I — Type Conversion
- Part J — Container Behavior (list-like)
- Part K — Iteration
- Part L — Callable Objects
- Part M — Context Managers (`with`)
- Part N — Attribute Access
- Part O — Descriptors
- Part P — Class and Metaclass Magic
- Part Q — Async / Await
- Part R — Copying and Pickling
- Part S — Path-Like Objects

**🎁 Wrap-up**
- Part T — Grand Finale: The Complete Vector Class

**📦 Beyond Classes**
- Part U — Package & Module Dunders

**🔍 Introspection & Modern Python (Final Round Additions)**
- Part V — Introspection Attributes
- Part W — Function & Method Attributes
- Part X — Modern Python Dunders (3.10+)

**📋 Reference**
- The Complete Cheat Sheet
- The Golden Best Practices

---

## 🧒 First: How to Read the Code Examples

*If you have never coded before, this 60-second primer explains everything you need to follow along.*

Every code example uses the same building blocks. Once you know these, you can read any example in this bible:

**`class Dog:`** — Defines a **template** called `Dog`. Think of it as a cookie cutter for making dogs.

**`def __init__(self, name):`** — Defines a **method** (a mini-function that belongs to the class). Every method takes `self` as its first parameter — `self` just means "this specific dog we're working on right now."

**`self.name = name`** — Stores information *on* the object. Like writing "Buddy" on Buddy's name tag.

**`buddy = Dog("Buddy")`** — Creates a new dog named Buddy.

**`return x`** — Sends a value back to whoever called the method.

**`f"Hello {name}"`** — An **f-string** — a text template. The `{name}` gets replaced with the actual value.

**`# a comment`** — Just a note for humans. Python ignores it.

**`super()`** — A shortcut meaning "the parent template this one is built on." Used to borrow behavior from parents.

**`**kwargs`** — Programmer shorthand for "any extra keyword arguments." Safe to ignore for now.

**`@decorator`** — A modifier attached to a function or class. Like a sticker that adds behavior.

**Output comments** like `# Buddy` show what the code prints when you run it — so you can follow along without actually running the code.

That's it. You now have everything you need. Let's dive in!

---

## 🧠 Part 1: The One Big Idea You Need First

### What is a "dunder"?

"Dunder" is short for **D**ouble **UNDER**score. These are Python methods with two underscores at the start and two at the end:

```
__init__      __add__      __str__      __call__
```

They look strange, but they are simply Python's way of marking methods as *special* — methods that Python itself will call in the background when you do everyday things.

### The magic translation table

Whenever you write ordinary Python code, Python is quietly translating it into dunder-method calls. Here is what really happens under the hood:

| What you write | What Python actually calls |
|----------------|----------------------------|
| `a + b` | `a.__add__(b)` |
| `a - b` | `a.__sub__(b)` |
| `a == b` | `a.__eq__(b)` |
| `len(x)` | `x.__len__()` |
| `x[0]` | `x.__getitem__(0)` |
| `item in x` | `x.__contains__(item)` |
| `print(x)` | Uses `x.__str__()` |
| `if x:` | Uses `x.__bool__()` |
| `x()` | `x.__call__()` |
| `with x:` | `x.__enter__()` then `x.__exit__()` |

**Your job as a programmer:** decide what these methods should *do* when Python calls them. That is the entire art of dunder methods.

### The mental model

Imagine every Python object is a **house with many labeled doors**. Each door has a specific purpose: one door is used when someone adds something to the house, another when someone measures the house, another when someone visits the house, and so on.

By default, most doors are locked. Dunder methods are how you **unlock and design each door**. You decide what happens when someone knocks on the "add" door, the "compare" door, the "print" door.

Now let's walk through every door Python offers.

---

# 📦 PART A: Object Creation and Destruction

*Everything that happens when your object is born, lives, and dies.*

---

## 1. `__new__` — The Object Creator

### 🎨 The story
Imagine a cake factory. Before anyone can decorate a cake, someone has to actually *bake* the cake first. `__new__` is the baker — it creates the raw, empty object that others will later customize.

### 🔍 When to use it
Almost never. Beginners can safely skip this for years. You would only use it for advanced tricks like:
- **Singletons** — making sure only one instance of a class ever exists
- **Immutable classes** — customizing how tuples or strings are created
- **Metaclass magic** — very advanced stuff

### 💻 How to use it

```python
class Singleton:
    _instance = None

    def __new__(cls):
        # Only create ONE instance, ever.
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance

a = Singleton()
b = Singleton()
print(a is b)   # True — they are literally the same object
```

### 🧒 In Plain English
Normally, `Singleton()` creates a brand-new object every time you call it. This code says: *"Only make an object the very first time. After that, always give back the same one."*

- `cls` means "the class itself" (like passing `Singleton` around as a variable).
- `cls._instance` is where we remember the one and only instance.
- `super().__new__(cls)` says "let Python's default baker make me an empty object."
- Result: `a` and `b` end up being **the same object**, not two different ones.

### ⚠️ Tip
If you are just starting out, ignore this and move on. You will not need it.

---

## 2. `__init__` — The Setup Ceremony

### 🎨 The story
Think of the moment you get a new phone. The instant you unbox it, you set your name, choose a wallpaper, and add your Wi-Fi password. All that setup happens once, at the very start. That is what `__init__` does for your Python objects.

### 🔍 When to use it
**Almost every class you write.** This is the most common dunder method. Use it whenever your object needs starting information.

### 💻 How to use it

```python
class Dog:
    def __init__(self, name, age, breed):
        self.name = name
        self.age = age
        self.breed = breed

buddy = Dog("Buddy", 3, "Golden Retriever")
print(buddy.name)   # Buddy
print(buddy.age)    # 3
```

You never call `__init__` yourself. Python calls it automatically when you write `Dog(...)`.

---

## 3. `__del__` — The Farewell

### 🎨 The story
When you leave a hotel room, housekeeping comes in to clean up. `__del__` is the housekeeping — it runs when Python is about to remove your object from memory.

### 🔍 When to use it
Rarely. Python cleans up most things automatically. Only use `__del__` when your object holds an external resource (like a file or network connection) that must be released — and even then, `__enter__`/`__exit__` (context managers) are usually a better choice.

### 💻 How to use it

```python
class FileWatcher:
    def __init__(self, filename):
        self.filename = filename
        print(f"Started watching {filename}")

    def __del__(self):
        print(f"Stopped watching {self.filename}")

watcher = FileWatcher("app.log")
del watcher   # Stopped watching app.log
```

### ⚠️ Warning
Do not rely on `__del__` for critical cleanup. Python may not call it exactly when you expect. Use context managers (`with`) instead for anything important.

---

## 4. `__init_subclass__` — The Class Family Registrar

### 🎨 The story
Imagine you run a private school. Every time a new student enrolls, they automatically get a uniform and a school ID. `__init_subclass__` is that automatic enrollment — it runs whenever a new class inherits from yours.

### 🔍 When to use it
When you build a framework or library where all subclasses need automatic setup, like being registered in a list.

### 💻 How to use it

```python
class Plugin:
    plugins = []

    def __init_subclass__(cls, **kwargs):
        super().__init_subclass__(**kwargs)
        Plugin.plugins.append(cls)
        print(f"Registered plugin: {cls.__name__}")

class EmailPlugin(Plugin):
    pass

class SMSPlugin(Plugin):
    pass

print(Plugin.plugins)   # [<class 'EmailPlugin'>, <class 'SMSPlugin'>]
```

### 🧒 In Plain English
First, some vocabulary:
- **Inheritance** — when one class is "built on top of" another, like a child inheriting traits from a parent. `class EmailPlugin(Plugin):` means "EmailPlugin is a special kind of Plugin."
- **`cls`** — refers to the child class that's being created (like `EmailPlugin` or `SMSPlugin`).

What this code does:
1. We make a `Plugin` class that keeps a list of all its children.
2. `__init_subclass__` runs **once** every time a new child class is created.
3. It adds the child class to the master list automatically.

Real-world use: WordPress-style plugin systems, where every new plugin automatically registers itself with the app.

---

## 5. `__set_name__` — The Descriptor's Name Tag

### 🎨 The story
When a new employee joins a company, they get a name tag with their name on it. `__set_name__` gives your special class attributes a name tag automatically when they are assigned inside a class.

### 🔍 When to use it
When building custom descriptors (advanced) that need to know what name they were given inside their parent class.

### 💻 How to use it

```python
class LoggedAttribute:
    def __set_name__(self, owner, name):
        self.name = name

    def __get__(self, obj, objtype=None):
        print(f"Reading {self.name}")
        return obj.__dict__.get(self.name)

    def __set__(self, obj, value):
        print(f"Setting {self.name} = {value}")
        obj.__dict__[self.name] = value

class User:
    username = LoggedAttribute()

u = User()
u.username = "alice"   # Setting username = alice
print(u.username)      # Reading username → alice
```

### 🧒 In Plain English
This is advanced — feel free to skip on your first read.

The idea: when you write `username = LoggedAttribute()` inside the `User` class, the `LoggedAttribute` object doesn't automatically know it was assigned the name `"username"`. Python calls `__set_name__` to whisper the name to it: *"Hey, you're being stored as `username`."*

Then, every time someone reads or writes `u.username`, our `LoggedAttribute` prints a log message. This is how frameworks like Django track and validate model fields.

**Bottom line:** don't worry about this unless you're building a framework. Just know it exists.

---

# 📝 PART B: String Representation

*How your object describes itself to the world.*

---

## 6. `__str__` — The Friendly Introduction

### 🎨 The story
At a networking event, when someone asks who you are, you say something friendly: *"I'm Sarah, I work in marketing."* You do not recite your passport number. That friendly answer is `__str__`.

### 🔍 When to use it
Whenever you want `print(your_object)` to show something readable.

### 💻 How to use it

```python
class Book:
    def __init__(self, title, author):
        self.title = title
        self.author = author

    def __str__(self):
        return f"'{self.title}' by {self.author}"

my_book = Book("The Alchemist", "Paulo Coelho")
print(my_book)   # 'The Alchemist' by Paulo Coelho
```

---

## 7. `__repr__` — The Technical Description

### 🎨 The story
If `__str__` is you introducing yourself at a party, `__repr__` is your ID card — precise, detailed, meant for professionals. Ideally, it looks like the code that would recreate the object.

### 🔍 When to use it
**Always.** Every class deserves a `__repr__` for debugging. If you write only one description method, write this one — Python falls back to it when `__str__` is missing.

### 💻 How to use it

```python
class Book:
    def __init__(self, title, author):
        self.title = title
        self.author = author

    def __repr__(self):
        return f"Book(title={self.title!r}, author={self.author!r})"

my_book = Book("The Alchemist", "Paulo Coelho")
print(repr(my_book))   # Book(title='The Alchemist', author='Paulo Coelho')
```

### 🧒 In Plain English
Notice the `!r` inside `{self.title!r}`? That's a special trick that says: *"Wrap this in quotes so it looks like a real string."* Without `!r`, you'd see `title=The Alchemist` (looks weird). With `!r`, you get `title='The Alchemist'` (looks like code you could actually paste back).

---

## 8. `__format__` — Custom Formatting

### 🎨 The story
Think of a chef preparing the same dish in different ways — plated for a fine restaurant, wrapped for takeaway, or arranged for a buffet. `__format__` lets your object present itself differently depending on the format string requested.

### 🔍 When to use it
When you want your object to work nicely with `format()` and f-strings using format specifiers.

### 💻 How to use it

```python
class Money:
    def __init__(self, amount):
        self.amount = amount

    def __format__(self, spec):
        if spec == "long":
            return f"{self.amount} US dollars"
        elif spec == "short":
            return f"${self.amount}"
        return str(self.amount)

price = Money(50)
print(f"{price:short}")   # $50
print(f"{price:long}")    # 50 US dollars
print(f"{price}")         # 50
```

### 🧒 In Plain English
In f-strings you can add a colon and a "style code" like `f"{price:short}"`. Python passes that word (`"short"`) into your `__format__` method. Your method looks at it and returns the version the caller asked for. It's like saying to a photo printer: *"Give me the wallet-size version"* or *"Give me the poster-size version."*

---

## 9. `__bytes__` — Raw Bytes Representation

### 🎨 The story
Sometimes you need to send your object over a network or save it to a file — situations that need raw bytes, not friendly text. `__bytes__` provides that raw form.

### 🔍 When to use it
When your object needs to be converted to `bytes` for network transmission, file storage, or low-level protocols.

### 💻 How to use it

```python
class Message:
    def __init__(self, text):
        self.text = text

    def __bytes__(self):
        return self.text.encode("utf-8")

msg = Message("Hello")
print(bytes(msg))   # b'Hello'
```

### 🧒 In Plain English
- **Text** vs **bytes**: humans read text ("Hello"). Computers, networks, and files store **bytes** — sequences of 0s and 1s.
- **`.encode("utf-8")`** translates text into bytes using the standard "UTF-8" encoding rules.
- **`b'Hello'`** is how Python prints bytes — the `b` in front just means "these are bytes, not text."

Think of it like converting a letter into Morse code before sending it over telegraph.

---

# ⚖️ PART C: Comparison Operators

*Teaching Python how to compare your objects.*

---

## 10. `__eq__` — Are We Equal?

### 🎨 The story
Two twins can look identical. But are they *the same person*? `__eq__` decides what counts as "equal" for your objects.

### 🔍 When to use it
Whenever your object has a meaningful notion of equality — two products with the same ID, two dates on the same day, two coordinates at the same location.

### 💻 How to use it

```python
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y

print(Point(1, 2) == Point(1, 2))   # True
print(Point(1, 2) == Point(3, 4))   # False
```

---

## 11. `__ne__` — Are We Not Equal?

### 🎨 The story
The opposite of `__eq__`. Python usually figures this out automatically from `__eq__`, but you can override it if you need special behavior.

### 🔍 When to use it
Almost never. Python auto-generates it from `__eq__`. Only override it in unusual cases where "not equal" needs special logic.

### 💻 How to use it

```python
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __ne__(self, other):
        return self.x != other.x or self.y != other.y
```

---

## 12. `__lt__` — Less Than (`<`)

### 🎨 The story
A teacher lining up students by height needs to compare any two students and decide who is shorter. `__lt__` is that comparison.

### 🔍 When to use it
When your objects have a natural ordering. Also required for `sorted()` and `min()`/`max()` to work.

### 💻 How to use it

```python
class Student:
    def __init__(self, name, score):
        self.name = name
        self.score = score

    def __lt__(self, other):
        return self.score < other.score

    def __repr__(self):
        return f"{self.name}({self.score})"

students = [Student("Alice", 85), Student("Bob", 92), Student("Carol", 78)]
print(sorted(students))   # [Carol(78), Alice(85), Bob(92)]
```

---

## 13. `__le__` — Less Than or Equal (`<=`) 🟡

### 🎨 The story
A theme park height sign: *"You must be **this tall or shorter** to enter the kids' zone."* `__le__` decides when your object counts as "less than or equal to" another.

### 🔍 When to use it
Whenever you need `<=` comparisons — filtering items up to a threshold, checking eligibility bands, sorting with ties.

### 💻 How to use it

```python
class Version:
    def __init__(self, number):
        self.number = number

    def __le__(self, other):
        return self.number <= other.number

print(Version(1) <= Version(2))   # True
print(Version(3) <= Version(3))   # True
```

---

## 14. `__gt__` — Greater Than (`>`) 🟡

### 🎨 The story
A gym's leaderboard: *"Who lifted more than 100 kg today?"* `__gt__` powers those "greater than" comparisons.

### 🔍 When to use it
Whenever `>` should work on your objects — leaderboards, thresholds, filtering the top performers.

### 💻 How to use it

```python
class Score:
    def __init__(self, value):
        self.value = value

    def __gt__(self, other):
        return self.value > other.value

print(Score(90) > Score(70))   # True
```

---

## 15. `__ge__` — Greater Than or Equal (`>=`) 🟡

### 🎨 The story
A voting-age check: *"You must be **18 or older** to vote."* `__ge__` handles the "at least this much" comparisons.

### 🔍 When to use it
Whenever your object needs `>=` — age checks, minimum-requirement filters, "meets or exceeds" logic.

### 💻 How to use it

```python
class Age:
    def __init__(self, years):
        self.years = years

    def __ge__(self, other):
        return self.years >= other.years

print(Age(21) >= Age(18))   # True
print(Age(17) >= Age(18))   # False
```

### ⚠️ Time-saving tip for all comparison methods
Writing all six comparison methods is tedious. Use `functools.total_ordering`:

```python
from functools import total_ordering

@total_ordering
class Product:
    def __init__(self, price):
        self.price = price

    def __eq__(self, other):
        return self.price == other.price

    def __lt__(self, other):
        return self.price < other.price
    # Python now provides <=, >, >= automatically!
```

---

## 16. `__hash__` — The Object's Fingerprint

### 🎨 The story
Every guest at a hotel gets a unique ID card. `__hash__` gives your object an ID so Python can store it in sets and use it as a dictionary key.

### 🔍 When to use it
Whenever you define `__eq__` and want the object to work in sets or as dictionary keys.

### 💻 How to use it

```python
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y

    def __hash__(self):
        return hash((self.x, self.y))

points = {Point(1, 2), Point(1, 2), Point(3, 4)}
print(len(points))   # 2 — duplicates removed automatically
```

### ⚠️ Golden rule
If two objects are equal (`__eq__` returns `True`), they **must** have the same hash. Break this rule and dictionaries and sets will behave mysteriously.

---

# ➕ PART D: Arithmetic Operators

*Making your objects do math.*

---

## 17. `__add__` — Addition (`+`)

### 🎨 The story
Two piggy banks — one with $50, one with $30. Pour them together and you get $80. `__add__` lets your objects combine using the `+` sign.

### 🔍 When to use it
When "adding" two of your objects has a natural meaning — money, distances, times, coordinates.

### 💻 How to use it

```python
class Money:
    def __init__(self, amount):
        self.amount = amount

    def __add__(self, other):
        return Money(self.amount + other.amount)

    def __str__(self):
        return f"${self.amount}"

wallet = Money(50) + Money(30)
print(wallet)   # $80
```

---

## 18. `__sub__` — Subtraction (`-`)

### 💻 How to use it

```python
class Money:
    def __init__(self, amount):
        self.amount = amount

    def __sub__(self, other):
        return Money(self.amount - other.amount)

    def __str__(self):
        return f"${self.amount}"

print(Money(100) - Money(30))   # $70
```

---

## 19. `__mul__` — Multiplication (`*`)

### 💻 How to use it

```python
class Money:
    def __init__(self, amount):
        self.amount = amount

    def __mul__(self, times):
        return Money(self.amount * times)

    def __str__(self):
        return f"${self.amount}"

print(Money(10) * 5)   # $50
```

---

## 20. `__truediv__` — True Division (`/`)

### 🎨 The story
Splitting a $100 restaurant bill among 4 friends. Each pays $25. That is `__truediv__`.

### 💻 How to use it

```python
class Money:
    def __init__(self, amount):
        self.amount = amount

    def __truediv__(self, divisor):
        return Money(self.amount / divisor)

    def __str__(self):
        return f"${self.amount}"

print(Money(100) / 4)   # $25.0
```

---

## 21. `__floordiv__` — Floor Division (`//`)

### 🎨 The story
Dividing 10 candies among 3 kids. Each kid gets 3 (with 1 candy left over). `__floordiv__` gives the whole-number result without the leftover.

### 💻 How to use it

```python
class Candy:
    def __init__(self, count):
        self.count = count

    def __floordiv__(self, kids):
        return Candy(self.count // kids)

    def __str__(self):
        return f"{self.count} candies"

print(Candy(10) // 3)   # 3 candies
```

---

## 22. `__mod__` — Modulo / Remainder (`%`)

### 🎨 The story
After splitting 10 candies among 3 kids, 1 candy is left over. `__mod__` gives you that remainder.

### 💻 How to use it

```python
class Candy:
    def __init__(self, count):
        self.count = count

    def __mod__(self, kids):
        return Candy(self.count % kids)

    def __str__(self):
        return f"{self.count} candies"

print(Candy(10) % 3)   # 1 candies
```

---

## 23. `__divmod__` — Divide and Get Remainder Together

### 🎨 The story
Sometimes you want both answers at once — how many each kid gets, *and* how many are left over. That is `divmod()`.

### 💻 How to use it

```python
class Candy:
    def __init__(self, count):
        self.count = count

    def __divmod__(self, kids):
        each, leftover = divmod(self.count, kids)
        return (each, leftover)

print(divmod(Candy(10), 3))   # (3, 1)
```

---

## 24. `__pow__` — Power (`**`)

### 🎨 The story
Raising a number to a power — 2 to the 3rd is 8. `__pow__` handles the `**` operator.

### 💻 How to use it

```python
class Number:
    def __init__(self, value):
        self.value = value

    def __pow__(self, exponent):
        return Number(self.value ** exponent)

    def __str__(self):
        return str(self.value)

print(Number(2) ** 3)   # 8
```

---

## 25. `__matmul__` — Matrix Multiplication (`@`)

### 🎨 The story
Used in scientific computing (like NumPy) for matrix multiplication. `@` is a special operator for this.

### 💻 How to use it

```python
class Matrix:
    def __init__(self, name):
        self.name = name

    def __matmul__(self, other):
        return f"{self.name} @ {other.name}"

a = Matrix("A")
b = Matrix("B")
print(a @ b)   # A @ B
```

---

# ↔️ PART E: Reflected Arithmetic (Right-Hand Side)

*When your object appears on the RIGHT of the operator.*

### 🎨 The big story
Imagine two people in a conversation. Python first asks the person on the LEFT how to handle an operation. If they shrug, Python asks the person on the RIGHT. The "r" methods (`__radd__`, `__rsub__`, etc.) are the person on the right stepping in to help.

**Example:** `5 + my_object`. Python asks `5` first. Integer `5` does not know what a `my_object` is, so Python calls `my_object.__radd__(5)`.

---

## 26–33. The Full Reflected Family

| Method | Handles |
|--------|---------|
| `__radd__` | `other + self` |
| `__rsub__` | `other - self` |
| `__rmul__` | `other * self` |
| `__rtruediv__` | `other / self` |
| `__rfloordiv__` | `other // self` |
| `__rmod__` | `other % self` |
| `__rdivmod__` | `divmod(other, self)` |
| `__rpow__` | `other ** self` |
| `__rmatmul__` | `other @ self` |

### 🔍 When to use them
Whenever you want your object to work with primitive types on either side.

### 💻 How to use them

```python
class Money:
    def __init__(self, amount):
        self.amount = amount

    def __add__(self, other):
        n = other.amount if isinstance(other, Money) else other
        return Money(self.amount + n)

    def __radd__(self, other):
        return self.__add__(other)

    def __rmul__(self, times):
        return Money(self.amount * times)

    def __str__(self):
        return f"${self.amount}"

print(Money(50) + 10)   # $60  (uses __add__)
print(10 + Money(50))   # $60  (uses __radd__)
print(3 * Money(20))    # $60  (uses __rmul__)
```

---

# 🔄 PART F: In-Place Operators (`+=`, `-=`, etc.)

*Modifying an object instead of creating a new one.*

### 🎨 The big story
Normally, `a = a + 5` creates a new value. But `a += 5` can update `a` directly — like refilling a glass instead of pouring a new one. The "i" methods (`__iadd__`, `__isub__`, etc.) power these.

---

## 34–41. The Full In-Place Family

| Method | Handles |
|--------|---------|
| `__iadd__` | `+=` |
| `__isub__` | `-=` |
| `__imul__` | `*=` |
| `__itruediv__` | `/=` |
| `__ifloordiv__` | `//=` |
| `__imod__` | `%=` |
| `__ipow__` | `**=` |
| `__imatmul__` | `@=` |

### 💻 How to use them

```python
class Counter:
    def __init__(self, value=0):
        self.value = value

    def __iadd__(self, n):
        self.value += n
        return self

    def __isub__(self, n):
        self.value -= n
        return self

    def __str__(self):
        return f"Counter({self.value})"

c = Counter(10)
c += 5
c -= 2
print(c)   # Counter(13)
```

---

# ➖ PART G: Unary and Sign Operators

*Operators that work on a single value.*

---

## 42. `__neg__` — Negation (`-x`)

### 🎨 The story
Turning something positive into negative — like flipping a coin. If you owe $100 (debt of -100), negating gives you a credit of +100.

### 💻 How to use it

```python
class Balance:
    def __init__(self, amount):
        self.amount = amount

    def __neg__(self):
        return Balance(-self.amount)

    def __str__(self):
        return f"${self.amount}"

b = Balance(100)
print(-b)   # $-100
```

---

## 43. `__pos__` — Positive (`+x`)

### 🔍 When to use it
Rare, but used when `+x` should return the object itself (or a normalized version).

### 💻 How to use it

```python
class Number:
    def __init__(self, value):
        self.value = value

    def __pos__(self):
        return Number(abs(self.value))

print((+Number(-5)).value)   # 5
```

---

## 44. `__abs__` — Absolute Value (`abs()`)

### 🎨 The story
Distance from zero. Whether it is -5 or +5, the *magnitude* is 5. `abs()` gives you that magnitude.

### 💻 How to use it

```python
class Vector:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __abs__(self):
        return (self.x ** 2 + self.y ** 2) ** 0.5

print(abs(Vector(3, 4)))   # 5.0
```

---

## 45. `__invert__` — Bitwise NOT (`~x`)

### 🎨 The story
The `~` operator flips every bit in a number (0s become 1s and vice versa). Think of it as **inverting a photo negative** — everything swaps to its opposite.

### 🔍 When to use it
Rare in everyday code — mostly for bit manipulation or building custom permission systems.

### 💻 How to use it

```python
class Flag:
    def __init__(self, value):
        self.value = value

    def __invert__(self):
        return Flag(~self.value)

f = Flag(5)
inverted = ~f
print(inverted.value)   # -6
```

### 🧒 In Plain English
Why does `~5` give `-6`? Because of how computers store numbers using bits. The math shortcut is: `~x` always equals `-(x + 1)`. So `~5 = -6`, `~10 = -11`, and so on. Unless you're doing low-level bit tricks, you can safely ignore this one.

---

## 46. `__round__` — Rounding (`round()`)

### 💻 How to use it

```python
class Price:
    def __init__(self, amount):
        self.amount = amount

    def __round__(self, digits=0):
        return Price(round(self.amount, digits))

    def __str__(self):
        return f"${self.amount}"

p = Price(19.876)
print(round(p, 2))   # $19.88
```

---

## 47. `__trunc__` — Chop Off the Decimals

### 🎨 The story
Cutting off everything after the decimal point — like slicing off the fractional part with scissors. `3.7` becomes `3`, and `-3.7` becomes `-3`.

### 💻 How to use it

```python
import math

class Number:
    def __init__(self, value):
        self.value = value

    def __trunc__(self):
        return int(self.value)

print(math.trunc(Number(3.7)))    # 3
print(math.trunc(Number(-3.7)))   # -3
```

---

## 48. `__floor__` — Round Down

### 🎨 The story
Always rounds **down** to the nearest whole number. Whether you have `3.2` or `3.9`, both become `3`. Different from `trunc` when it comes to negative numbers.

### 💻 How to use it

```python
import math

class Number:
    def __init__(self, value):
        self.value = value

    def __floor__(self):
        return math.floor(self.value)

print(math.floor(Number(3.7)))   # 3
print(math.floor(Number(3.2)))   # 3
```

---

## 49. `__ceil__` — Round Up

### 🎨 The story
Ordering pizzas for 13 people (3 per pizza). You can't buy 4.33 pizzas — you round **up** to 5. `math.ceil()` always rounds up.

### 💻 How to use it

```python
import math

class Number:
    def __init__(self, value):
        self.value = value

    def __ceil__(self):
        return math.ceil(self.value)

print(math.ceil(Number(3.2)))   # 4
print(math.ceil(Number(3.9)))   # 4
```

### 🧒 In Plain English
Both `3.2` and `3.9` round **up** to `4` — that's what "ceiling" means. Whereas floor rounds down, ceiling rounds up.

---

# 🔀 PART H: Bitwise Operators

*Working with individual bits — used in permissions, flags, low-level code.*

### 🧒 First: What Are Binary Numbers?

Computers store everything as **bits** — tiny switches that are either 0 (off) or 1 (on). A group of bits like `1100` is a **binary number**.

In Python code, binary numbers are written with a `0b` prefix, so `0b1100` means "the binary number 1100" (which equals 12 in normal decimal).

Bitwise operators work on each bit individually:

```
  1100    (12 in binary)
& 1010    (10 in binary)  <- the & operator
------
  1000    (8 in binary) — 1 only where BOTH have 1
```

Think of each bit like a **light switch**. Bitwise operators are ways of comparing or flipping many switches at once. This is used for **permissions** (read/write/execute), **feature flags**, and low-level programming.

If you never plan to build a permissions system or write low-level code, you can skip this entire section — beginners rarely need it.

---

## 50. `__and__` — Bitwise AND (`&`)

### 🎨 The story
Two people can only enter a room if **both** have keys. AND is true only when both sides are true.

### 💻 How to use it

```python
class Permission:
    def __init__(self, bits):
        self.bits = bits

    def __and__(self, other):
        return Permission(self.bits & other.bits)

    def __str__(self):
        return bin(self.bits)

result = Permission(0b1100) & Permission(0b1010)
print(result)   # 0b1000
```

### 🧒 In Plain English
Bit by bit: `1&1=1`, but `1&0=0` and `0&0=0`. Only where **both** have 1 does the result get a 1. Useful for checking "does this user have both permissions?"

---

## 51. `__or__` — Bitwise OR (`|`)

### 🎨 The story
Anyone with *either* key can enter. OR is true if either side is true.

### 💻 How to use it

```python
class Permission:
    def __init__(self, bits):
        self.bits = bits

    def __or__(self, other):
        return Permission(self.bits | other.bits)

    def __str__(self):
        return bin(self.bits)

print(Permission(0b1100) | Permission(0b1010))   # 0b1110
```

---

## 52. `__xor__` — Exclusive OR (`^`)

### 🎨 The story
"Either one but not both." XOR is true when the two sides differ.

### 💻 How to use it

```python
class Bits:
    def __init__(self, value):
        self.value = value

    def __xor__(self, other):
        return Bits(self.value ^ other.value)

    def __str__(self):
        return bin(self.value)

print(Bits(0b1100) ^ Bits(0b1010))   # 0b110
```

---

## 53. `__lshift__` — Left Shift (`<<`)

### 🎨 The story
Shifting bits to the left is like **multiplying by powers of 2**. `x << 1` doubles it. `x << 2` multiplies by 4. `x << 3` multiplies by 8.

### 💻 How to use it

```python
class Number:
    def __init__(self, value):
        self.value = value

    def __lshift__(self, n):
        return Number(self.value << n)

    def __str__(self):
        return str(self.value)

print(Number(4) << 2)   # 16  (4 * 4)
print(Number(3) << 3)   # 24  (3 * 8)
```

---

## 54. `__rshift__` — Right Shift (`>>`)

### 🎨 The story
The opposite — shifting right is like **dividing by powers of 2** (throwing away any remainder). `x >> 1` halves it. `x >> 2` divides by 4.

### 💻 How to use it

```python
class Number:
    def __init__(self, value):
        self.value = value

    def __rshift__(self, n):
        return Number(self.value >> n)

    def __str__(self):
        return str(self.value)

print(Number(16) >> 2)   # 4  (16 / 4)
print(Number(20) >> 1)   # 10 (20 / 2)
```

---

## 55–60. Reflected and In-Place Bitwise Operators

Just like arithmetic, bitwise operations have reflected and in-place versions:

- `__rand__`, `__ror__`, `__rxor__`, `__rlshift__`, `__rrshift__` — for right-side operations
- `__iand__`, `__ior__`, `__ixor__`, `__ilshift__`, `__irshift__` — for `&=`, `|=`, `^=`, `<<=`, `>>=`

### 💻 Example

```python
class Flags:
    def __init__(self, value):
        self.value = value

    def __ior__(self, other):
        self.value |= other.value
        return self

    def __str__(self):
        return bin(self.value)

f = Flags(0b1000)
f |= Flags(0b0011)
print(f)   # 0b1011
```

---

# 🔢 PART I: Type Conversion

*Turning your object into other basic types.*

---

## 61. `__bool__` — True or False?

### 🎨 The story
A bouncer at a club asking, "Are you *something* or *nothing*?" `__bool__` answers.

### 🔍 When to use it
Whenever `if my_object:` should behave in a special way (like "an empty cart is falsy").

### 💻 How to use it

```python
class ShoppingCart:
    def __init__(self):
        self.items = []

    def __bool__(self):
        return len(self.items) > 0

cart = ShoppingCart()
if cart:
    print("Ready!")
else:
    print("Cart is empty.")   # This runs
```

---

## 62. `__int__` — Convert to Integer

### 💻 How to use it

```python
class Temperature:
    def __init__(self, celsius):
        self.celsius = celsius

    def __int__(self):
        return int(self.celsius)

print(int(Temperature(36.6)))   # 36
```

---

## 63. `__float__` — Convert to Float

### 💻 How to use it

```python
class Distance:
    def __init__(self, meters):
        self.meters = meters

    def __float__(self):
        return float(self.meters)

print(float(Distance(5)))   # 5.0
```

---

## 64. `__complex__` — Convert to Complex Number

### 🎨 The story
A **complex number** is a number with two parts: a "real" part and an "imaginary" part (used in engineering, physics, and signal processing). In Python, `3+4j` means "3 real plus 4 imaginary." Ignore this if you don't do math-heavy work.

### 💻 How to use it

```python
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __complex__(self):
        return complex(self.x, self.y)

print(complex(Point(3, 4)))   # (3+4j)
```

### 🧒 In Plain English
Very few people ever need this. Skip unless you work with signal processing, electrical engineering, or advanced math.

---

## 65. `__index__` — Use as an Index

### 🎨 The story
Only integers can be used as list indices. `__index__` tells Python, "Treat me as an integer for indexing purposes."

### 💻 How to use it

```python
class Position:
    def __init__(self, value):
        self.value = value

    def __index__(self):
        return self.value

items = ["a", "b", "c", "d"]
print(items[Position(2)])   # c
```

---

# 📦 PART J: Container Behavior (Making Objects Act Like Lists)

*The methods that turn your object into a collection.*

---

## 66. `__len__` — How Big Am I?

### 🎨 The story
Counting items in a shopping basket. `len()` uses this method.

### 💻 How to use it

```python
class Playlist:
    def __init__(self):
        self.songs = []

    def add(self, song):
        self.songs.append(song)

    def __len__(self):
        return len(self.songs)

p = Playlist()
p.add("Song A")
p.add("Song B")
print(len(p))   # 2
```

---

## 67. `__length_hint__` — An Educated Guess

### 🎨 The story
Imagine you're delivering a truckload of items, but you don't know the exact count — you can estimate *"about 1,000."* That estimate helps the receiver prepare the right size of storage. `__length_hint__` is that estimate, used when Python doesn't know the exact size but a rough number helps.

### 🔍 When to use it
Very rare. Used for custom streams or generators where the exact count is unknown but Python can benefit from a hint (for example, when converting to a list, Python can pre-allocate the right size).

### 💻 How to use it

```python
class MyStream:
    def __length_hint__(self):
        return 1000   # rough estimate

import operator
print(operator.length_hint(MyStream()))   # 1000
```

---

## 68. `__getitem__` — Reading by Key or Index

### 🎨 The story
Picking a specific book from a shelf by its position or its title. `__getitem__` handles `obj[key]`.

### 💻 How to use it

```python
class Playlist:
    def __init__(self):
        self.songs = []

    def add(self, song):
        self.songs.append(song)

    def __getitem__(self, index):
        return self.songs[index]

p = Playlist()
p.add("Song A")
p.add("Song B")
print(p[0])   # Song A
```

---

## 69. `__setitem__` — Writing by Key or Index

### 💻 How to use it

```python
class Playlist:
    def __init__(self):
        self.songs = []

    def add(self, song):
        self.songs.append(song)

    def __setitem__(self, index, value):
        self.songs[index] = value

    def __getitem__(self, index):
        return self.songs[index]

p = Playlist()
p.add("Song A")
p[0] = "New Song"
print(p[0])   # New Song
```

---

## 70. `__delitem__` — Deleting by Key or Index

### 💻 How to use it

```python
class Playlist:
    def __init__(self):
        self.songs = ["A", "B", "C"]

    def __delitem__(self, index):
        del self.songs[index]

p = Playlist()
del p[1]
print(p.songs)   # ['A', 'C']
```

---

## 71. `__missing__` — Handling Missing Dictionary Keys

### 🎨 The story
When you look up a word in a paper dictionary and it isn't there, most people just close the book. But some dictionaries add a note: *"See related word instead."* `__missing__` lets you decide what happens when someone looks up a key you don't have — you can return a default instead of raising an error.

### 🔍 When to use it
When you want a dictionary-like object with smart defaults, fallbacks, or auto-generated values.

### 💻 How to use it

```python
class SmartDict(dict):
    def __missing__(self, key):
        return f"'{key}' not found"

d = SmartDict()
d["hello"] = "hi"
print(d["hello"])     # hi
print(d["missing"])   # 'missing' not found
```

### 🧒 In Plain English
- **`class SmartDict(dict):`** means "SmartDict is a **special kind of** regular dict." It gets all the normal dict behavior for free, then adds `__missing__` on top.
- Normally, doing `d["missing"]` on a dictionary crashes with a `KeyError`. But now, thanks to `__missing__`, it politely returns a friendly message instead.

Real-world use: word counters that start at 0, cache lookups with defaults, config systems with sensible fallbacks.

---

## 72. `__contains__` — The `in` Operator

### 💻 How to use it

```python
class Playlist:
    def __init__(self):
        self.songs = ["A", "B", "C"]

    def __contains__(self, song):
        return song in self.songs

p = Playlist()
print("A" in p)   # True
print("Z" in p)   # False
```

---

# 🔁 PART K: Iteration

*Making your object usable in `for` loops.*

---

## 73. `__iter__` — Start of the Journey

### 🎨 The story
Picking up a Pez candy dispenser to use it. `__iter__` returns the "iterator" — the thing that keeps track of your position.

### 💻 How to use it

```python
class Countdown:
    def __init__(self, start):
        self.start = start

    def __iter__(self):
        self.current = self.start
        return self

    def __next__(self):
        if self.current <= 0:
            raise StopIteration
        self.current -= 1
        return self.current + 1

for n in Countdown(3):
    print(n)   # 3, 2, 1
```

---

## 74. `__next__` — The Next Item

### 🔍 When to use it
Together with `__iter__` to build custom iterators. Signal the end by raising `StopIteration`.

*(See example above for `__iter__`.)*

---

## 75. `__reversed__` — Iterate Backward

### 💻 How to use it

```python
class Deck:
    def __init__(self):
        self.cards = ["A", "K", "Q", "J"]

    def __reversed__(self):
        return reversed(self.cards)

for card in reversed(Deck()):
    print(card)   # J, Q, K, A
```

---

# ⚡ PART L: Callable Objects

*Making your objects usable like functions.*

---

## 76. `__call__` — Object as a Function

### 🎨 The story
A Swiss Army knife is an object — but you can also *use* it directly for tasks. `__call__` gives your objects that same double life.

### 💻 How to use it

```python
class Multiplier:
    def __init__(self, factor):
        self.factor = factor

    def __call__(self, number):
        return number * self.factor

double = Multiplier(2)
triple = Multiplier(3)
print(double(10))   # 20
print(triple(10))   # 30
```

### 🔍 When to use it
When you need a function-like thing that also remembers state — counters, configurable tools, machine learning models.

---

# 🚪 PART M: Context Managers (`with` Statement)

*Automatic setup and cleanup.*

---

## 77. `__enter__` — Setting Up

### 🎨 The story
Checking into a hotel room. Lights turn on, keycard given.

### 💻 How to use it

```python
class DatabaseConnection:
    def __enter__(self):
        print("Opening connection")
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        print("Closing connection")

with DatabaseConnection() as db:
    print("Doing work")
# Output:
# Opening connection
# Doing work
# Closing connection
```

---

## 78. `__exit__` — Cleaning Up

### 🔍 When to use it
For anything that needs guaranteed cleanup — files, connections, locks, temporary state.

### ⚠️ Note
`__exit__` runs **even if an error happens**. That is what makes context managers so safe and powerful.

---

## 79. `__aenter__` and 80. `__aexit__` — Async Context Managers

### 🎨 The story
The same idea, but for asynchronous code (running things in parallel without blocking).

### 💻 How to use it

```python
import asyncio

class AsyncResource:
    async def __aenter__(self):
        print("Opening resource")
        return self

    async def __aexit__(self, exc_type, exc_value, traceback):
        print("Closing resource")

async def main():
    async with AsyncResource() as r:
        print("Using resource")

asyncio.run(main())
```

---

# 🔍 PART N: Attribute Access

*Controlling what happens when someone reads or writes attributes.*

---

## 81. `__getattr__` — When Attribute Is Missing

### 🎨 The story
A helpful receptionist who, when asked about something the office does not have, provides a friendly default instead of a rude error.

### 🔍 When to use it
When you want to provide fallback behavior for missing attributes.

### 💻 How to use it

```python
class Flexible:
    def __getattr__(self, name):
        return f"'{name}' is not set"

f = Flexible()
print(f.anything)   # 'anything' is not set
```

---

## 82. `__getattribute__` — Every Attribute Read

### 🎨 The story
Every single time someone reads any attribute — even `obj.x` — this method runs. It's like a **security camera** watching every access. Powerful, but easy to break.

### ⚠️ Warning
This runs for **every** attribute access, not just missing ones. Very easy to create infinite loops.

### 💻 How to use it

```python
class Logged:
    def __getattribute__(self, name):
        print(f"Reading {name}")
        return super().__getattribute__(name)

    def __init__(self):
        self.x = 10

obj = Logged()
print(obj.x)
# Reading x
# 10
```

### 🧒 In Plain English
- **`super().__getattribute__(name)`** means: *"Let Python's normal machinery do the actual lookup — I just want to add my log message before it happens."*
- Why `super()`? Because if you tried to write `return self.x` inside `__getattribute__`, that would trigger `__getattribute__` again... which would trigger it again... infinite loop! Using `super()` is the safe way to escape.

Think of it like sneaking a note into someone else's process without breaking their workflow.

---

## 83. `__setattr__` — Every Attribute Write

### 🎨 The story
Every time someone writes to an attribute (`obj.x = 5`), this method runs first. Perfect for **logging, validation, or blocking** certain writes.

### 💻 How to use it

```python
class Logged:
    def __setattr__(self, name, value):
        print(f"Setting {name} = {value}")
        super().__setattr__(name, value)

obj = Logged()
obj.x = 5   # Setting x = 5
```

### 🧒 In Plain English
Same trap as `__getattribute__` — if you write `self.name = value` directly inside `__setattr__`, it triggers itself in an infinite loop. `super().__setattr__(name, value)` is the safe way to actually store the value.

---

## 84. `__delattr__` — Deleting Attributes

### 🎨 The story
Runs whenever someone uses `del obj.x`. Lets you block or log deletions.

### 🔍 When to use it
When you want to protect certain attributes from being deleted, or log deletions.

### 💻 How to use it

```python
class Protected:
    def __delattr__(self, name):
        print(f"Deleting {name}")
        super().__delattr__(name)

p = Protected()
p.x = 5
del p.x   # Deleting x
```

---

## 85. `__dir__` — Custom `dir()` Output

### 🎨 The story
`dir(obj)` normally lists all methods and attributes of an object — useful for exploration. `__dir__` lets you customize that list, showing only what you want users to see.

### 🔍 When to use it
When building objects with many "hidden" attributes and you want `dir()` to show only the public ones.

### 💻 How to use it

```python
class Custom:
    def __dir__(self):
        return ["custom", "attributes", "only"]

print(dir(Custom()))   # ['attributes', 'custom', 'only']
```

---

## 86. `__slots__` — Limiting Attributes

### 🎨 The story
Imagine a small parking lot with painted lines — only certain spots are allowed. `__slots__` limits which attributes an object can have, saving memory when you create millions of them.

### 🔍 When to use it
- When you create huge numbers of small objects (millions) and memory matters.
- When you want to prevent accidental typos like `p.xyz = 5` from silently creating new attributes.

### 💻 How to use it

```python
class Point:
    __slots__ = ("x", "y")

    def __init__(self, x, y):
        self.x = x
        self.y = y

p = Point(1, 2)
print(p.x, p.y)   # 1 2

# p.z = 3   # AttributeError: 'Point' object has no attribute 'z'
```

### 🧒 In Plain English
Normally, Python lets you slap **any** new attribute onto an object at any time. `__slots__` says: *"No! Only these named attributes are allowed."* This is both stricter (safer) and more memory-efficient because Python can pre-allocate exactly the right amount of storage.

---

# 🧬 PART O: Descriptors

*Advanced: controlling attribute behavior at the class level.*

### 🧒 Before You Start: What's a Descriptor?

**Skip this section on your first read.** Descriptors are one of Python's most advanced features. You almost never write them yourself — but big frameworks (Django, SQLAlchemy) use them heavily.

**In one sentence:** a descriptor is a special class that decides what happens when you read, write, or delete an attribute of another class. Think of it as a **smart guard** standing at the door of an attribute, checking every visitor.

---

## 87. `__get__` — Custom Attribute Reading

## 88. `__set__` — Custom Attribute Writing

## 89. `__delete__` — Custom Attribute Deletion

### 🎨 The story
Think of a smart meter on your electricity supply. Every time electricity flows in or out, the meter records it. Descriptors are like smart meters for attributes — they intercept every read and write.

### 🔍 When to use them
When building frameworks. In everyday code, you'll almost never need them.

### 💻 How to use them

```python
class Positive:
    """A descriptor that only allows positive numbers."""

    def __set_name__(self, owner, name):
        self.name = name

    def __get__(self, obj, objtype=None):
        return obj.__dict__.get(self.name, 0)

    def __set__(self, obj, value):
        if value < 0:
            raise ValueError(f"{self.name} must be positive")
        obj.__dict__[self.name] = value

class Product:
    price = Positive()
    stock = Positive()

p = Product()
p.price = 10
p.stock = 5
print(p.price, p.stock)   # 10 5

# p.price = -1   # ValueError: price must be positive
```

### 🧒 In Plain English
- We create a `Positive` guard that only allows positive numbers.
- Inside `Product`, we say `price = Positive()` and `stock = Positive()` — meaning both `price` and `stock` are guarded.
- Now, `p.price = -1` gets **rejected** because the guard says no.

This is how form-validation libraries and database ORMs (like Django's models) enforce rules on every field.

---

# 🏛️ PART P: Class and Metaclass Magic

*Advanced customization of classes themselves.*

### 🧒 Before You Start: What's a Metaclass?

**Feel free to skip this whole section for now.** Metaclasses are Python's deepest magic — 99% of Python developers never write one.

**In one sentence:** if a class is a **factory** that produces objects, a **metaclass is a factory that produces classes**. Just like `Dog("Buddy")` creates a Dog object, `type("MyClass", ...)` can create classes on the fly.

**Real-world use:** almost only for building sophisticated frameworks like Django, Pydantic, or SQLAlchemy. In application code, you'll never need this.

---

## 90. `__instancecheck__` — Custom `isinstance()`

### 🎨 The story
Normally, `isinstance(x, Dog)` asks: *"Is `x` a Dog?"* With `__instancecheck__`, you can **redefine what counts as being a certain type** — regardless of actual inheritance.

### 🔍 When to use it
When building abstract type systems that don't rely on real inheritance (like `abc.ABC`).

### 💻 How to use it

```python
class EvenMeta(type):
    def __instancecheck__(cls, instance):
        return isinstance(instance, int) and instance % 2 == 0

class Even(metaclass=EvenMeta):
    pass

print(isinstance(4, Even))   # True
print(isinstance(5, Even))   # False
```

### 🧒 In Plain English
We built a fake class called `Even` that answers *"yes, I'm an instance of Even"* only for even numbers. Now `isinstance(4, Even)` is `True` and `isinstance(5, Even)` is `False` — even though `4` and `5` are plain integers with no relationship to `Even`. Weird, powerful, and almost never needed in normal code.

---

## 91. `__subclasscheck__` — Custom `issubclass()`

### 🎨 The story
Same idea as `__instancecheck__`, but for `issubclass()` — you can control what counts as being a **subclass**.

### 💻 How to use it

```python
class MyMeta(type):
    def __subclasscheck__(cls, subclass):
        return True   # accept anything as a subclass

class Universal(metaclass=MyMeta):
    pass

print(issubclass(str, Universal))   # True
print(issubclass(int, Universal))   # True
```

### 🧒 In Plain English
This example is silly on purpose — `Universal` claims **everything** is a subclass of it. In real code, you'd write specific rules, like "accept it as a subclass if it has certain methods."

---

## 92. `__subclasshook__` — Duck-Typing Hook

### 🎨 The story
"If it walks like a duck and quacks like a duck, it's a duck." `__subclasshook__` lets an abstract class say: *"I don't care about inheritance — just check if the object has the right methods."*

### 🔍 When to use it
When building abstract base classes (ABCs) that identify types by capability, not by inheritance.

### 💻 How to use it

```python
from abc import ABC

class Sized(ABC):
    @classmethod
    def __subclasshook__(cls, other):
        # Consider any class with __len__ a subclass of Sized
        if any("__len__" in B.__dict__ for B in other.__mro__):
            return True
        return NotImplemented

print(issubclass(list, Sized))    # True — list has __len__
print(issubclass(str, Sized))     # True — str has __len__
print(issubclass(int, Sized))     # False — int doesn't
```

### 🧒 In Plain English
We're saying: *"Any class that has a `__len__` method counts as `Sized`, no matter what its family tree looks like."* This is Python's way of doing type-checking based on **capability** instead of **ancestry**.

---

## 93. `__class_getitem__` — Generic Class Syntax

### 🎨 The story
Ever seen `list[int]` or `dict[str, int]` in type hints? That square-bracket syntax is powered by `__class_getitem__`. It lets your class accept parameters inside brackets, like a template.

### 🔍 When to use it
When building generic containers or type hint systems.

### 💻 How to use it

```python
class Container:
    def __class_getitem__(cls, item):
        return f"Container of {item}"

print(Container[int])   # Container of <class 'int'>
print(Container[str])   # Container of <class 'str'>
```

### 🧒 In Plain English
Normally `MyClass[X]` would be an error. But if you define `__class_getitem__`, Python calls it when someone uses that syntax. This is how `list[int]` (meaning "a list of ints") became valid Python.

---

## 94. `__mro_entries__` — Custom MRO Entries

### 🔍 When to use it
Rare — used when a class is not a proper class but should still work in an inheritance list. Safe to skip.

---

## 95. `__prepare__` — Metaclass Namespace Preparation

### 🔍 When to use it
Very advanced. Used inside metaclasses to control how the class body's namespace is built. Almost no one writes this. Safe to skip.

---

# ⏳ PART Q: Async / Await

*For asynchronous programming.*

### 🧒 Before You Start: What's "Async"?

**Async** is a way to write programs that can do many things **at the same time** without waiting. Instead of "download file → wait → then do next thing," async code can start 100 downloads at once and handle each as it completes.

Real-world analogy: a **restaurant waiter**. A synchronous waiter takes one table's order, waits for the food to be cooked, delivers it, and only then goes to the next table. An async waiter takes many orders, checks back on each when the food is ready, and serves many tables in parallel.

Async is used heavily in **web servers, APIs, and network apps**. If you don't write those, you can skip this section.

---

## 96. `__await__` — Making Objects Awaitable

### 🎨 The story
`await` is the keyword you put in front of something to say *"wait for this to finish, but let other work happen in the meantime."* `__await__` is what makes your object usable with `await`.

### 🔍 When to use it
Almost never directly — most people use `async def` functions instead, which handle `__await__` automatically. Only used when building async libraries.

### 💻 How to use it

```python
class MyAwaitable:
    def __await__(self):
        yield         # pause here, letting others run
        return "done"

# Used inside an async function:
# result = await MyAwaitable()
```

### 🧒 In Plain English
Very advanced. In everyday async code, you'd just write `async def my_task():` and use `await`. Only library authors define `__await__` themselves.

---

## 97. `__aiter__` — Async Iteration Start

## 98. `__anext__` — Async Next Item

### 🎨 The story
Just like `__iter__` and `__next__` power regular `for` loops, `__aiter__` and `__anext__` power `async for` loops — where each step might involve waiting (like fetching pages from a website).

### 🔍 When to use them
When building an async data source — reading rows from a database one at a time, streaming API results, following a live feed.

### 💻 How to use it

```python
import asyncio

class AsyncCounter:
    def __init__(self, limit):
        self.limit = limit
        self.i = 0

    def __aiter__(self):
        return self

    async def __anext__(self):
        if self.i >= self.limit:
            raise StopAsyncIteration
        self.i += 1
        await asyncio.sleep(0.1)   # simulate a slow operation
        return self.i

async def main():
    async for n in AsyncCounter(3):
        print(n)

asyncio.run(main())
# 1
# 2
# 3
```

### 🧒 In Plain English
This is a counter that "waits 0.1 seconds" between each number — imitating a real-world async task like fetching data over the internet. `async for` walks through the counter, pausing at each step without blocking other work.

---

# 💾 PART R: Copying and Pickling

*Saving, loading, and duplicating objects.*

### 🧒 Before You Start: What's "Pickling"?

**Pickling** is Python's word for **saving an object to a file so you can load it back later**, keeping all its data intact. Think of it like taking a photograph of an object's current state so you can bring it back exactly as it was — days, weeks, or months later.

Real-world uses: saving game progress, caching computed results, sending complex objects between programs.

---

## 99. `__copy__` — Shallow Copy

### 🎨 The story
Making a **duplicate** of an object. A "shallow" copy makes a new outer box but the items inside are still shared with the original. Like photocopying a folder — you get a new folder, but the photos inside are the same photos.

### 🔍 When to use it
When you want to control how your objects are duplicated by `copy.copy()`.

### 💻 How to use it

```python
import copy

class Box:
    def __init__(self, items):
        self.items = items

    def __copy__(self):
        return Box(self.items[:])   # [:] means "make a copy of the list"

b1 = Box([1, 2, 3])
b2 = copy.copy(b1)
print(b2.items)   # [1, 2, 3]
```

---

## 100. `__deepcopy__` — Deep Copy

### 🎨 The story
A "deep" copy duplicates **everything** — the outer box AND everything inside, recursively. Nothing is shared with the original.

### 🔍 When to use it
When you have nested data (lists of lists, dicts of objects) and need a fully independent duplicate.

### 💻 How to use it

```python
import copy

class Box:
    def __init__(self, items):
        self.items = items

    def __deepcopy__(self, memo):
        return Box(copy.deepcopy(self.items, memo))

b1 = Box([[1, 2], [3, 4]])
b2 = copy.deepcopy(b1)
b2.items[0].append(99)
print(b1.items)   # [[1, 2], [3, 4]]  — original unaffected
print(b2.items)   # [[1, 2, 99], [3, 4]]
```

### 🧒 In Plain English
The `memo` argument is Python's way of tracking which objects have already been copied (to handle circular references). You just pass it along — you rarely need to think about it.

---

## 101. `__getstate__` — What to Save

## 102. `__setstate__` — How to Restore

### 🎨 The story
When Python saves your object with `pickle`, `__getstate__` decides **what** to save. `__setstate__` decides **how to rebuild** the object from that saved data. Together, they're like a snapshot-and-restore pair.

### 🔍 When to use them
When your object has data you **don't want saved** (temporary caches, open network connections, passwords).

### 💻 How to use them

```python
import pickle

class Config:
    def __init__(self):
        self.settings = {"theme": "dark"}
        self.temp_cache = "do not save"

    def __getstate__(self):
        # Return a copy without the cache
        state = self.__dict__.copy()
        del state["temp_cache"]
        return state

    def __setstate__(self, state):
        self.__dict__.update(state)
        self.temp_cache = None   # restore to default

c = Config()
data = pickle.dumps(c)         # save
loaded = pickle.loads(data)    # load
print(loaded.settings)     # {'theme': 'dark'}
print(loaded.temp_cache)   # None
```

---

## 103. `__reduce__` — Custom Pickling

## 104. `__reduce_ex__` — Version-Aware Custom Pickling

### 🎨 The story
The advanced version of `__getstate__`/`__setstate__`. Gives you full control over exactly how pickle recreates your object.

### 🔍 When to use them
Very rarely. Only when the default pickling behavior can't handle your object (like objects with unusual construction).

---

# 🗂️ PART S: Path-Like Objects

---

## 105. `__fspath__` — File System Path Protocol

### 🎨 The story
Python has many functions that expect a file path (like `open()`, `os.listdir()`). If you build a custom class to represent a path, `__fspath__` lets it work with ALL of those functions automatically — no conversion needed.

### 🔍 When to use it
When you build a custom path class (like `pathlib.Path` does).

### 💻 How to use it

```python
import os

class MyPath:
    def __init__(self, path):
        self.path = path

    def __fspath__(self):
        return self.path

p = MyPath("/tmp/file.txt")
print(os.fspath(p))   # /tmp/file.txt

# Now MyPath works with any function expecting a path:
# open(p)  →  works!
# os.listdir(MyPath("/tmp"))  →  works!
```

### 🧒 In Plain English
Without `__fspath__`, you'd have to write `open(p.path)`. With it, you can just write `open(p)` and Python figures it out. Same idea as when your object learns to speak Python's native language.

---

# 🎁 PART T: The Grand Finale — A Complete Example

Let us build a `Vector` class that shows off many of these methods working together.

```python
from functools import total_ordering

@total_ordering
class Vector:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    # Description
    def __repr__(self):
        return f"Vector({self.x}, {self.y})"

    # Arithmetic
    def __add__(self, other):
        return Vector(self.x + other.x, self.y + other.y)

    def __sub__(self, other):
        return Vector(self.x - other.x, self.y - other.y)

    def __mul__(self, scalar):
        return Vector(self.x * scalar, self.y * scalar)

    def __rmul__(self, scalar):
        return self.__mul__(scalar)

    # Unary
    def __neg__(self):
        return Vector(-self.x, -self.y)

    def __abs__(self):
        return (self.x ** 2 + self.y ** 2) ** 0.5

    # Comparison
    def __eq__(self, other):
        return self.x == other.x and self.y == other.y

    def __lt__(self, other):
        return abs(self) < abs(other)

    # Hashing (for sets)
    def __hash__(self):
        return hash((self.x, self.y))

    # Truthiness
    def __bool__(self):
        return self.x != 0 or self.y != 0

    # Container behavior
    def __len__(self):
        return 2

    def __getitem__(self, index):
        return (self.x, self.y)[index]

    # Iteration
    def __iter__(self):
        yield self.x
        yield self.y

    # Callable
    def __call__(self):
        return (self.x, self.y)


# Try it out!
a = Vector(3, 4)
b = Vector(1, 2)

print(a + b)         # Vector(4, 6)
print(a - b)         # Vector(2, 2)
print(2 * a)         # Vector(6, 8)  — uses __rmul__
print(-a)            # Vector(-3, -4)
print(abs(a))        # 5.0
print(a == b)        # False
print(a > b)         # True — uses __lt__ under the hood
print(len(a))        # 2
print(a[0], a[1])    # 3 4
print(list(a))       # [3, 4]
print(bool(Vector(0, 0)))   # False
print(a())           # (3, 4)
```

That single class is easy to read *because* every operator does exactly what a reader would expect.

---

# 📦 PART U: Package & Module Dunders

*Everything you have learned so far lives inside classes. But Python has another whole family of dunders that live at the **module** and **package** level — the code files and folders themselves.*

### 🎨 The big story

Think of a Python **module** as a book, and a Python **package** as a library of books.

- A **module** is a single `.py` file (like `math.py` or `my_script.py`).
- A **package** is a folder that contains modules, marked as a package by having a special file called `__init__.py` inside it.

The dunders in this section are like the **metadata printed on and inside a book** — the title, the author, the copyright page, the table of contents, the edition number. They tell Python (and other people who use your code) important things about the module or package.

Let's meet each one.

---

## 106. `__name__` — Who Am I?

### 🎨 The story
When you introduce yourself, you say your name. `__name__` is your module's name. But here is the magical twist: when you **run a file directly**, its `__name__` becomes the special string `"__main__"`. When the **same file is imported** by another file, `__name__` becomes the module's actual name.

This is how Python knows whether your file is being used as a **script** (run directly) or as a **library** (imported by other code).

### 🔍 When to use it
In almost every Python script. It is the standard way to write code that runs only when the file is executed directly — the famous `if __name__ == "__main__":` block.

### 💻 How to use it

```python
# File: greetings.py

def say_hello():
    print("Hello, world!")

def say_goodbye():
    print("Goodbye!")

# This block runs ONLY when you run this file directly.
# It does NOT run when someone imports this file.
if __name__ == "__main__":
    say_hello()
    say_goodbye()
```

Now:
- Running `python greetings.py` directly → prints both messages.
- Doing `import greetings` from another file → nothing is printed, but the functions are available.

### ⚠️ Why this matters
This pattern lets you write files that work as both a runnable script and a reusable library. It is one of the most important patterns in Python.

---

## 107. `__doc__` — The Module's Description

### 🎨 The story
The blurb on the back of a book. When you write a docstring at the very top of a file or package, it becomes `__doc__`.

### 🔍 When to use it
Every module and package deserves a docstring. It helps users (and future you) understand what the code is for.

### 💻 How to use it

```python
# File: auth.py
"""This module handles user authentication and password checking."""

def login(username, password):
    pass

print(__doc__)
# Output: This module handles user authentication and password checking.
```

The docstring is also what `help(auth)` shows.

---

## 108. `__file__` — Where Do I Live?

### 🎨 The story
The address of the module — where it physically lives on your computer's disk.

### 🔍 When to use it
When you need to find the location of the current module — often to load data files stored alongside your code.

### 💻 How to use it

```python
# File: my_module.py
import os

print(__file__)
# Output: /home/user/projects/my_module.py

# Get the folder the module lives in:
folder = os.path.dirname(__file__)
data_file = os.path.join(folder, "data.txt")
print(data_file)
# Output: /home/user/projects/data.txt
```

---

## 109. `__dict__` — The Module's Contents

### 🎨 The story
The table of contents of a book — a dictionary containing everything the module defines (functions, classes, variables).

### 💻 How to use it

```python
# File: things.py

APP_NAME = "MyApp"

def start():
    pass

class Config:
    pass

print(list(__dict__.keys()))
# Output: [..., 'APP_NAME', 'start', 'Config']
```

Useful for introspection tools, but you rarely touch it directly.

---

## 110. `__package__` — Which Family Do I Belong To?

### 🎨 The story
Your family surname. It tells you which package a module belongs to. For a top-level module, it is an empty string.

### 💻 How to use it

```python
# Inside myapp/utils/helpers.py
print(__package__)
# Output: myapp.utils
```

---

## 111. `__path__` — Package Search Paths

### 🎨 The story
This one exists **only for packages** (folders), not regular modules. It is a list of paths where Python looks for the package's submodules.

### 🔍 When to use it
Almost never directly. It is used by Python's import system. Advanced users occasionally modify it for plugin systems.

### 💻 How to use it

```python
# Inside a package's __init__.py
print(__path__)
# Output: ['/home/user/projects/myapp']
```

---

## 112. `__spec__` — The Import Blueprint

### 🎨 The story
A blueprint containing all the technical details about how the module was imported — its name, its loader, its location.

### 🔍 When to use it
Rarely. It is used internally by Python's import system and by tools that inspect modules.

### 💻 How to use it

```python
# In any module
print(__spec__)
# Output: ModuleSpec(name='mymodule', loader=..., origin='/path/to/mymodule.py')
```

---

## 113. `__loader__` — The Delivery Driver

### 🎨 The story
The object responsible for actually loading the module into memory. Like a delivery driver who brought the book to your library.

### 🔍 When to use it
Rarely. Used internally by Python's import machinery.

### 💻 How to use it

```python
print(__loader__)
# Output: <_frozen_importlib_external.SourceFileLoader object at 0x...>
```

---

## 114. `__builtins__` — The Always-Available Toolkit

### 🎨 The story
The toolbox that is always in the room — `print`, `len`, `str`, `int`, and all the built-in functions you can use anywhere without importing.

### 🔍 When to use it
Rarely need to touch it directly. It is what makes built-in functions available in every module automatically.

### 💻 How to use it

```python
# print() works without any import — because __builtins__ is always there.
print(len(__builtins__.__dict__))
# Output: a large number (all built-in names)
```

### ⚠️ Warning
Do not modify `__builtins__` unless you truly know what you are doing — you could break every module in your program.

---

## 115. `__all__` — The Public API Sign

### 🎨 The story
Imagine a shop window with a sign saying **"These are our featured items."** When someone does `from mypackage import *`, only the names listed in `__all__` come along for the ride.

### 🔍 When to use it
- In `__init__.py` files, to define what your package publicly exposes.
- In modules, to control what gets imported with `import *`.
- To hide internal helper functions from users of your library.

### 💻 How to use it

```python
# File: mymodule.py

__all__ = ["public_function", "PublicClass"]

def public_function():
    print("You can use me!")

def _internal_helper():
    print("I'm private.")

class PublicClass:
    pass

class _InternalClass:
    pass
```

Now, from another file:

```python
from mymodule import *

public_function()   # Works
PublicClass()       # Works
# _internal_helper()   # NameError — not imported by *
# _InternalClass()     # NameError — not imported by *
```

### ⚠️ Note
`__all__` only affects `import *`. Users can still do `from mymodule import _internal_helper` explicitly if they really want to. `__all__` is a **convention**, not a lock.

---

## 116. `__version__` — The Edition Number

### 🎨 The story
The edition number on a book. This is a **convention** (not enforced by Python) that packages use to declare their version.

### 🔍 When to use it
In every package you publish. Users and tools like `pip` and `importlib.metadata` check this.

### 💻 How to use it

```python
# Inside your package's __init__.py

__version__ = "1.2.3"
```

From another file:

```python
import mypackage
print(mypackage.__version__)   # 1.2.3
```

### ⚠️ Convention
Use **semantic versioning**: `MAJOR.MINOR.PATCH` (e.g. `2.0.1`).

---

## 117. `__author__`, `__email__`, `__license__` — The Credits Page

### 🎨 The story
The credits page in a book — who wrote it, how to contact them, and what license it uses.

### 🔍 When to use them
Purely conventional metadata. Nice to include in libraries you share publicly.

### 💻 How to use them

```python
# Inside your package's __init__.py

__version__ = "1.0.0"
__author__ = "Jane Developer"
__email__ = "jane@example.com"
__license__ = "MIT"
```

### ⚠️ Modern practice
For serious packages published to PyPI, most of this metadata now belongs in `pyproject.toml` rather than in dunders. But the dunders still work fine and remain common.

---

## 118. `__init__.py` — The File That Makes a Folder a Package

### 🎨 The story
This is not a method — it is a **file**. Its presence in a folder tells Python, *"Treat this folder as a package."* Think of it as the **cover page** that binds the loose chapters into a proper book.

### 🔍 When to use it
Any time you build a package. Even an empty `__init__.py` is enough to make a folder a package.

### 💻 How to use it

Suppose your folder structure looks like this:

```
mypackage/
    __init__.py
    users.py
    orders.py
```

Inside `__init__.py`, you can:
- Leave it empty (the folder becomes a package, that's it).
- Expose things at the top level so users write shorter imports.
- Set package-level dunders like `__version__` and `__all__`.

```python
# mypackage/__init__.py
"""My awesome package for handling stuff."""

__version__ = "1.0.0"
__author__ = "You"
__all__ = ["User", "Order"]

from .users import User
from .orders import Order
```

Now users can write clean imports:

```python
from mypackage import User, Order
# Instead of:  from mypackage.users import User
```

### ⚠️ Modern Python note
Since Python 3.3, folders **without** `__init__.py` can also work as **namespace packages**. But for most projects, using `__init__.py` is still clearer and more common.

---

## 119. `__main__.py` — Making a Package Runnable

### 🎨 The story
If `__init__.py` is what makes a folder a package, `__main__.py` is what makes a package **runnable** with `python -m mypackage`. Think of it as adding a "Play" button to the package.

### 🔍 When to use it
When you want users to be able to run your package like a program:

```
python -m mypackage
```

Popular examples: `python -m http.server`, `python -m venv`, `python -m pip`.

### 💻 How to use it

```
mypackage/
    __init__.py
    __main__.py
    core.py
```

```python
# mypackage/__main__.py

from .core import run

if __name__ == "__main__":
    run()
```

Now running `python -m mypackage` executes the `run()` function.

---

## 120. `__pycache__` — Python's Cache Folder (Bonus)

### 🎨 The story
Not a dunder method, but you will see this folder appear next to your code. It is where Python stores **compiled bytecode** to make future imports faster — like a library keeping pre-highlighted copies of frequently-read books.

### 🔍 What to do about it
- Do not check it into version control (add `__pycache__/` to `.gitignore`).
- Do not edit files inside it manually.
- Safe to delete — Python will recreate it as needed.

---

## 🎯 Package & Module Dunders — Quick Summary

| Dunder | Purpose | Where it lives |
|--------|---------|----------------|
| `__name__` | Module's name (or `"__main__"` if run directly) | Every module |
| `__doc__` | Module docstring | Every module |
| `__file__` | Path to the file on disk | Every module |
| `__dict__` | Module's namespace | Every module |
| `__package__` | Parent package name | Every module |
| `__path__` | Search paths for submodules | Packages only |
| `__spec__` | Import specification | Every module |
| `__loader__` | The loader used to import | Every module |
| `__builtins__` | Reference to built-in names | Every module |
| `__all__` | Public API for `import *` | Convention |
| `__version__` | Package version | Convention |
| `__author__` | Author name | Convention |
| `__email__` | Author email | Convention |
| `__license__` | License name | Convention |
| `__init__.py` | Marks a folder as a package | File |
| `__main__.py` | Makes a package runnable | File |

---

# 🔍 PART V: Introspection Attributes

*Every object in Python carries hidden information tags — like the barcode, batch number, and country-of-origin label on a product. These dunder **attributes** (not methods) let you inspect what an object really is.*

### 🎨 The big story
Imagine every object walking around with a **backpack of ID cards**. One card says which class it belongs to. Another lists its type hints. Another says which module it came from. Introspection attributes are those ID cards — Python fills them in automatically, and you can read them whenever you're curious.

---

## 121. `__class__` — What Kind of Thing Am I? 🟢

### 🎨 The story
Every object knows its own species. Ask a dog "what are you?" and it answers "Dog." That's `__class__`.

### 🔍 When to use it
- To check an object's class at runtime.
- To dynamically create another object of the same type.
- For debugging.

### 💻 How to use it

```python
class Dog:
    def __init__(self, name):
        self.name = name

buddy = Dog("Buddy")

print(buddy.__class__)          # <class '__main__.Dog'>
print(buddy.__class__.__name__) # Dog

# Create another object of the same class dynamically
another = buddy.__class__("Max")
print(another.name)             # Max
```

### ⚠️ Tip
`type(buddy)` and `buddy.__class__` usually return the same thing. Use `isinstance(buddy, Dog)` for regular class checks — it is safer because it respects inheritance.

---

## 122. `__dict__` — The Object's Storage Room 🟢

### 🎨 The story
The drawer where an object keeps all its personal belongings (its attributes). Every object has one, unless it uses `__slots__`.

### 🔍 When to use it
- To see all attributes of an object at once.
- To dynamically add or inspect attributes.
- For serialization and debugging.

### 💻 How to use it

```python
class User:
    def __init__(self, name, age):
        self.name = name
        self.age = age

alice = User("Alice", 30)
print(alice.__dict__)   # {'name': 'Alice', 'age': 30}

# You can even add attributes through it
alice.__dict__["email"] = "alice@example.com"
print(alice.email)      # alice@example.com
```

---

## 123. `__annotations__` — The Type-Hint Notebook 🟡

### 🎨 The story
A restaurant menu with dietary labels: *"gluten-free, vegan, contains nuts."* `__annotations__` stores the type hints your code declares — the labels attached to variables and function parameters.

### 🔍 When to use it
- To inspect type hints at runtime.
- To build validation frameworks (like Pydantic and FastAPI).
- To auto-generate documentation.

### 💻 How to use it

```python
class Employee:
    name: str
    age: int
    salary: float

print(Employee.__annotations__)
# {'name': <class 'str'>, 'age': <class 'int'>, 'salary': <class 'float'>}

def greet(name: str, times: int = 1) -> str:
    return f"Hello {name}! " * times

print(greet.__annotations__)
# {'name': <class 'str'>, 'times': <class 'int'>, 'return': <class 'str'>}
```

---

## 124. `__qualname__` — My Full Address 🟡

### 🎨 The story
`__name__` gives you your first name. `__qualname__` gives you your **full address** — including the class or function you live inside.

### 🔍 When to use it
- For clearer error messages and logging in nested classes/functions.
- When debugging complex code with many nested definitions.

### 💻 How to use it

```python
class Outer:
    class Inner:
        def method(self):
            pass

print(Outer.Inner.__name__)      # Inner
print(Outer.Inner.__qualname__)  # Outer.Inner

print(Outer.Inner.method.__name__)      # method
print(Outer.Inner.method.__qualname__)  # Outer.Inner.method
```

---

## 125. `__module__` — Which Neighborhood Do I Live In? 🟡

### 🎨 The story
Your home address's city. `__module__` tells you which module a class or function was defined in.

### 🔍 When to use it
- For debugging: identifying where a class actually came from.
- For building plugin systems and serialization.

### 💻 How to use it

```python
# File: shop/products.py
class Product:
    pass

# In another file:
from shop.products import Product
print(Product.__module__)   # shop.products
```

---

## 126. `__bases__` — Who Are My Parents? 🟡

### 🎨 The story
A family tree showing your direct parents. `__bases__` lists a class's immediate parent classes.

### 🔍 When to use it
- For understanding inheritance relationships.
- For building framework tools that need to walk class hierarchies.

### 💻 How to use it

```python
class Animal:
    pass

class Mammal(Animal):
    pass

class Dog(Mammal):
    pass

print(Dog.__bases__)     # (<class '__main__.Mammal'>,)
print(Mammal.__bases__)  # (<class '__main__.Animal'>,)
```

---

## 127. `__mro__` — Method Resolution Order 🟡

### 🎨 The story
The **order in which Python searches for methods** when your class inherits from multiple classes. Think of it as the priority list: *"If you don't find it in Dog, check Mammal, then Animal, then object."*

### 🔍 When to use it
- To understand and debug multiple inheritance.
- To predict which parent method will be called.

### 💻 How to use it

```python
class Animal:
    def speak(self):
        return "Some sound"

class Mammal(Animal):
    pass

class Dog(Mammal):
    def speak(self):
        return "Woof!"

print(Dog.__mro__)
# (<class 'Dog'>, <class 'Mammal'>, <class 'Animal'>, <class 'object'>)

# Python looks up 'speak' in this order — Dog wins first.
```

---

## 128. `__subclasses__()` — Who Are My Children? 🔴

### 🎨 The story
A parent asking, "Who are all my kids and grandkids?" `__subclasses__()` returns a class's *direct* subclasses.

### 🔍 When to use it
- For building plugin/registration systems where subclasses auto-register.
- For frameworks that need to discover all types of a category.

### 💻 How to use it

```python
class Shape:
    pass

class Circle(Shape):
    pass

class Square(Shape):
    pass

print(Shape.__subclasses__())
# [<class '__main__.Circle'>, <class '__main__.Square'>]
```

### ⚠️ Note
Unlike most dunders, this is a **method** — you call it with parentheses: `Shape.__subclasses__()`.

---

## 129. `__weakref__` — Support for Weak References 🔴

### 🎨 The story
A **sticky note** rather than a permanent tag. A weak reference points to an object without preventing it from being cleaned up by Python's memory manager.

### 🔍 When to use it
- Building caches that don't leak memory.
- Building observer patterns that don't keep dead objects alive.

### 💻 How to use it

```python
import weakref

class Data:
    pass

d = Data()
ref = weakref.ref(d)   # Create a weak reference

print(ref())   # <__main__.Data object at ...>

del d          # The original is gone
print(ref())   # None — the weak reference "knows" it's dead
```

### ⚠️ Note
`__weakref__` is a slot that Python creates automatically on most classes. You rarely touch it directly — you just use the `weakref` module.

---

# 🧰 PART W: Function & Method Attributes

*Functions are objects too — and they carry their own set of dunder attributes. Most Python users never need to touch these directly, but knowing they exist unlocks decorator writing, debugging, and metaprogramming.*

### 🎨 The big story
Every function in Python is like a **backpack** — you can open it up and see the code inside, the default arguments it carries, its captured variables. These dunders let you unzip and inspect that backpack.

---

## 130. `__code__` — The Function's Recipe 🔴

### 🎨 The story
The written recipe inside a cookbook. `__code__` is the compiled instructions of a function — the low-level details of what parameters it takes, what file it's from, and so on.

### 🔍 When to use it
- For advanced debugging.
- When building code-analysis tools.

### 💻 How to use it

```python
def add(a, b):
    return a + b

print(add.__code__.co_varnames)   # ('a', 'b')
print(add.__code__.co_argcount)   # 2
print(add.__code__.co_filename)   # <path to file>
```

### 🧒 In Plain English
- `co_varnames` = names of variables the function uses
- `co_argcount` = how many arguments the function takes
- `co_filename` = which file the function was defined in

Rarely useful in day-to-day work. Mostly for tools like linters and profilers.

---

## 131. `__globals__` — The Function's Neighborhood 🔴

### 🎨 The story
The list of things a function knows about from its module — its neighbors.

### 💻 How to use it

```python
APP_NAME = "MyApp"

def show():
    print(APP_NAME)

print("APP_NAME" in show.__globals__)   # True
```

---

## 132. `__defaults__` — The Default Suitcase 🟡

### 🎨 The story
What the function packs when you don't tell it otherwise. The default values of positional arguments.

### 🔍 When to use it
- For introspecting or dynamically modifying default arguments (advanced).

### 💻 How to use it

```python
def greet(name, greeting="Hello", times=1):
    return f"{greeting}, {name}! " * times

print(greet.__defaults__)   # ('Hello', 1)
```

---

## 133. `__kwdefaults__` — Keyword-Only Defaults 🔴

### 🎨 The story
Some function parameters must be called by name (like `port=8080`), not by position. Their default values live in `__kwdefaults__`.

### 💻 How to use it

```python
def config(*, host="localhost", port=8080):
    return f"{host}:{port}"

print(config.__kwdefaults__)   # {'host': 'localhost', 'port': 8080}
```

### 🧒 In Plain English
The `*` in `def config(*, host=..., port=...)` means: *"After this point, every parameter MUST be passed by name."* So `config("localhost", 80)` would fail — you have to write `config(host="localhost", port=80)`. Their defaults land in `__kwdefaults__` (instead of the regular `__defaults__`).

---

## 134. `__closure__` — Captured Variables 🔴

### 🎨 The story
When a function is defined inside another function, it can "remember" variables from the outer function even after the outer function has finished. `__closure__` is where those remembered values live.

### 💻 How to use it

```python
def make_multiplier(factor):
    def multiply(x):
        return x * factor    # 'factor' comes from outside — it's captured
    return multiply

double = make_multiplier(2)
print(double(5))                  # 10
print(double.__closure__[0].cell_contents)   # 2 — the captured factor
```

### 🧒 In Plain English
When we call `make_multiplier(2)`, it creates a `multiply` function that "remembers" `factor = 2` — even after `make_multiplier` has returned. That remembered `2` is stored in `__closure__`. `cell_contents` is just Python's word for "the value stored inside this closure slot."

This is how you build **function factories** — functions that make other functions with different settings baked in.

---

## 135. `__wrapped__` — The Decorator's Original 🟡

### 🎨 The story
A gift-wrapped box with a receipt showing what's inside. When you use `functools.wraps` in a decorator, `__wrapped__` points to the original, unwrapped function.

### 🔍 When to use it
When you want to access the original function beneath a decorator.

### 💻 How to use it

```python
import functools

def loud(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        result = func(*args, **kwargs)
        return str(result).upper()
    return wrapper

@loud
def greet(name):
    return f"hello {name}"

print(greet("alice"))              # HELLO ALICE
print(greet.__wrapped__("alice"))  # hello alice — the original!
```

---

## 136. `__signature__` — Custom Signature Info 🔴

### 🎨 The story
`inspect.signature(func)` normally tells you what parameters a function takes. `__signature__` lets you **manually override** that — useful when your callable is a wrapper and you want tools to see the underlying parameters.

### 🔍 When to use it
When building wrappers or fake callables where the auto-detected signature would be misleading.

### 💻 How to use it

```python
import inspect

class Adder:
    """A fake callable that pretends to take (x, y)."""

    __signature__ = inspect.Signature(
        parameters=[
            inspect.Parameter("x", inspect.Parameter.POSITIONAL_OR_KEYWORD),
            inspect.Parameter("y", inspect.Parameter.POSITIONAL_OR_KEYWORD),
        ]
    )

    def __call__(self, *args, **kwargs):
        return sum(args) + sum(kwargs.values())

adder = Adder()
print(inspect.signature(adder))   # (x, y)
print(adder(3, 4))                # 7
```

### 🧒 In Plain English
`Adder.__call__` actually accepts anything (`*args, **kwargs`), but we lie to Python's inspector and say *"I take exactly two parameters, `x` and `y`."* Now IDE hints and `help()` show the friendly signature instead of the ugly real one. Advanced trick, rarely needed.

---

## 137. `__self__` — A Bound Method's Owner 🟡

### 🎨 The story
When you grab a method off an object (like `alice.greet`), the method remembers *who it belongs to*. `__self__` is that owner.

### 💻 How to use it

```python
class User:
    def __init__(self, name):
        self.name = name

    def greet(self):
        return f"Hi, I'm {self.name}"

alice = User("Alice")
bound_method = alice.greet
print(bound_method.__self__)   # <__main__.User object ...>
print(bound_method.__self__.name)   # Alice
```

---

## 138. `__func__` — The Underlying Function 🔴

### 🎨 The story
The unwrapped function inside a bound method — the one without the "owner" attached.

### 💻 How to use it

```python
class User:
    def greet(self):
        return "Hello"

alice = User()
bound_method = alice.greet
print(bound_method.__func__)   # <function User.greet at 0x...>
```

---

# 🚀 PART X: Modern Python Dunders (3.10+)

*Python keeps evolving. These dunders come from recent Python versions and unlock modern features like pattern matching, dataclass hooks, and generic type parameters.*

---

## 139. `__match_args__` — Pattern Matching Support 🟡

### 🎨 The story
Python 3.10 introduced **structural pattern matching** — a super-powered version of `if/elif` that lets you match complex data shapes. `__match_args__` tells the matcher **which attributes to unpack** when someone matches your class.

### 🔍 When to use it
- Whenever you build a class that users will match against in a `match` statement.
- Automatically set for you by `@dataclass`.

### 💻 How to use it

```python
class Point:
    __match_args__ = ("x", "y")

    def __init__(self, x, y):
        self.x = x
        self.y = y

def describe(p):
    match p:
        case Point(0, 0):
            return "Origin"
        case Point(x, 0):
            return f"On the X-axis at {x}"
        case Point(0, y):
            return f"On the Y-axis at {y}"
        case Point(x, y):
            return f"Point at ({x}, {y})"

print(describe(Point(0, 0)))   # Origin
print(describe(Point(3, 0)))   # On the X-axis at 3
print(describe(Point(2, 5)))   # Point at (2, 5)
```

### 🧒 In Plain English
The `match`/`case` statement is like a smart `if/elif`, but it can peek inside objects and match on their contents. `__match_args__ = ("x", "y")` tells Python: *"When someone writes `Point(a, b)` in a case, treat the first slot as `x` and the second as `y`."* Then Python can automatically unpack the point and match its shape.

---

## 140. `__post_init__` — After-Setup Hook (Dataclasses) 🟢

### 🎨 The story
After a dataclass automatically fills in your `__init__`, `__post_init__` runs to let you do extra setup — like a final quality-check step on an assembly line.

### 🔍 When to use it
- To validate fields after dataclass initialization.
- To compute derived fields.
- Any time you use `@dataclass` and need custom initialization logic.

### 💻 How to use it

```python
from dataclasses import dataclass

@dataclass
class Rectangle:
    width: float
    height: float

    def __post_init__(self):
        # Runs after width and height are set
        if self.width <= 0 or self.height <= 0:
            raise ValueError("Dimensions must be positive")
        self.area = self.width * self.height

r = Rectangle(3, 4)
print(r.area)   # 12

# Rectangle(-1, 4)   # Would raise ValueError!
```

### ⚠️ Note
This is specific to `@dataclass`. Regular classes just use `__init__`.

---

## 141. `__type_params__` — Generic Type Parameters (Python 3.12+) 🔴

### 🎨 The story
Python 3.12 added a cleaner syntax for generic types: `class Stack[T]:`. The `T` is a **placeholder** for whatever type will be stored — like a labeled empty box. `__type_params__` stores those placeholders.

### 💻 How to use it

```python
# Python 3.12+ syntax
class Stack[T]:
    def __init__(self):
        self.items: list[T] = []

    def push(self, item: T):
        self.items.append(item)

print(Stack.__type_params__)   # (T,)
```

### 🧒 In Plain English
`Stack[int]` means "a Stack that holds `int` values." `Stack[str]` means "a Stack of strings." The `T` inside the class definition is just a placeholder that gets swapped out when you use it. Only useful for type-hint-heavy code with static type checkers like `mypy`.

---

## 142. `__buffer__` and 143. `__release_buffer__` — Buffer Protocol (Python 3.12+) 🔴

### 🎨 The story
Imagine two machines sharing the **same storage room** instead of each keeping their own copy. That's what the buffer protocol does — it lets objects share raw memory efficiently, without copying. This is how NumPy arrays can hand raw data to image libraries or C code without duplication.

### 🔍 When to use it
Almost never in application code. Only when building low-level libraries that need direct memory access (like NumPy, Pillow, or PyTorch internals).

### 💻 How to use it

```python
# Python 3.12+
class MyBuffer:
    def __init__(self, data: bytes):
        self._data = bytearray(data)

    def __buffer__(self, flags):
        # Hand out a view of our internal storage
        return memoryview(self._data)

    def __release_buffer__(self, view):
        # Called when the borrower is done with the memory
        pass

buf = MyBuffer(b"Hello")
view = memoryview(buf)
print(bytes(view))   # b'Hello'
```

### 🧒 In Plain English
`memoryview` is Python's way of looking at bytes without copying them. `__buffer__` says "here's a window into my data — you can read from it directly." `__release_buffer__` says "thanks, I'm done borrowing." Zero-copy sharing means huge performance gains for scientific computing.

---

## 144. `__getnewargs__` — Pickling Support 🔴

### 🎨 The story
When you save an object with `pickle`, `__getnewargs__` tells pickle **what arguments to pass to `__new__`** when reconstructing the object.

### 🔍 When to use it
For objects whose creation requires specific arguments (like immutable types built with `__new__`).

### 💻 How to use it

```python
import pickle

class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __getnewargs__(self):
        return (self.x, self.y)

    def __repr__(self):
        return f"Point({self.x}, {self.y})"

p1 = Point(3, 4)
saved = pickle.dumps(p1)
p2 = pickle.loads(saved)
print(p2)   # Point(3, 4) — perfectly restored
```

---

## 145. `__getnewargs_ex__` — Pickling with Keywords 🔴

### 🎨 The story
Same as `__getnewargs__`, but also supports keyword arguments.

### 💻 How to use it

```python
class Config:
    def __init__(self, host, *, port=8080):
        self.host = host
        self.port = port

    def __getnewargs_ex__(self):
        # (positional args tuple, keyword args dict)
        return ((self.host,), {"port": self.port})
```

---

## 🎯 Introspection & Modern Dunders — Quick Summary

| Dunder | Purpose | Difficulty |
|--------|---------|:----------:|
| `__class__` | Object's class | 🟢 |
| `__dict__` | Attribute storage | 🟢 |
| `__annotations__` | Type hints | 🟡 |
| `__qualname__` | Full qualified name | 🟡 |
| `__module__` | Defining module | 🟡 |
| `__bases__` | Parent classes | 🟡 |
| `__mro__` | Method resolution order | 🟡 |
| `__subclasses__()` | Direct subclasses | 🔴 |
| `__weakref__` | Weak reference support | 🔴 |
| `__code__` | Function's bytecode | 🔴 |
| `__globals__` | Function's global scope | 🔴 |
| `__defaults__` | Default positional args | 🟡 |
| `__kwdefaults__` | Default keyword args | 🔴 |
| `__closure__` | Captured variables | 🔴 |
| `__wrapped__` | Original of a decorated function | 🟡 |
| `__signature__` | Custom callable signature | 🔴 |
| `__self__` | Bound method's owner | 🟡 |
| `__func__` | Underlying function of a bound method | 🔴 |
| `__match_args__` | Pattern matching (3.10+) | 🟡 |
| `__post_init__` | Dataclass after-init hook | 🟢 |
| `__type_params__` | Generic type params (3.12+) | 🔴 |
| `__buffer__` | Buffer protocol (3.12+) | 🔴 |
| `__release_buffer__` | Buffer release (3.12+) | 🔴 |
| `__getnewargs__` | Pickle args | 🔴 |
| `__getnewargs_ex__` | Pickle args with kwargs | 🔴 |

---

# 📋 The Complete Cheat Sheet

## Object lifecycle
`__new__`, `__init__`, `__del__`, `__init_subclass__`, `__set_name__`

## String representation
`__str__`, `__repr__`, `__format__`, `__bytes__`

## Comparison
`__eq__`, `__ne__`, `__lt__`, `__le__`, `__gt__`, `__ge__`, `__hash__`

## Arithmetic
`__add__`, `__sub__`, `__mul__`, `__truediv__`, `__floordiv__`, `__mod__`, `__divmod__`, `__pow__`, `__matmul__`

## Reflected arithmetic
`__radd__`, `__rsub__`, `__rmul__`, `__rtruediv__`, `__rfloordiv__`, `__rmod__`, `__rpow__`, `__rmatmul__`

## In-place arithmetic
`__iadd__`, `__isub__`, `__imul__`, `__itruediv__`, `__ifloordiv__`, `__imod__`, `__ipow__`, `__imatmul__`

## Unary
`__neg__`, `__pos__`, `__abs__`, `__invert__`, `__round__`, `__trunc__`, `__floor__`, `__ceil__`

## Bitwise
`__and__`, `__or__`, `__xor__`, `__lshift__`, `__rshift__` (plus `r` and `i` versions)

## Type conversion
`__bool__`, `__int__`, `__float__`, `__complex__`, `__index__`

## Container behavior
`__len__`, `__length_hint__`, `__getitem__`, `__setitem__`, `__delitem__`, `__missing__`, `__contains__`

## Iteration
`__iter__`, `__next__`, `__reversed__`

## Callable
`__call__`

## Context managers
`__enter__`, `__exit__`, `__aenter__`, `__aexit__`

## Attribute access
`__getattr__`, `__getattribute__`, `__setattr__`, `__delattr__`, `__dir__`, `__slots__`

## Descriptors
`__get__`, `__set__`, `__delete__`

## Class magic
`__instancecheck__`, `__subclasscheck__`, `__subclasshook__`, `__class_getitem__`, `__mro_entries__`, `__prepare__`

## Async
`__await__`, `__aiter__`, `__anext__`, `__aenter__`, `__aexit__`

## Copying and pickling
`__copy__`, `__deepcopy__`, `__getstate__`, `__setstate__`, `__reduce__`, `__reduce_ex__`

## Path
`__fspath__`

## Module & package (module-level)
`__name__`, `__doc__`, `__file__`, `__dict__`, `__package__`, `__path__`, `__spec__`, `__loader__`, `__builtins__`

## Module & package (conventions)
`__all__`, `__version__`, `__author__`, `__email__`, `__license__`

## Package files
`__init__.py`, `__main__.py`

## Introspection attributes
`__class__`, `__dict__`, `__annotations__`, `__qualname__`, `__module__`, `__bases__`, `__mro__`, `__subclasses__()`, `__weakref__`

## Function & method attributes
`__code__`, `__globals__`, `__defaults__`, `__kwdefaults__`, `__closure__`, `__wrapped__`, `__signature__`, `__self__`, `__func__`

## Modern Python (3.10+)
`__match_args__`, `__post_init__`, `__type_params__`, `__buffer__`, `__release_buffer__`, `__getnewargs__`, `__getnewargs_ex__`

---

# ⭐ The Golden Best Practices

1. **Always define `__repr__`.** It is the single most helpful thing for debugging. If your class has one dunder beyond `__init__`, make it this.

2. **Keep `__eq__` and `__hash__` consistent.** If two objects are equal, they must hash the same. Break this rule and sets and dictionaries misbehave in mysterious ways.

3. **Do not overuse dunders.** Just because you *can* overload `+` to launch a rocket does not mean you should. Operators should feel intuitive to any reader.

4. **Prefer returning new objects in arithmetic methods.** `a + b` should not secretly modify `a`. This matches how numbers behave.

5. **Use shortcuts.** `functools.total_ordering` for comparisons. Generators with `yield` instead of writing `__iter__`/`__next__` by hand.

6. **Avoid infinite loops in `__setattr__` and `__getattribute__`.** Always delegate to `super()` to actually store or retrieve values.

7. **Use context managers (`with`) instead of `__del__` for cleanup.** Guaranteed to run, easier to reason about.

8. **Do not chase every dunder method.** Add them one at a time, as you genuinely need them.

9. **Aim for objects that feel Pythonic.** When `len()`, `in`, `for`, `+`, and `if` all *just work* on your object, you have arrived.

10. **When in doubt, keep it simple.** A well-designed `__init__` and `__repr__` beat a class stuffed with clever dunder tricks.

---

# 🎉 Final Words

You now hold the complete map of Python's most powerful hidden feature. Every dunder method Python offers is on these pages, explained the same simple way.

You do not need to memorize them all. Just remember the pattern:

> **Python has hidden buttons. You get to decide what each one does.**

That is the entire secret. With this bible in hand, you can build classes that feel like natural extensions of the language itself — the mark of a true Python master.

Come back to this guide whenever you need it. Bookmark the sections you use most. And when you find yourself thinking, *"I wish my object could do X"*, there is almost certainly a dunder method that makes it possible.

*Welcome to Python mastery.* 🐍✨

---

<div align="center">

**The Complete Bible of Python Dunder Methods**
*by Gehan Fernando*

*Read it once. Use it forever. Break things on purpose.*

</div>
