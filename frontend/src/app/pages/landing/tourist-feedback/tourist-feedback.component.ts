import { Component, OnInit } from "@angular/core";
import { MatDialog } from "@angular/material/dialog";
import { MatSnackBar } from "@angular/material/snack-bar";
import { DriverGuideRatingDto } from "app/dto/driver-guide-rating-dto";
import { ConfirmationDialog } from "app/pages/confirmation-dialog/confirmation-dialog.component";
import { AuthService } from "app/service/auth.service";
import { DriverGuideRatingService } from "app/service/driver-guide-rating.service";


@Component({
    selector: 'tourist-feedback-cmp',
    templateUrl: 'tourist-feedback.component.html',
    styleUrls: ['../landing.component.scss', '../style.component.css']
  })

  export class TouristFeedbackComponent implements OnInit{

    touristId: string;
    ratings: DriverGuideRatingDto[];

    constructor(private authService: AuthService, private ratingService: DriverGuideRatingService,
        private dialog: MatDialog,private snackBar: MatSnackBar
    ) {}

    ngOnInit(): void {
       this.touristId = this.authService.getUserAccountId();
        this.getRating();
    }

    getRating(){
        this.ratingService.getTouristFeedback(this.touristId).subscribe(data => {
            this.ratings = data;
            console.log(this.ratings)
           });
    }

    showPopup: boolean = false;
    idToSend: string;
    rateType: string;
  
    openPopup(id: string, ty: string) {
      this.idToSend = id;
      this.rateType = ty;
      this.showPopup = true;
      console.log(id);
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
            this.deleteFeedback(id)
            this.snackBar.open('Delete Successfully!', 'Fechar', {
              duration: 2000,
            });
          }
        });
      }

    deleteFeedback(id: string){
        this.ratingService.deleteRate(id).subscribe(data => {
            this.getRating()
        })
    }

  }