import { Component, OnInit, ElementRef, ViewChild } from '@angular/core';
import { AuthService } from 'app/service/auth.service';
import { CartService } from 'app/service/cart.service';
import { PaymentService } from 'app/service/payment.service';
import { Router } from '@angular/router';
import { ConfirmationDialog } from '../confirmation-dialog/confirmation-dialog.component';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatDialog } from '@angular/material/dialog';

// Define CartData interface
interface CartData {
  hotel: any[];
  guide: any[];
  driver: any[];
  message: string;
}

@Component({
  selector: 'cart-cmp',
  moduleId: module.id,
  templateUrl: 'cart.component.html'
})
export class CartComponent implements OnInit {
  @ViewChild('paymentRef', { static: true }) paymentRef!: ElementRef;

  data: CartData = { hotel: [], guide: [], driver: [], message: '' };
  selectedHotels: any[] = [];
  selectedGuides: any[] = [];
  selectedDrivers: any[] = [];

  totalPrice: number = 0;
  paymentSuccess: boolean = false;

  selectedItems: any[] = [];
 removeSelected: any[] = [];

  constructor(private router: Router, private authService: AuthService, private cartService: CartService,
    private paymentService: PaymentService, private snackBar: MatSnackBar,private dialog: MatDialog
  ) {}

  ngOnInit(): void {
    window.paypal
      .Buttons({
        createOrder: (data: any, actions: any) => {
          console.log(this.totalPrice);
          return actions.order.create({
            purchase_units: [
              {
                amount: {
                  value: this.totalPrice.toString(),
                  currency_code: 'USD'
                }
              }
            ]
          });
        },
        onApprove: (data: any, actions: any) => {
          const userId = this.authService.getUserAccountId();
          this.selectedItems = [
            ...this.selectedHotels.map(item => ({ packageid: item.packageid  })),
            ...this.selectedGuides.map(item => ({ packageid: item.packageid  })),
            ...this.selectedDrivers.map(item => ({ packageid: item.packageid }))
          ];
    
           this.paymentService.savePaymentLog(userId,this.selectedItems)
                  .subscribe((data: CartData) => { 
                    this.data = data;
                  });
         

          return actions.order.capture().then((details: any) => {
            this.paymentSuccess = true;
            this.refreshCart();
            console.log(details);
          });
        },
        onError: (error: any) => {
          console.log(error);
        }
      })
      .render(this.paymentRef.nativeElement);

    const userId = this.authService.getUserAccountId();
    this.cartService.addToCartList(userId).subscribe((data: CartData) => {
      this.data = data;
      console.log(this.data.hotel);
      console.log(this.data.guide);
      console.log(this.data.driver);
      console.log(this.data.message);
    });
  }

  onHotelSelect(event: any, hotel: any) {
    if (event.target.checked) {
      this.selectedHotels.push({ packageid: hotel.packageid, price: hotel.price ,userPackageid: hotel.id});
    } else {
      const index = this.selectedHotels.findIndex(item => item.packageid === hotel.packageid);
      if (index !== -1) {
        this.selectedHotels.splice(index, 1);
        this.totalPrice -= hotel.price;
      }
    }
    this.calculateTotalPrice();
  }

  onGuideSelect(event: any, guide: any) {
    if (event.target.checked) {
      this.selectedGuides.push({ packageid: guide.packageid, price: guide.price ,userPackageid: guide.id});
    } else {
      const index = this.selectedGuides.findIndex(item => item.packageid === guide.packageid);
      if (index !== -1) {
        this.selectedGuides.splice(index, 1);
        this.totalPrice -= guide.price;
      }
    }
    this.calculateTotalPrice();
  }

  onDriverSelect(event: any, driver: any) {
    if (event.target.checked) {
      this.selectedDrivers.push({ packageid: driver.packageid, price: driver.price ,userPackageid: driver.id});
    } else {
      const index = this.selectedDrivers.findIndex(item => item.packageid === driver.packageid);
      if (index !== -1) {
        this.selectedDrivers.splice(index, 1);
        this.totalPrice -= driver.price;
      }
    }
    this.calculateTotalPrice();
  }

  calculateTotalPrice() {
    this.totalPrice = 0;
    this.selectedHotels.forEach(item => {
      this.totalPrice += item.price;
    });
    this.selectedGuides.forEach(item => {
      this.totalPrice += item.price;
    });
    this.selectedDrivers.forEach(item => {
      this.totalPrice += item.price;
    });
  }

  goToPayment() {
    this.router.navigate(['/payment']);
  }

  
  refreshCart() {
    console.log("in");
    const userId = this.authService.getUserAccountId();
    this.totalPrice = 0;
    this.cartService.addToCartList(userId).subscribe((data: CartData) => {
      this.data = data;
    });
    
  }

  go() {
    
  }

  openDialog(id: string) {
    const dialogRef = this.dialog.open(ConfirmationDialog, {
      data: {
        message: 'Are you sure want to delete?',
        buttonText: {
          ok: 'Yes',
          cancel: 'No',
        },
      },
    });

    dialogRef.afterClosed().subscribe((confirmed: boolean) => {
      if (confirmed) {
        this.Delete(id)
         this.snackBar.open('Package deleted!', 'Fechar', {
          duration: 2000,
        });
      }
    });
  }

  Delete(id: string){
    this.cartService.delete(id).subscribe((data: CartData) => {
      this.refreshCart();
    });
   
  }
  

  



}
