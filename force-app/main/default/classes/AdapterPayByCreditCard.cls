public with sharing class AdapterPayByCreditCard implements AdapterPayStrategy{

    public Boolean fastPay(Bill__c bill) {
        PayStrategy payByCreditCard = new ProxyPayByCreditCard();
        return payByCreditCard.pay(bill);
    }
}