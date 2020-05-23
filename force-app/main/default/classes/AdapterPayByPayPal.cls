public with sharing class AdapterPayByPayPal implements AdapterPayStrategy{

    public Boolean fastPay(Bill__c bill) {
        PayStrategy payByPayPal = new ProxyPayByPayPal();
        return payByPayPal.pay(bill);
    }
}