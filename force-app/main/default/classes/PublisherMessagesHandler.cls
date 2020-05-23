public with sharing class PublisherMessagesHandler extends TriggerHandler {
    public override void afterInsert() {
        createSubscriberMessage(Trigger.new);
    }

    public override void afterUpdate() {

    }

    public override void afterDelete() {

    }


    private void createSubscriberMessage(List<PublisherMessages__c> records) {
        List<String> publisherIds = new List<String>();
        for (PublisherMessages__c record : records) {
            publisherIds.add(record.Publisher__c);
        }

        List<SubscriberToPublisher__c> subToPub = [
                SELECT id,
                        Publisher__c,
                        Subscriber__c
                FROM SubscriberToPublisher__c
                WHERE Publisher__c IN :publisherIds
        ];

        //create map all subscriber where key Publisher Id
        Map<String, List<String>> subscriberByPublisher = new Map<String, List<String>>();
        for (SubscriberToPublisher__c record : subToPub) {
            if (subscriberByPublisher.containsKey(record.Publisher__c)) {
                subscriberByPublisher.get(record.Publisher__c).add(record.Subscriber__c);
            } else {
                List<String> subscriberIds = new List<String>();
                subscriberIds.add(record.Subscriber__c);
                subscriberByPublisher.put(record.Publisher__c, subscriberIds);
            }
        }


        List<SubscriberMessage__c> subscriberMessages = new List<SubscriberMessage__c>();
        for (PublisherMessages__c record : records) {
            for (Id subscriberId : subscriberByPublisher.get(record.Publisher__c)) {
                subscriberMessages.add(
                        new SubscriberMessage__c(
                                PublisherMessages__c = record.Id,
                                Subscriber__c = subscriberId));
            }
        }

        insert subscriberMessages;
    }
}