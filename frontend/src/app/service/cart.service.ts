import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { AuthService } from 'app/service/auth.service'; // Assuming AuthService is in 'app/service/auth.service'

@Injectable({
  providedIn: 'root'
})
export class CartService {
  private baseURL = "http://localhost:8081/cart";
  private view = "view";
  private deleteItem = "deleteItem";

  constructor(private httpClient: HttpClient, private authService: AuthService) { }

  addToCart(id: string, userId: string, extraString: string): Observable<Object> {
    const start = this.authService.getStartDate();
    const end = this.authService.getEndDate();
    
    const requestBody = {
      userId: userId,
      extraParam: extraString,
      startDate: start,
      endDate: end
    };
    console.log(requestBody);
    console.log(id);
    return this.httpClient.post(`${this.baseURL}/${id}`, requestBody);
  }

  addToCartList(userId: string): Observable<Object> {
    return this.httpClient.get(`${this.baseURL}/${this.view}/${userId}`);
  }

  delete(id: string): Observable<Object> {
    const requestBody = {
      id: id,
    };
    console.log(requestBody);
    const userId = this.authService.getUserAccountId();
    return this.httpClient.post(`${this.baseURL}/${this.deleteItem}/${userId}`, requestBody);
  }
}
