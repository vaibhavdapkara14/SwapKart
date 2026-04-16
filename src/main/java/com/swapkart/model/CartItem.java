package com.swapkart.model;

public class CartItem {
    private int cartId;
    private Product product;

    public int getCartId() { return cartId; }
    public void setCartId(int cartId) { this.cartId = cartId; }
    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }
}