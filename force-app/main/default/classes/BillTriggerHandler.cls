public with sharing class BillTriggerHandler extends TriggerHandler {

    public override void beforeInsert(){
        pay(Trigger.new);
    }

    public override void beforeUpdate(){
        pay(Trigger.new);
    }

    private void pay(List<Bill__c> records){
        for(Bill__c record : records){
            if(record.BillAmount__c != null
                    && record.PayType__c != null
                    && record.Status__c == 'Draft'){
                AdapterPayStrategy strategy;

                switch on record.PayType__c{
                    when 'PayPal'{
                        strategy = new AdapterPayByPayPal();
                    }
                    when 'CreditCard'{
                        strategy = new AdapterPayByCreditCard();
                    }
                }

                if(!strategy.fastPay(record)){
                    record.addError('You can not pay by ' + record.PayType__c);
                }
            }
        }
    }
}