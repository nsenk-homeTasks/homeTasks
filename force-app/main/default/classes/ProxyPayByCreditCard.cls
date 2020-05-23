public with sharing class ProxyPayByCreditCard implements PayStrategy{

    public Boolean pay(Bill__c bill) {
        PayStrategy ps = new PayByCreditCard();
        Boolean teml = ps.pay(bill);
        if(teml){
            bill.Status__c = 'PaidByCreditCard';
        }
        return teml;
    }
}