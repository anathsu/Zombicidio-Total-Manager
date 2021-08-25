trigger CriaturaTrigger on Criatura__c (after insert, after update, after delete) {

    //Identifica os bunkers
    Map<id,Bunker__c> bunkerUpdateMap = new Map<id,Bunker__c>();
    
    for(Criatura__c cr : trigger.new) {
        Criatura__c nova = cr;
        Criatura__c antiga = trigger.oldMap.get(nova.id);
        if(nova.Bunker__c != antiga.Bunker__c) {
            if(nova.Bunker__c != null){
                bunkerUpdateMap.put(nova.Bunker__c, new Bunker__c(id = nova.Bunker__c));
            }
            if(antiga.Bunker__c != null){
                bunkerUpdateMap.put(antiga.Bunker__c, new Bunker__c(id = antiga.Bunker__c));
            }
        }
    }
    for(Criatura__c cr : trigger.old) {
        if(trigger.isDelete && cr.Bunker__c != null){
            bunkerUpdateMap.put(cr.Bunker__c, new Bunker__c(id = cr.Bunker__c));
        }
    }

    system.debug(bunkerUpdateMap);
    
    List<Bunker__c> bkList = [SELECT id, (SELECT id FROM Criaturas__r) FROM Bunker__c WHERE id in : bunkerUpdateMap.keySet()];
    for(Bunker__c bk : bkList){
        bunkerUpdateMap.get(bk.id).Populacao__c = bk.Criaturas__r.size();
    }
    
    update bunkerUpdateMap.values();
}