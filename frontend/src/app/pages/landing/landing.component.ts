import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { DriverGuideRatingDto } from 'app/dto/driver-guide-rating-dto';
import { HotelUserRatingDTO } from 'app/dto/hotel-user-rating-dto';
import { Hotel } from 'app/model/hotel';
import { User } from 'app/model/user';
import { DriverGuideRatingService } from 'app/service/driver-guide-rating.service';
import { HotelUserRatingDTOService } from 'app/service/hotel-user-rating-dto.service';
import { HotelService } from 'app/service/hotel.service';
import { UserService } from 'app/service/user.service';
import { AuthService } from 'app/service/auth.service';
import { ConfirmationDialog } from '../confirmation-dialog/confirmation-dialog.component';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatDialog } from '@angular/material/dialog';
// import * as Rellax from 'rellax';

@Component({
  selector: 'app-landing',
  templateUrl: 'landing.component.html',
  styleUrls: ['landing.component.scss', 'style.component.css']
})
export class LandingComponent implements OnInit {
  data : Date = new Date();
  focus;
  focus1;

  hotels: Hotel[];
  guides: User[];
  drivers: User[];
  reviews: DriverGuideRatingDto[];
  packUsers: User[];
  startDate: string;
  endDate: string;

  constructor(private hotelService: HotelService, private userService: UserService,
    private router: Router, private hotelUserService: HotelUserRatingDTOService, 
    private userRatingService: DriverGuideRatingService,
    private authService: AuthService,private snackBar: MatSnackBar,private dialog: MatDialog
  ) { }
  getUserRole() {
    return this.authService.getUserRole();
  }
  getUserId() {
    return this.authService.getUserId();
  }
  ngOnInit() {
    this.getHotels();
    this.getAllTourGuides();
    this.getAllDrivers();
    
  }

  onSubmit() {
    this.packageUsers();
    this.authService.setStartDate(this.startDate);
    this.authService.setEndDate(this.endDate);
  }

  packageUsers() {
    this.userService.getPackageUsers(this.authService.getStartDate(), this.authService.getEndDate()).subscribe(data => {
      this.packUsers = data;
      this.filterGuides();
      this.filterDriver();
    })
  }

  filterGuides() {
    this.guides = this.guides.filter(guide => !this.isUserInPackUsers(guide))
      .sort((a, b) => b.averageRating - a.averageRating).slice(0, 3);
  }

  filterDriver() {
    this.drivers = this.drivers.filter(driver => !this.isUserInPackUsers(driver))
      .sort((a, b) => b.averageRating - a.averageRating).slice(0, 3);
  }
  
  async getHotels() {
    try {
      const hotels = await this.hotelService.gelAllHotels().toPromise();
      for (const hotel of hotels) {
        const ratings = await this.hotelUserService.getAllHotelRatingById(hotel.id).toPromise();
        hotel.averageRating = this.calculateAverage(ratings);
      }
      this.hotels = hotels.sort((a, b) => b.averageRating - a.averageRating).slice(0, 3);
    } catch (error) {
      console.error('Error fetching hotels:', error);
    }
  }

  async getAllTourGuides() {
    try {
      const guides = await this.userService.getAllGuides().toPromise();
      for (const guide of guides) {
        guide.averageRating = await this.getAverageRatingForUser(guide.id);
      }
      
      this.guides = guides.sort((a, b) => b.averageRating - a.averageRating).slice(0, 3);
      this.packageUsers();
      
    } catch (error) {
      console.error('Error fetching tour guides:', error);
    }
  }

  async getAllDrivers() {
    try {
      const drivers = await this.userService.getAllDrivers().toPromise();
      for (const driver of drivers) {
        driver.averageRating = await this.getAverageRatingForUser(driver.id);
      }
      this.drivers = drivers.sort((a, b) => b.averageRating - a.averageRating).slice(0, 3);
      this.packageUsers();
    } catch (error) {
      console.error('Error fetching drivers:', error);
    }
  }

  isUserInPackUsers(user: User): boolean {
    if(user){
      return this.packUsers.some(packUser => packUser.id === user.id);
    }
  }

  async getAverageRatingForUser(userId: string): Promise<number> {
    try {
      const ratings = await this.userRatingService.getAllDriverGuideRatingById(userId).toPromise();
      return this.calculateAverage(ratings);
    } catch (error) {
      console.error('Error fetching ratings for user:', error);
      return 0;
    }
  }

  private calculateAverage(ratings: HotelUserRatingDTO[] | DriverGuideRatingDto[]) : number {
    let totalRating = 0;
    for (const rating of ratings) {
      totalRating += rating.rating;
    }
    return ratings.length > 0 ? totalRating / ratings.length : 0;
  }


  moreHotels() {
    this.router.navigate(['tourist-hotels'])
  }

  more(type: string){
    this.router.navigate(['tourist', type])
  }

  goToCart() {
    this.router.navigate(['/cart']); // Navigate to the 'cart' route
  }


  openDialog() {
    const dialogRef = this.dialog.open(ConfirmationDialog, {
      data: {
        message: 'Are you sure want to LogOut?',
        buttonText: {
          ok: 'Yes',
          cancel: 'No',
        },
      },
    });

    dialogRef.afterClosed().subscribe((confirmed: boolean) => {
      if (confirmed) {
        this.logout()
        this.snackBar.open('LogOut Successfully!', 'Fechar', {
          duration: 2000,
        });
      }
    });
  }

  logout() {
    this.router.navigate(['auth']);
    this.authService.setSessionUserId("");
    this.authService.setUserAccountId("");
    this.authService.setUserId("");
    this.authService.setUserRole("");
    this.authService.setStartDate("");
    this.authService.setEndDate("");
  }

  hotelPackages(id: string) {
    this.router.navigate(['tourist-hotel-packages', id])
  }

  dgPackage(id: string, type: string){
    this.router.navigate(['tourist-dg-packages', id,type]);
    console.log("click",type)
  }

  showPopup: boolean = false;
  idToSend: string;
  rateType: string;

  openPopup(id: string, ty: string) {
    this.idToSend = id;
    this.rateType = ty;
    this.showPopup = true;
  }

  navToFeedback() {
    this.router.navigate(['tourist-feedback'])
  }



}
