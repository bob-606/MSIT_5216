# ***Developing recursive algorithms for data manipulation involving mutation and variables.***

## Assignment
Read the following scenario.

## Scenario
A digital library system is being developed using Python to organize books into a hierarchy of categories, subcategories, and individual books. The system must handle tasks such as calculating the total number of books in a category, updating book availability based on check-outs and returns, and restructuring categories and subcategories. 

## Based on the insights gained from this system, proceed with addressing the following tasks:  
Develop a code in Python that implements recursive algorithms for the following tasks: 
1. Count the total number of books within a specified category, including all its subcategories. 
2. Update the availability status of books, ensuring accurate reflection of check-outs and returns throughout the entire hierarchy. 
3. Relocate a category and all its subcategories to a new parent category, adjusting the hierarchy and updating all relevant references as needed.

## Submission Instructions 
Read the rubric on how your assignment will be graded.   
Your assignment should be a minimum of 750 words and not more than 1500 words (not including the reference list or the title page); double-spaced in Times New Roman font, which is no greater than 12 points in size.     
Support your arguments with sources and evidence. 
Use high-quality, credible, relevant sources to develop ideas appropriate for the discipline and genre of writing. Explore additional details on the INFORMATION LITERACY page (located on the right-hand side of this page).  
Please consider using references and in-text citations from textbooks and any other sources used in this assignment from our library. You can contact the librarian at library@uopeople.edu if you need help. You can also ask the expert in the Learning Resource Center. 


---

# **Digital Library System: Recursive Algorithms for Hierarchical Data Management**

**Introduction**

In software architecture, managing hierarchical data structures is a key difficulty, especially for systems like digital libraries that need to manipulate and organize nested categories efficiently.  Contemporary libraries frequently include thousands of books arranged in multi-level taxonomies (e.g., "Fiction → Science Fiction → Cyberpunk"), which calls for strong algorithms to perform tasks like updating availability, tracking inventories, and reorganizing structures.  Because recursive algorithms mimic the natural hierarchical structure of library systems, they offer a sophisticated solution to these problems (Wang, 2023).

This solution leverages object-oriented programming (OOP) principles to model categories and books, combined with recursive traversal techniques for data manipulation. The implementation addresses three core requirements: (1) calculating total books in nested categories, (2) propagating availability updates across the hierarchy, and (3) dynamically restructuring category relationships. By integrating Python's native support for recursion with mutable object states, the system achieves both clarity and functionality (Krishnamurthi, 2017).

**1. Data Model Design**

The system uses two classes to model the library hierarchy:

```python
class Book:
    def __init__(self, title, available=True):
        self.title = title
        self.available = available

class Category:
    def __init__(self, name, parent=None):
        self.name = name
        self.parent = parent
        self.subcategories = []
        self.books = []

    def add_subcategory(self, subcategory):
        subcategory.parent = self
        self.subcategories.append(subcategory)

    def add_book(self, book):
        self.books.append(book)
```

The `Book` class encapsulates individual book metadata, while the `Category` class represents hierarchical categories. This design mirrors real-world library taxonomies and facilitates efficient traversal and manipulation of the hierarchy (Gamma et al., 1994).

**2. Implementation of Core Functions**

**Task 1: Recursive Book Count**

```python
def count_books(category):
    total = len(category.books)
    for sub in category.subcategories:
        total += count_books(sub)
    return total
```

**Explanation:**
This function uses recursion to count the total number of books in a category and all its subcategories.

1. **Base Case:** The function starts by counting the books directly in the current category (`len(category.books)`). This serves as our base case for the recursion.

2. **Recursive Step:** It then iterates through each subcategory and recursively calls `count_books` on each one. This step traverses down the category tree.

3. **Accumulation:** The counts from subcategories are added to the total. This accumulates the book count from all levels of the hierarchy.

4. **Return:** The final total is returned, representing the sum of books in the current category and all its nested subcategories.

The recursive nature of this function allows it to handle arbitrarily deep category structures without needing to know the depth in advance. It elegantly solves the problem of counting in a hierarchical structure (Cormen et al., 2009).

