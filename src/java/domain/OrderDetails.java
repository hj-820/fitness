package DOMAIN;

import java.io.Serializable;
 
public class OrderDetails implements Serializable {

    private String name;
    private String phone;
    private String address;
    private String paymentMethod;
    private double subtotal;
    private double deliveryFee;
    private double grandTotal;

    public OrderDetails(String name, String phone, String address, String paymentMethod, double subtotal, double deliveryFee, double grandTotal) {
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.paymentMethod = paymentMethod;
        this.subtotal = subtotal;
        this.deliveryFee = deliveryFee;
        this.grandTotal = grandTotal;
    }

    public String getName() {
        return name;
    }

    public String getPhone() {
        return phone;
    }

    public String getAddress() {
        return address;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public double getDeliveryFee() {
        return deliveryFee;
    }

    public double getGrandTotal() {
        return grandTotal;
    }
}




