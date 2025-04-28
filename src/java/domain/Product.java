package domain;

/**
 * Represents a product in the system.
 * @author Hong Jie
 */
public class Product {
    private int productId;
    private String productName;
    private double price;
    private String category;
    private String description;
    private String imgUrl;  // Image URL field

    // No-arg constructor
    public Product() {}

    // All-args constructor
    public Product(int productId, String productName, double price, String category, String description, 
                   String imgUrl) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.category = category;
        this.description = description;
        this.imgUrl = imgUrl;
    }

    // Getters & setters

    public int getProductId() {
        return productId;
    }
    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }

    public String getCategory() {
        return category;
    }
    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public String getImgUrl() {
        return imgUrl;
    }
    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }
}
