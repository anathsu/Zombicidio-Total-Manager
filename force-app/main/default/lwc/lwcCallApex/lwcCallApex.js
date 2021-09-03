import { LightningElement, wire, api} from 'lwc';

import getHerois from '@salesforce/apex/CalloutToSalesforce.getHeroisBootcamp3';

export default class LwcCallApex extends LightningElement {

    @api herois = [];

    /*
        Wire = Mais prático porem menos flexivel
    */

    // @wire(getHerois)
    // wiredRecord({error, data}){
    //     if(data){
    //         console.log(data);
    //         this.herois = data.herois;
    //     }else if(error){
    //         console.log(error);
    //     }
    // }

    /*
        Then/Catch = Mais flexivel porem um pouco mais trabalhoso
    */
   connectedCallback(){
    //    alert('Entrou no ConnectedCallback');

       getHerois()
       .then( result =>{
           this.herois = result.herois;
           console.log(result.herois);
       })
       .catch( error =>{
            console.log(error);
       })
   }

}