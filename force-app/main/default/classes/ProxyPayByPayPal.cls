public with sharing class ProxyPayByPayPal implements PayStrategy{

    public Boolean pay(Bill__c bill) {
        PayStrategy ps = new PayByPayPal();
        Boolean teml = ps.pay(bill);
        if(teml){
            bill.Status__c = 'PaidByPayPal';
        }
        return teml;
    }
}