public without sharing class PayByPayPal implements PayStrategy{

    public Boolean pay(Bill__c bill) {
        List<PayPal__c> payPals = [SELECT Id, Amount__c FROM PayPal__c WHERE Account__c =: bill.Account__c];
        for(PayPal__c payPal: payPals){
            if(bill.BillAmount__c < payPal.Amount__c ){
                payPal.Amount__c = payPal.Amount__c - bill.BillAmount__c;
                update payPal;
                return true;
            }
        }
        return false;
    }
}