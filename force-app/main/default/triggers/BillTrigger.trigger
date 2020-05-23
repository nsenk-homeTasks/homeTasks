trigger BillTrigger on Bill__c (before insert, before update) {
	new BillTriggerHandler().run();
}