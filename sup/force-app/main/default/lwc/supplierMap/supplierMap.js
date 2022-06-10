import { LightningElement, wire,api, track } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
const FIELD_Latitude ='Supplier__c.Location__Latitude__s';
const FIELD_Longitude ='Supplier__c.Location__Longitude__s';


const fields = [FIELD_Latitude, FIELD_Longitude]

export default class SupplierMap extends LightningElement {

    @api recordId;
    mapMarkers;


    @wire(getRecord,{recordId: '$recordId', fields})
    supplier({ error, data }) {
            
        if(error){
            console.log('error', JSON.parse(JSON.stringify(error)));

        } else if ( data ) {
            console.log( 'Supplier is gjjh' + JSON.stringify( data ) );
            let marker = [
                 {
                     location: {
                         Latitude: data.fields.Location__Latitude__s.value,
                         Longitude: data.fields.Location__Longitude__s.value,
                     },
                     title: 'Supplier',
                 },
            ];
            this.mapMarkers = marker;
        }
        console.log('coords are', this.mapMarkers);
    }



}