**Task 2: Recursive Availability Updates**

```python
def update_availability(category, title, available):
    for book in category.books:
        if book.title == title:
            book.available = available
    for sub in category.subcategories:
        update_availability(sub, title, available)
```

**Explanation:**
This function recursively updates the availability status of a book across the entire category hierarchy.

1. **Local Update:** It first checks all books in the current category. If a book's title matches the given title, its availability is updated.

2. **Recursive Propagation:** The function then recursively calls itself on each subcategory. This ensures that the update is propagated through the entire hierarchy.

3. **No Return Value:** The function doesn't return anything; it performs in-place updates on the book objects.

This approach ensures that if multiple copies of a book exist in different categories, all instances are updated. It demonstrates how recursion can be used to perform operations that affect the entire tree structure (Krishnamurthi, 2017).

**Task 3: Recursive Category Relocation**

```python
def find_category(root, target_name):
    if root.name == target_name:
        return root
    for sub in root.subcategories:
        found = find_category(sub, target_name)
        if found:
            return found
    return None

def relocate_category(root, target_name, new_parent_name):
    target = find_category(root, target_name)
    new_parent = find_category(root, new_parent_name)
    
    if not target or not new_parent or target == new_parent:
        return False
    
    if target.parent:
        target.parent.subcategories.remove(target)
    
    new_parent.add_subcategory(target)
    return True
```

**Explanation:**
This task involves two functions working together to relocate a category within the hierarchy.

1. **find_category Function:**
   - This helper function recursively searches for a category by name.
   - If the current category matches the target name, it's returned.
   - Otherwise, it recursively searches in subcategories.
   - If not found, it returns None.

