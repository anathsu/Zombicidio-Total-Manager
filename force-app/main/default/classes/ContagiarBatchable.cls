public with sharing class ContagiarBatchable implements Database.Batchable<sObject> {

    //Captura os IDs do Schema.
    private String humanId = Schema.SObjectType.Criatura__c.getRecordTypeInfosByName().get('Humano').getRecordTypeId();
    private String zombieId = Schema.SObjectType.Criatura__c.getRecordTypeInfosByName().get('Zumbi').getRecordTypeId();

    static final integer zombiSpread = 2;

    public ContagiarBatchable() {}

    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([SELECT id, Criatura__c.RecordTypeId, Bunker__r.DefesaBunker__c, Bunker__c, (SELECT id, AcrescimoDefesa__c  FROM RecursosCriatura__r) FROM Criatura__c]);
    }
  
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        System.debug('Entrou no Execute');

        List<Criatura__c> criList = (List<Criatura__c>) scope;
        Map<id, Criatura__c> criUpdateList = new Map<id, Criatura__c>();
        List<Criatura__c> humList = preencheListaCriaturaRecordtype(humanId, criList);
        List<Criatura__c> zumList = preencheListaCriaturaRecordtype(zombieId, criList);

        for(Criatura__c zum : zumList){
            for(integer i=0; i < zombiSpread; i++){
                Criatura__c cri = (Criatura__c) Util.GetRandomItem(humList);
                Decimal defesa = this.getDefense(cri);
                Integer DiceRoll = Math.mod(Integer.valueof(Math.random()*100000),100)+1;
                if(DiceRoll > defesa){
                    cri.recordtypeId  = zombieId;
                    cri.Data_de_Zumbificacao__c = Date.today();
                    criUpdateList.put(cri.id, cri);
                }
            }
        }
        update criUpdateList.values();
    }      

    private Decimal getDefense(Criatura__c hmn){
        Decimal defesa = 0;
        if(hmn.recordtypeId  != zombieId)
            {
                if(hmn.bunker__c != null)
                {
                    defesa += hmn.bunker__r.defesaBunker__c;
                }
                if(hmn.RecursosCriatura__r != null)
                {
                    for(recursoCriatura__c recCri : hmn.RecursosCriatura__r)
                    {
                        defesa += recCri.acrescimoDefesa__c;
                    }
                }
            }
        return defesa;
    }

    private List<Criatura__c> preencheListaCriaturaRecordtype(id recordType, List<Criatura__c> listaP){
        List<Criatura__c> cri = new List<Criatura__c>();
        for(Criatura__c crip : ListaP){
            if(crip.recordTypeId == recordType) cri.add(crip);
        }
        return cri;
    }
  
    public void finish(Database.BatchableContext BC){
    }

}