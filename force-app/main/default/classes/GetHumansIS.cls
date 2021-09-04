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
        HumanosResponse humanos = new HumanosResponse();
        for(Criatura__c cri : criaturasToReturn){
            Humano hum = new Humano(cri.name, cri.idade__c, cri.bunker__r.name);
                hum.nome 	= cri.Name;
                humanos.add(hum);
        }

        return humanos;
    }

    global class HumanosResponse{
        public List<Humano> humanos;
        public Integer total;

        public HumanosResponse() {
        	this.humanos = new List<Humano>();
            this.total = 0;
        }

        public HumanosResponse add(Humano humano) {
            humanos.add(humano);
            this.total++;
            return this;
        }
    }

    global class Humano{
        public String nome;
        public Decimal idade;
        public Bunker bunker;

        public Humano(String nome, Decimal idade, String bunkerName) {
            this.nome = nome;
            this.idade = idade;
            this.bunker = new Bunker(bunkerName);
        }
    }

    global class Bunker{
        public String nome;

        public Bunker(String nome) {
            this.nome = nome;
        }
    }
}