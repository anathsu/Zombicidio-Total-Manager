public with sharing class ContagiarBatchable implements Database.Batchable<Criatura__c> {
    public ContagiarBatchable() {}

    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('[SELECT id, Criatura__c.RecordTypeId, Bunker__r.DefesaBunker__c, Bunker__c, (SELECT id, AcrescimoDefesa__c  FROM RecursosCriatura__r) FROM Criatura__c');
    }
  
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        List<Criatura__c> hum = preencheListaCriaturaRecordtype('0125e000000qYuoAAE');
        List<Criatura__c> zom = preencheListaCriaturaRecordtype('0125e000000qYv8AAE');
        
    }

    private List<Criatura__c> preencheListaCriaturaRecordtype(id RecordType, List<sObject> listaP){
        List<Criatura__c> cri = new List<Criatura__c>();
        for(Criatura__c crip : listaP){
            if(crip.RecordTypeId == RecordType) cri.add(crip);
        }
        return cri;
    }
  
    public void finish(Database.BatchableContext BC){
    }

}
