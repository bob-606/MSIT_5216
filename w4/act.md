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
# Recursive Algorithms for Hierarchical Data Management
**Introduction**

The management of hierarchical data structures is a fundamental challenge in software design, particularly in systems like digital libraries that require efficient organization and manipulation of nested categories. Modern libraries often contain thousands of books organized into multi-level taxonomies (e.g., "Fiction → Science Fiction → Cyberpunk"), necessitating robust algorithms for tasks such as inventory tracking, availability updates, and structural reorganization. Recursive algorithms provide an elegant solution to these challenges by mirroring the inherent hierarchical nature of library systems (Wang, 2023).

This solution leverages object-oriented programming (OOP) principles to model categories and books, combined with recursive traversal techniques for data manipulation. The implementation addresses three core requirements: (1) calculating total books in nested categories, (2) propagating availability updates across the hierarchy, and (3) dynamically restructuring category relationships. By integrating Python's native support for recursion with mutable object states, the system achieves both clarity and functionality (Krishnamurthi, 2017).

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
