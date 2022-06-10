import { LightningElement,wire,api } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import getSuppliersRecords from '@salesforce/apex/SupplierController.getSuppliersRecords'
import CITY_FIELD from '@salesforce/schema/Account.BillingCity';
import NAME_FIELD from '@salesforce/schema/Account.Name';

const fields = ['Account.BillingCity', 'Account.Name'];

export default class SuppliersListView extends LightningElement {
    @api recordId;
    records;
    cityName='';
    error;

    @wire(getRecord, { recordId: '$recordId', fields: fields })
    account({error, data}){
        console.log('loadFields, recordId: ', this.recordId);
        if(error){
            console.log('error', JSON.parse(JSON.stringify(error)));
        }else if(data){
            this.cityName = data.fields.BillingCity.value;
        }
    }

    //cityName = getFieldValue(data, CITY_FIELD);

    

    @wire(getSuppliersRecords , {city: '$cityName'})
    suppliers({error, data}){
        
        if (data){
            console.log(data);
            let rows = JSON.parse(JSON.stringify( data ));
            //console.log('Rows are ' + JSON.stringify( rows ));

            for (let i = 0; i< rows.length; i++){
                let row = rows[i];
                row.SupplierName = row.Name;
                row.SupplierURL = "/" + row.Id; 
                rows[i] = row;
            }
            this.records = rows;
            this.error = undefined;
        } else if (error){
            this.error = error;
            console.log('fuck !' + this.error);
            this.records = undefined;
        }
    }
}