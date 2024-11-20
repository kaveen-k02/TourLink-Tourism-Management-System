import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class PaymentService {
  private baseURL = "http://localhost:8081/payment";
  private save = "save";

  constructor(private httpClient: HttpClient) { }

  savePaymentLog(userId: string, selectedItems: any[]): Observable<Object> {
    console.log(selectedItems);
    return this.httpClient.post(`${this.baseURL}/save/${userId}`, selectedItems);
  }

  
}
