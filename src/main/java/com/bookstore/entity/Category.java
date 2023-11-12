package com.bookstore.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Collection;

@Entity
@NamedQueries({
        @NamedQuery(name="Category.findAll",
                query="SELECT c FROM Category c ORDER BY c.categoryId ASC "),
        @NamedQuery(name="Category.findByName",
                query="SELECT c FROM Category c WHERE c.name = :name"),
        @NamedQuery(name="Category.countAll",
                query="SELECT COUNT(c) FROM Category c "),
})
public class Category {
    private int categoryId;
    private String name;
    private Collection<Book> booksByCategoryId;

    public Category() {
    }

    public Category(String name) {
        this.name = name;
    }

    public Category(int categoryId, String name) {
        this.categoryId = categoryId;
        this.name = name;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "category_id", nullable = false)
    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    @Basic
    @Column(name = "name", nullable = false, length = 45)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Category category = (Category) o;

        if (categoryId != category.categoryId) return false;
        if (name != null ? !name.equals(category.name) : category.name != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = categoryId;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        return result;
    }

    @OneToMany(mappedBy = "categoryByCategoryId", fetch = FetchType.LAZY)
    public Collection<Book> getBooksByCategoryId() {
        return booksByCategoryId;
    }

    public void setBooksByCategoryId(Collection<Book> booksByCategoryId) {
        this.booksByCategoryId = booksByCategoryId;
    }
}
