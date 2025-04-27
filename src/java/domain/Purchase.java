/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

/**
 *
 * @author Hong Jie
 */

import java.util.Date;

public class Purchase {
    private int purchaseId;
    private String productName;
    private double amount;
    private Date purchaseDate;

    public Purchase() {}

    public Purchase(int purchaseId, String productName, double amount, Date purchaseDate) {
        this.purchaseId = purchaseId;
        this.productName = productName;
        this.amount = amount;
        this.purchaseDate = purchaseDate;
    }

    // Getter and Setter
    public int getPurchaseId() {
        return purchaseId;
    }
    public void setPurchaseId(int purchaseId) {
        this.purchaseId = purchaseId;
    }

    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getAmount() {
        return amount;
    }
    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Date getPurchaseDate() {
        return purchaseDate;
    }
    public void setPurchaseDate(Date purchaseDate) {
        this.purchaseDate = purchaseDate;
    }
}
