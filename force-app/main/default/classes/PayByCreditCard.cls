public without sharing class PayByCreditCard implements PayStrategy {

    public Boolean pay(Bill__c bill) {
        List<CreditCard__c> creditCards = [SELECT Id, Amount__c FROM CreditCard__c WHERE Account__c =: bill.Account__c];
        for(CreditCard__c card: creditCards){
            if(bill.BillAmount__c < card.Amount__c ){
                card.Amount__c = card.Amount__c - bill.BillAmount__c;
                update card;
                return true;
            }
        }
        return false;
    }
}