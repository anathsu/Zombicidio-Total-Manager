@RestResource(urlMapping='/zombicidio/humanos/*')
global class GetHumansIS {
    
    @HttpGet
    global static HumanosResponse doGet(){
        List<Criatura__c> criaturasToReturn = new List<Criatura__c>();
        String recursoParam = RestContext.request.params.get('recurso');
        String bunkerName = RestContext.request.params.get('bunker');
        String dynamicQuery = 'SELECT id, Name, Idade__c, Bunker__r.name FROM Criatura__c WHERE recordtype.Name= \'Humano\'';

        if( !String.isBlank(bunkerName)){
            List<String> bunkers = bunkerName.split(',');
            dynamicQuery += ' and Bunker__r.Name IN :bunkers ';
        }

        
        criaturasToReturn = Database.query(dynamicQuery);
        List<Humano> humanos = new List<Humano>();
        for(Criatura__c criaturas : criaturasToReturn){
            Bunker bunker = new Bunker();
                bunker.nome = criaturas.Bunker__r.Name;

            Humano hum = new Humano();
                hum.nome 	= criaturas.Name;
                hum.idade 	= String.valueOf( criaturas.Idade__c );
                hum.bunker  = bunker;

            humanos.add(hum);
        }

        HumanosResponse humanosResponse = new HumanosResponse();
        	humanosResponse.humanos = humanos;
        	humanosResponse.total 	= humanos.size();

        return humanosResponse;
    }

    global class HumanosResponse{
        public List<Humano> humanos;
        public Integer total;
    }

    global class Humano{
        public String nome;
        public String idade;
        public Bunker bunker;
    }

    global class Bunker{
        public String nome;
    }
}