2. **relocate_category Function:**
   - It first finds both the target category and the new parent category using `find_category`.
   - It performs validity checks (e.g., ensuring both categories exist and aren't the same).
   - If valid, it removes the target from its current parent.
   - Finally, it adds the target as a subcategory of the new parent.

This implementation showcases how recursion can be used not just for traversal (in `find_category`) but also for modifying the structure of the hierarchy. It demonstrates the power of recursive algorithms in handling complex tree manipulations (Wang, 2023).

These recursive implementations provide elegant solutions to complex hierarchical data management problems, though they also come with considerations like stack depth limits for very deep structures, which is why we also explored iterative and parallel alternatives in the optimization section.


**3. Unit Testing**
Testing is crucial for ensuring the reliability and correctness of our recursive algorithms. We'll use Python's unittest framework to create a comprehensive test suite.

```python
import unittest

class TestLibrarySystem(unittest.TestCase):
    def setUp(self):
        self.root = Category("Library")
        self.fiction = Category("Fiction")
        self.root.add_subcategory(self.fiction)
        self.scifi = Category("Science Fiction")
        self.fiction.add_subcategory(self.scifi)
        self.scifi.add_book(Book("Dune"))
        self.scifi.add_book(Book("Neuromancer"))

    def test_count_books(self):
        self.assertEqual(count_books(self.root), 2)
        self.assertEqual(count_books(self.fiction), 2)
        self.assertEqual(count_books(self.scifi), 2)

    def test_update_availability(self):
        update_availability(self.root, "Dune", False)
        self.assertFalse(self.scifi.books[0].available)
        self.assertTrue(self.scifi.books[1].available)

    def test_relocate_category(self):
        relocate_category(self.root, "Science Fiction", "Library")
        self.assertIn(self.scifi, self.root.subcategories)
        self.assertNotIn(self.scifi, self.fiction.subcategories)

if __name__ == '__main__':
    unittest.main()
```

**4. Performance Analysis**
To better understand the efficiency of our recursive algorithms, we conduct a simple performance analysis:

```python
import time
import random

def generate_large_library(depth, breadth, books_per_category):
    root = Category("Root")
    categories = [root]
    for _ in range(depth):
        new_categories = []
        for category in categories:
            for _ in range(breadth):
                new_cat = Category(f"Category-{random.randint(1, 1000000)}")
                category.add_subcategory(new_cat)
                for _ in range(books_per_category):
                    new_cat.add_book(Book(f"Book-{random.randint(1, 1000000)}"))
                new_categories.append(new_cat)
        categories = new_categories
    return root

# Generate a large library
large_library = generate_large_library(depth=5, breadth=3, books_per_category=10)

# Measure performance
start_time = time.time()
total_books = count_books(large_library)
end_time = time.time()

print(f"Total books: {total_books}")
print(f"Time taken: {end_time - start_time:.4f} seconds")
```

**5. Extended Analysis and Optimization Strategies**

1. Memoization:
```python
from functools import lru_cache

@lru_cache(maxsize=None)
def count_books_memoized(category):
    total = len(category.books)
    for sub in category.subcategories:
        total += count_books_memoized(sub)
    return total
```

2. Iterative Approach:
```python
def count_books_iterative(root):
    total = 0
    stack = [root]
    while stack:
        category = stack.pop()
        total += len(category.books)
        stack.extend(category.subcategories)
    return total
```

3. Parallel Processing:
```python
from multiprocessing import Pool

def count_books_parallel(root):
    with Pool() as pool:
        results = pool.map(count_books, root.subcategories)
    return sum(results) + len(root.books)
```

**Conclusion**

This implementation demonstrates the effectiveness of recursive algorithms in managing hierarchical library systems. The solutions for book counting, availability updates, and category relocation showcase how recursion simplifies complex tree traversal tasks while maintaining code readability. However, as noted by Parker (2021), purely recursive approaches may face limitations in extremely deep hierarchies or high-throughput environments, necessitating hybrid iterative-recursive designs for production systems.

Our implementation, fortified with comprehensive unit tests and performance analysis, demonstrates the power and limitations of recursive algorithms in managing hierarchical data. The addition of memoization, iterative alternatives, and parallel processing options provides a toolkit for optimizing performance in various scenarios. As library systems continue to evolve, these strategies will be crucial in balancing the elegance of recursive solutions with the demands of large-scale, high-performance applications.

Future enhancements could integrate memoization to cache category sizes (Cormen et al., 2009) or adopt graph databases for persistent storage of hierarchical relationships (Robinson et al., 2015). Additionally, implementing thread-safe mutations would align with concurrent access patterns in multi-user library systems (Goetz, 2006). The use of type hints and property decorators, as suggested in Python's official documentation (Python Software Foundation, 2023), could further improve code maintainability.

Ultimately, this work highlights the enduring relevance of recursion in hierarchical data management while acknowledging the need for practical optimizations in real-world applications. By balancing algorithmic elegance with performance considerations, developers can create systems that scale effectively without sacrificing code clarity.

**References**

1. Cormen, T. H., et al. (2009). Introduction to Algorithms (3rd ed.). MIT Press.
2. Gamma, E., et al. (1994). Design Patterns: Elements of Reusable Object-Oriented Software. Addison-Wesley.
3. Goetz, B. (2006). Java Concurrency in Practice. Addison-Wesley.
4. Gorelick, M., & Ozsvald, I. (2020). High Performance Python: Practical Performant Programming for Humans. O'Reilly Media.
5. Krishnamurthi, S. (2017). Programming Languages: Application and Interpretation. Brown University.
6. Lutz, M. (2013). Learning Python (5th ed.). O'Reilly Media.
7. Parker, J. R. (2021). Python: An Introduction to Programming (2nd ed.). Mercury Learning & Information.
8. Python Software Foundation. (2023). Python 3.12 Documentation. https://docs.python.org/3/
9. Raschka, S., & Mirjalili, V. (2019). Python Machine Learning: Machine Learning and Deep Learning with Python, scikit-learn, and TensorFlow 2. Packt Publishing.
10. Robinson, I., et al. (2015). Graph Databases (2nd ed.). O'Reilly Media.
11. Wang, H. (2023). Introduction to Computer Programming with Python. Athabasca University Press.
