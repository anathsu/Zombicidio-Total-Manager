public class CalloutToSalesforce {
    public static final String clientId = '3MVG9cHH2bfKACZbw4FIJzzLXnHIegCG.vdQKV4F68gKpiJKGcOksSLSyuePs1f95X5S2NfF6_T4Bn4bslk2z';
    public static final String clientSecret = '1C1F23E8F6C03CA16A4386E53A15D21CC76E5D0B59C163FBF3093A07FFBB1B5B';
    public static final String url = 'https://login.salesforce.com/services/oauth2/token';
    public static final String userName = 'integration@00d5e000002hhkveao.com';
    public static final String password = 'Bootcamp4';
    public static final String endpoint = '/services/apexrest/marvel/availableheroes';

    public static String accessToken = '';
    public static String instanceUrl = '';

    private static Boolean getAuth(){
        try {
            HttpRequest req = new HttpRequest();

            req.setHeader('Content-Type','application/x-www-form-urlencoded');
            req.setMethod('POST');
            req.SetEndpoint(url);
            req.setBody('grant_type=password'+
                        + '&client_id='+clientId
                        + '&client_secret='+clientSecret
                        + '&username='+userName
                        + '&password='+password);

            System.debug('>> Requisição: '+ req.getBody());

            Http http = new Http();
            HttpResponse response = http.send(req);
            System.debug('Response: '+ response.getBody());

            if(response.getStatusCode() == 200){
                Map<String, Object> resMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                accessToken = (String) resMap.get('access_token');
                instanceUrl = (String) resMap.get('instance_url');

                System.debug('>> accessToken: ' + accessToken);
                System.debug('>> accessToken: ' + accessToken);
            }else{
                System.debug('Erro de status code:: '+response.getStatus());
            }
        } catch (Exception e) {
            System.debug('Error: '+ e.getMessage());
            return false;
        }
        return true;
    }

    @AuraEnabled(cacheable = true)
    public static ResponseHerois getHeroisBootcamp3(){
        
        ResponseHerois herois = null;
        try {
            getAuth();
            if( !String.isBlank(accessToken)){
                HttpRequest req = new HttpRequest();

                req.setHeader('Authorization','Bearer '+ accessToken);
                req.setMethod('GET');
                req.SetEndpoint(instanceUrl+endpoint);

                Http http = new Http();
                HttpResponse res = http.send(req);
                System.debug('>>> Response:: '+res.getBody());

                if(res.getStatusCode() == 200){
                    herois = (ResponseHerois) JSON.deserialize(res.getBody(), ResponseHerois.class);
                    // System.debug('Herois: ' + herois);
                }else{
                    System.debug('>>> ERRO: ' + res.getStatus());
                }
            }
        } catch (Exception e) {
            System.debug('Error: '+ e.getMessage());
        }
        return herois;  
    }

    public class ResponseHerois{
        @AuraEnabled
        public List<Heroi> herois;
        @AuraEnabled
        public Integer total;

        public ResponseHerois() {
        	this.herois = new List<Heroi>();
            this.total = 0;
        }

        public ResponseHerois add(Heroi heroi) {
            herois.add(heroi);
            this.total++;
            return this;
        }
    }

    
    public class Heroi{
        @AuraEnabled
        public String nome;
        @AuraEnabled
        public String nivel;
        @AuraEnabled
        public List<Habilidade> habilidades;
        @AuraEnabled
        public Integer total;

        public Heroi(String nome, String nivel) {
            this.nome = nome;
            this.nivel = nivel;
            this.habilidades = new List<Habilidade>();
            this.total = 0;
        }

        public Heroi add(Habilidade habilidade) {
            this.habilidades.add(habilidade);
            this.total++;
            return this;
        }
    }


    public class Habilidade{
        @AuraEnabled
        public String nome;
        @AuraEnabled
        public String nivel;

        public Habilidade(String nome, String nivel) {
            this.nome = nome;
            this.nivel = nivel;
        }
    }
}