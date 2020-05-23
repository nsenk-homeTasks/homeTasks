trigger PublisherMessagesTrigger on PublisherMessages__c ( after insert, after update, after delete) {
    new PublisherMessagesHandler().run();
}
