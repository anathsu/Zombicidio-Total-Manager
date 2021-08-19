global class ContagionSchedulable implements Schedulable
{
	
	global void execute(SchedulableContext SC) 
    {   
        this.contagiar();
    }
    
    
    private void contagiar(){
        List<Criatura__c> humanList = [SELECT id, Bunker__r.DefesaBunker__c, Bunker__c, (SELECT id, AcrescimoDefesa__c  FROM RecursosCriatura__r) FROM Criatura__c  WHERE RecordTypeId = '0125e000000qYuoAAE'];
        List<Criatura__c> zombieList = [SELECT id FROM Criatura__c where RecordTypeId = '0125e000000qYv8AAE'];
        
        for(Criatura__c zb : zombieList){
            if(humanList.size() == 0) break;
            Criatura__c hmn1 = humanList.get(Math.mod(Integer.valueof(Math.random()*1000),humanList.size()));
            Decimal defesa = 0;
            if(hmn1.RecordTypeId  != '0125e000000qYv8AAE')
            {
                if(hmn1.bunker__c != null)
                {
                    defesa += hmn1.bunker__r.defesaBunker__c;
                }
                if(hmn1.RecursosCriatura__r != null)
                {
                    for(recursoCriatura__c recCri : hmn1.RecursosCriatura__r)
                    {
                        defesa += recCri.acrescimoDefesa__c;
                    }
                }
            }
            Integer DiceRoll = Math.mod(Integer.valueof(Math.random()*100000),100)+1;
            if(DiceRoll > defesa)
            {
                hmn1.RecordTypeId  = '0125e000000qYv8AAE';
                hmn1.Data_de_Zumbificacao__c = Date.today();
            }
            defesa = 0;
            Criatura__c hmn2 = humanList.get(Math.mod(Integer.valueof(Math.random()*1000),humanList.size()));
            if(hmn2.RecordTypeId  != '0125e000000qYv8AAE')
            {
                if(hmn2.bunker__c != null)
                {
                    defesa += hmn2.bunker__r.defesaBunker__c;
                }
                if(hmn2.RecursosCriatura__r != null)
                {
                    for(recursoCriatura__c recCri : hmn2.RecursosCriatura__r)
                    {
                        defesa += recCri.acrescimoDefesa__c;
                    }
                }
            }
            Integer DiceRoll2 = Math.mod(Integer.valueof(Math.random()*100000),100)+1;
            if(DiceRoll2 > defesa)
            {
                hmn2.RecordTypeId  = '0125e000000qYv8AAE';
                hmn2.Data_de_Zumbificacao__c = Date.today();
            }
        }
        update humanList;
    }

}